package service.payment;

import java.time.OffsetDateTime;

import org.json.JSONObject;

import dao.PersonalPaymentDao;
import dao.PersonalPaymentDaoImpl;
import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dao.TeamPaymentDao;
import dao.TeamPaymentDaoImpl;
import dto.PersonalMatch;
import dto.PersonalPayment;
import dto.TeamMatch;
import dto.TeamPayment;

public class PaymentServiceImpl implements PaymentService {
	private PersonalPaymentDao personalPaymentDao;
	private TeamPaymentDao teamPaymentDao;
	public PaymentServiceImpl() {
		this.personalPaymentDao = new PersonalPaymentDaoImpl();
		this.teamPaymentDao = new TeamPaymentDaoImpl();
	}
	//결제 내역 + 참가자 등록
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
		    personal.setCardCompany(card.optString("issuerCode", null));
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
		personalPaymentDao.insertPersonalPaymentParticipant(personal,userId, matchId);
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

		// 1. 날짜 처리 (ISO 8601: "2026-09-22T15:19:25+09:00" -> LocalDateTime)
		if (json.has("requestedAt") && !json.isNull("requestedAt")) {
			team.setRequestedAt(OffsetDateTime.parse(json.getString("requestedAt")).toLocalDateTime());
		}
		if (json.has("approvedAt") && !json.isNull("approvedAt")) {
			team.setApprovedAt(OffsetDateTime.parse(json.getString("approvedAt")).toLocalDateTime());
		}

		// 2. 간편결제(easyPay) 중첩 객체 처리
		if (json.has("easyPay") && !json.isNull("easyPay")) {
		    JSONObject easyPay = json.getJSONObject("easyPay");
		    team.setEasyPaymentProvider(easyPay.optString("provider", null));
		}

		// 3. 카드(card) 중첩 객체 처리 (카카오페이 등에서는 null)
		if (json.has("card") && !json.isNull("card")) {
		    JSONObject card = json.getJSONObject("card");
		    team.setCardCompany(card.optString("issuerCode", null));
		    team.setCardNumber(card.optString("number", null));
		    team.setInstallmentMonths(card.optInt("installmentPlanMonths", 0));
		}

		// 4. 영수증(receipt) URL 처리
		if (json.has("receipt") && !json.isNull("receipt")) {
		    JSONObject receipt = json.getJSONObject("receipt");
		    team.setReceiptUrl(receipt.optString("url", null));
		}
		TeamMatchDao teamMatchDao = new TeamMatchDaoImpl();
		teamMatchDao.updateStatusToClosed(matchId);
		// 5. 응답 원본 전체 보관
		team.setRawResponse(responseStr);		
		teamPaymentDao.insertTeamPaymentParticipant(team, userId, matchId, teamId);
	}


	@Override
	public PersonalPayment getPersonalPaymentByPaymentKey(String paymentKey) throws Exception {
		return personalPaymentDao.selectPersonalPaymentHistory(paymentKey);
	}

	@Override
	public TeamPayment getTeamPaymentByPaymentKey(String paymentKey) throws Exception {
		return teamPaymentDao.selectTeamPaymentHistory(paymentKey);
	}
	//개인 결제 검증
	@Override
	public Integer getPersonalMatchTotalAmount(Integer matchId) throws Exception {
		return personalPaymentDao.selectPersonalMatchTotalAmount(matchId);
	}
	@Override
	public Integer getTeamMatchTotalAmount(Integer matchId) throws Exception {
		return teamPaymentDao.selectTeamMatchTotalAmount(matchId);
	}
	//개인 경기정보
	@Override
	public PersonalMatch getPersonalPaymentMatch(String paymentKey) throws Exception {
		return personalPaymentDao.selectPersonalPaymentMatch(paymentKey);
	}
	//팀 경기정보
	@Override
	public TeamMatch getTeamPaymentMatch(String paymentKey) throws Exception {
		return teamPaymentDao.selectTeamPaymentMatch(paymentKey);
	}
	//특정 팀경기 정보
	@Override
	public TeamMatch getTeamMatch(Long matchId) throws Exception {
		return teamPaymentDao.selectTeamMatch(matchId);
	}
	//중복참가 확인
	@Override
	public boolean isAlreadyJoined(Long userId, Long matchId, boolean isTeam) throws Exception {
		int cnt = isTeam
				? teamPaymentDao.selectTeamJoinCnt(userId, matchId)
				: personalPaymentDao.selectPersonalJoinCnt(userId, matchId);
		return cnt > 0;
	}

}
