package service.payment;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import dao.PersonalPaymentDao;
import dao.PersonalPaymentDaoImpl;
import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dao.TeamPaymentDao;
import dao.TeamPaymentDaoImpl;
import dto.Notification;
import dto.PersonalMatch;
import dto.PersonalPayment;
import dto.TeamMatch;
import dto.TeamPayment;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;
import util.CardCompany;

public class PaymentServiceImpl implements PaymentService {
	private PersonalPaymentDao personalPaymentDao;
	private TeamPaymentDao teamPaymentDao;
	private NotificationService notificationService;

	public PaymentServiceImpl() {
		this.personalPaymentDao = new PersonalPaymentDaoImpl();
		this.teamPaymentDao = new TeamPaymentDaoImpl();
		this.notificationService = new NotificationServiceImpl();
	}

	// 결제 내역 + 참가자 등록
	@Override
	public void completePersonalPayment(String responseJson, Long userId, Long matchId) throws Exception {
		JSONObject json = new JSONObject(responseJson);
		PersonalPayment personal = new PersonalPayment();

		personal.setOrderId(json.getString("orderId"));
		personal.setPaymentKey(json.optString("paymentKey", "")); // 실제 응답의 paymentKey
		personal.setOrderName(json.getString("orderName"));
		personal.setPaymentStatus(json.getString("status"));
		personal.setPaymentMethod(json.getString("method"));
		personal.setTotalAmount(json.getInt("totalAmount"));
		personal.setBalance(json.getInt("balanceAmount"));
		personal.setCurrency(json.optString("currency", "KRW"));

		// 1. 날짜 처리 (ISO 8601: "2026-09-22T15:19:25+09:00" -> LocalDateTime)
		if (json.has("requestedAt") && !json.isNull("requestedAt")) {
			personal.setRequestedAt(OffsetDateTime.parse(json.getString("requestedAt")).toLocalDateTime());
		}
		if (json.has("approvedAt") && !json.isNull("approvedAt")) {
			personal.setApprovedAt(OffsetDateTime.parse(json.getString("approvedAt")).toLocalDateTime());
		}

		// 2. 간편결제(easyPay) 중첩 객체 처리
		if (json.has("easyPay") && !json.isNull("easyPay")) {
			JSONObject easyPay = json.getJSONObject("easyPay");
			personal.setEasyPaymentProvider(easyPay.optString("provider", null));
		}

		// 3. 카드(card) 중첩 객체 처리 (카카오페이 등에서는 null)
		if (json.has("card") && !json.isNull("card")) {
			JSONObject card = json.getJSONObject("card");
			personal.setCardCompany(CardCompany.nameOf(card.optString("issuerCode", null)));
			personal.setCardNumber(card.optString("number", null));
			personal.setInstallmentMonths(card.optInt("installmentPlanMonths", 0));
		}

		// 4. 영수증(receipt) URL 처리
		if (json.has("receipt") && !json.isNull("receipt")) {
			JSONObject receipt = json.getJSONObject("receipt");
			personal.setReceiptUrl(receipt.optString("url", null));
		}

		// 5. 응답 원본 전체 보관
		personal.setRawResponse(responseJson);
		personalPaymentDao.insertPersonalPaymentParticipant(personal, userId, matchId);

		// 6. 알림 : 참가자 + 모집자
		try {
			Map<String, Object> match = personalPaymentDao.selectPersonalMatchWriter(matchId);
			if (match != null) {
				Long writerId = ((Number) match.get("user_id")).longValue();
				String title = (String) match.get("title");
				String link = "/match/detail/view?personalMatchId=" + matchId;

				// 참가자 알림
				Notification joinAlarm = new Notification();
				joinAlarm.setUserId(userId);
				joinAlarm.setTitle("참가 확정");
				joinAlarm.setContent(title + " 참가가 확정되었습니다.");
				joinAlarm.setLink(link);
				notificationService.sendNotification(joinAlarm);

				// 모집자 알림
				Notification writerAlarm = new Notification();
				writerAlarm.setUserId(writerId);
				writerAlarm.setTitle("새 참가자");
				writerAlarm.setContent(title + "에 새 참가자가 있습니다.");
				writerAlarm.setLink(link);
				notificationService.sendNotification(writerAlarm);
			}
		} catch (Exception e) {
			e.printStackTrace(); // 알림 실패해도 결제는 유지
		}
	}

	@Override
	public void completeTeamPayment(String responseStr, Long userId, Long matchId, Long teamId) throws Exception {
		JSONObject json = new JSONObject(responseStr);
		TeamPayment team = new TeamPayment();

		team.setOrderId(json.getString("orderId"));
		team.setPaymentKey(json.optString("paymentKey", "")); // 실제 응답의 paymentKey
		team.setOrderName(json.getString("orderName"));
		team.setPaymentStatus(json.getString("status"));
		team.setPaymentMethod(json.getString("method"));
		team.setTotalAmount(json.getInt("totalAmount"));
		team.setBalance(json.getInt("balanceAmount"));
		team.setCurrency(json.optString("currency", "KRW"));

		// 날짜 처리
		if (json.has("requestedAt") && !json.isNull("requestedAt")) {
			team.setRequestedAt(OffsetDateTime.parse(json.getString("requestedAt")).toLocalDateTime());
		}
		if (json.has("approvedAt") && !json.isNull("approvedAt")) {
			team.setApprovedAt(OffsetDateTime.parse(json.getString("approvedAt")).toLocalDateTime());
		}

		// 간편결제 중첩 객체 처리
		if (json.has("easyPay") && !json.isNull("easyPay")) {
			JSONObject easyPay = json.getJSONObject("easyPay");
			team.setEasyPaymentProvider(easyPay.optString("provider", null));
		}

		// 카드 중첩 객체 처리
		if (json.has("card") && !json.isNull("card")) {
			JSONObject card = json.getJSONObject("card");
			team.setCardCompany(CardCompany.nameOf(card.optString("issuerCode", null)));
			team.setCardCompany(card.optString("issuerCode", null));
			team.setCardNumber(card.optString("number", null));
			team.setInstallmentMonths(card.optInt("installmentPlanMonths", 0));
		}

		// 영수증 URL 처리
		if (json.has("receipt") && !json.isNull("receipt")) {
			JSONObject receipt = json.getJSONObject("receipt");
			team.setReceiptUrl(receipt.optString("url", null));
		}

		// 응답 원본 전체 보관
		team.setRawResponse(responseStr);
		teamPaymentDao.insertTeamPaymentParticipant(team, userId, matchId, teamId);
		// 경기 정보 조회 (모집자, 제목, 모집 팀)
		Map<String, Object> match = teamPaymentDao.selectTeamMatchWriter(matchId);
		if (match == null)
			return;

		Long hostTeamId = ((Number) match.get("team_id")).longValue();
		boolean isHost = hostTeamId.equals(teamId); // 결제한 팀이 모집 팀인지

		// 상대 팀이 결제했을 때만 경기 마감
		if (!isHost) {
			TeamMatchDao teamMatchDao = new TeamMatchDaoImpl();
			teamMatchDao.updateStatusToClosed(matchId);
		}

		// 알림
		try {
			Long writerId = ((Number) match.get("user_id")).longValue();
			String title = (String) match.get("title");
			String link = "/team-match/detail/view?teamMatchId=" + matchId;

			if (isHost) {
				// 모집 팀 결제 : 결제한 사람에게만
				Notification hostAlarm = new Notification();
				hostAlarm.setUserId(userId);
				hostAlarm.setTitle("경기 등록 완료");
				hostAlarm.setContent(title + " 결제가 완료되어 상대 팀 모집을 시작합니다.");
				hostAlarm.setLink(link);
				notificationService.sendNotification(hostAlarm);
			} else {
				// 상대 팀 결제 : 결제한 사람 + 모집자
				Notification joinAlarm = new Notification();
				joinAlarm.setUserId(userId);
				joinAlarm.setTitle("매칭 확정");
				joinAlarm.setContent(title + " 매칭이 확정되었습니다.");
				joinAlarm.setLink(link);
				notificationService.sendNotification(joinAlarm);

				Notification writerAlarm = new Notification();
				writerAlarm.setUserId(writerId);
				writerAlarm.setTitle("매칭 완료");
				writerAlarm.setContent(title + " 상대 팀 매칭이 완료되었습니다.");
				writerAlarm.setLink(link);
				notificationService.sendNotification(writerAlarm);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public PersonalPayment getPersonalPaymentByPaymentKey(String paymentKey) throws Exception {
		return personalPaymentDao.selectPersonalPaymentHistory(paymentKey);
	}

	@Override
	public TeamPayment getTeamPaymentByPaymentKey(String paymentKey) throws Exception {
		return teamPaymentDao.selectTeamPaymentHistory(paymentKey);
	}

	// 개인 결제 검증
	@Override
	public Integer getPersonalMatchTotalAmount(Integer matchId) throws Exception {
		return personalPaymentDao.selectPersonalMatchTotalAmount(matchId);
	}

	@Override
	public Integer getTeamMatchTotalAmount(Integer matchId) throws Exception {
		return teamPaymentDao.selectTeamMatchTotalAmount(matchId);
	}

	// 개인 경기정보
	@Override
	public PersonalMatch getPersonalPaymentMatch(String paymentKey) throws Exception {
		return personalPaymentDao.selectPersonalPaymentMatch(paymentKey);
	}

	// 팀 경기정보
	@Override
	public TeamMatch getTeamPaymentMatch(String paymentKey) throws Exception {
		return teamPaymentDao.selectTeamPaymentMatch(paymentKey);
	}

	// 특정 팀경기 정보
	@Override
	public TeamMatch getTeamMatch(Long matchId) throws Exception {
		return teamPaymentDao.selectTeamMatch(matchId);
	}

	// 중복참가 확인
	@Override
	public boolean isAlreadyJoined(Long userId, Long matchId, boolean isTeam) throws Exception {
		int cnt = isTeam ? teamPaymentDao.selectTeamJoinCnt(userId, matchId)
				: personalPaymentDao.selectPersonalJoinCnt(userId, matchId);
		return cnt > 0;
	}

	// 개인 경기 결제 취소
	@Override
	public void refundPersonalPayment(String paymentKey, Long userId, String reason, String secretKey)
			throws Exception {
		Map<String, Object> search = new HashMap<>();
		search.put("paymentKey", paymentKey);
		search.put("userId", userId);

		Map<String, Object> target = personalPaymentDao.selectRefundTarget(search);
		if (target == null)
			throw new IllegalStateException("본인 결제만 환불 할 수 있습니다.");
		// 모집자
		Long writerId = ((Number) target.get("user_id")).longValue();
		// 1. 검증
		if (writerId.equals(userId))
			throw new IllegalStateException("모집자는 환불할 수 없습니다.");
		if ("CANCELED".equals(target.get("payment_status")))
			throw new IllegalStateException("이미 환불된 결제입니다.");

		LocalDateTime deadline = ((Timestamp) target.get("deadline")).toLocalDateTime();
		if (!LocalDateTime.now().isBefore(deadline)) {
			throw new IllegalStateException("모집 마감 이후에는 환불할 수 없습니다.");
		}

		// 2. 토스 결제 취소 (성공해야 다음 단계 진행)
		JSONObject result = cancelPayment(paymentKey, reason, secretKey);

		// 취소 응답의 cancels 배열 마지막 항목 = 방금 한 취소
		JSONArray cancels = result.getJSONArray("cancels");
		JSONObject cancel = cancels.getJSONObject(cancels.length() - 1);

		// 3. DB 변경 : 결제 취소 + 참가 취소
		Map<String, Object> param = new HashMap<>();
		param.put("paymentId", ((Number) target.get("payment_id")).longValue());
		param.put("canceledAt", OffsetDateTime.parse(cancel.getString("canceledAt")).toLocalDateTime());
		param.put("cancelReason", cancel.optString("cancelReason", reason));
		param.put("cancelAmount", cancel.getInt("cancelAmount"));
		personalPaymentDao.updateRefund(param);

		// 4. 알림 : 모집자에게 (실패해도 환불은 유지)
		try {
			String title = (String) target.get("title");
			Notification alarm = new Notification();
			alarm.setUserId(writerId);
			alarm.setTitle("참가 취소");
			alarm.setContent(title + " 참가자 한 명이 참가를 취소했습니다.");
			alarm.setLink("/match/detail/view?personalMatchId=" + target.get("personal_match_id"));
			notificationService.sendNotification(alarm);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 토스 결제 취소 호출 (서비스 내부 전용)
	private JSONObject cancelPayment(String paymentKey, String reason, String secretKey) throws Exception {
		String authHeader = "Basic "
				+ Base64.getEncoder().encodeToString((secretKey + ":").getBytes(StandardCharsets.UTF_8));

		URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		try {
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", authHeader);
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Idempotency-Key", "refund-" + paymentKey); // 중복 취소 방지
			conn.setDoOutput(true);

			JSONObject body = new JSONObject();
			body.put("cancelReason", reason);
			try (OutputStream os = conn.getOutputStream()) {
				os.write(body.toString().getBytes(StandardCharsets.UTF_8));
			}

			int status = conn.getResponseCode();
			InputStream is = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();
			StringBuilder sb = new StringBuilder();
			try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
				String line;
				while ((line = br.readLine()) != null)
					sb.append(line);
			}

			if (status < 200 || status >= 300) {
				System.out.println("토스 취소 실패 : " + sb);
				throw new IllegalStateException("토스 결제 취소에 실패했습니다.");
			}
			return new JSONObject(sb.toString());
		} finally {
			conn.disconnect();
		}
	}

	//모집 팀 결제 자동 환불 (스케줄러 용)
	//환불하면 true, 환불 할 결제가 없으면 false
	@Override
	public boolean autoRefundHostTeamPayment(Long matchId, String secretKey) throws Exception {
		Map<String, Object> target = teamPaymentDao.selectHostTeamPayment(matchId);
		if(target == null) return false; //결제 안했거나 이미 환불됨
		
		String paymentKey = (String) target.get("payment_key");
		String reason = "모집 기간 내 상대 팀 미매칭";
		
		//토스 결제 취소 (성공해야 다음 단계 진행)
		JSONObject result = cancelPayment(paymentKey, reason, secretKey);
		JSONArray cancels = result.getJSONArray("cancels");
		JSONObject cancel = cancels.getJSONObject(cancels.length() - 1);
		int cancelAmount = cancel.getInt("cancelAmount");
		
		//결제 취소 + 참가 취소
		Map<String, Object> param = new HashMap<>();
		param.put("paymentId", ((Number)target.get("payment_id")).longValue());
		param.put("canceledAt", OffsetDateTime.parse(cancel.getString("canceledAt")).toLocalDateTime());
		param.put("cancelReason", cancel.optString("cancelReason", reason));
		param.put("cancelAmount", cancelAmount);
		teamPaymentDao.updateTeamPaymentRefund(param);
		
		//환불 알림 : 결제한 사람에게
		try {
			Long payerId = ((Number) target.get("user_id")).longValue();
			String title = (String) target.get("title");
			
			Notification alarm = new Notification();
			alarm.setUserId(payerId);
			alarm.setTitle("참가비 환불 완료");
			alarm.setContent("'"+ title + "' 경기가 모집 기간 내 상대 팀이 없어 결제하신 "
					+ String.format("%,d", cancelAmount) + "원이 환불되었습니다.");
			alarm.setLink("/team-match/detail/view?teamMatchId="+matchId);
			notificationService.sendNotification(alarm);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	//개인 경기 최소 인원 미달 자동 환불 (스케줄러 용)
	//전원 환불 성공하면 true, 한 건이라도 실패하면 false
	@Override
	public boolean autoRefundPersonalMatch(Long matchId, String title, String secretKey) throws Exception {
		List<Map<String, Object>> targets = personalPaymentDao.selectPaidPaymentsByMatch(matchId);
		String reason = "모집 기간 내 최소 인원 미달";
		boolean allSuccess = true;

		for (Map<String, Object> target : targets) {
			try {
				String paymentKey = (String) target.get("payment_key");

				//토스 결제 취소 (성공해야 다음 단계 진행)
				JSONObject result = cancelPayment(paymentKey, reason, secretKey);
				JSONArray cancels = result.getJSONArray("cancels");
				JSONObject cancel = cancels.getJSONObject(cancels.length() - 1);
				int cancelAmount = cancel.getInt("cancelAmount");

				//결제 취소 + 참가 취소
				Map<String, Object> param = new HashMap<>();
				param.put("paymentId", ((Number) target.get("payment_id")).longValue());
				param.put("canceledAt", OffsetDateTime.parse(cancel.getString("canceledAt")).toLocalDateTime());
				param.put("cancelReason", cancel.optString("cancelReason", reason));
				param.put("cancelAmount", cancelAmount);
				personalPaymentDao.updateRefund(param);

				//환불 알림 (실패해도 환불은 유지)
				try {
					Notification alarm = new Notification();
					alarm.setUserId(((Number) target.get("user_id")).longValue());
					alarm.setTitle("참가비 환불 완료");
					alarm.setContent("'" + title + "' 경기가 최소 인원을 채우지 못해 취소되어 결제하신 "
							+ String.format("%,d", cancelAmount) + "원이 환불되었습니다.");
					alarm.setLink("/match/detail/view?personalMatchId=" + matchId);
					notificationService.sendNotification(alarm);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} catch (Exception e) {
				//한 명 실패해도 나머지 참가자는 계속 환불
				e.printStackTrace();
				allSuccess = false;
			}
		}
		return allSuccess;
	}
}
