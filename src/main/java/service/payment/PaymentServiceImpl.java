package service.payment;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import dao.PersonalPaymentDao;
import dao.PersonalPaymentDaoImpl;
import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dao.TeamPaymentDao;
import dao.TeamPaymentDaoImpl;
import dao.UserDao;
import dao.UserDaoImpl;
import dto.PersonalMatch;
import dto.PersonalPayment;
import dto.TeamMatch;
import dto.TeamPayment;
import util.PageInfo;

public class PaymentServiceImpl implements PaymentService {
	private PersonalPaymentDao personalPaymentDao;
	private TeamPaymentDao teamPaymentDao;
	// 마이페이지 결제 내역 생성
	private UserDao userDao;	
	
	public PaymentServiceImpl() {
		this.personalPaymentDao = new PersonalPaymentDaoImpl();
		this.teamPaymentDao = new TeamPaymentDaoImpl();
		// 마이페이지 결제 내역 생성
		this.userDao = new UserDaoImpl();		
	}
	
	// 마이페이지 결제 내역
	private static final int PAGE_SIZE = 10;
	private static final Map<String, String> CARD_ISSUER = new HashMap<>();
	static {
		// 토스페이먼츠 카드사 코드
		CARD_ISSUER.put("11", "국민카드");   CARD_ISSUER.put("21", "하나카드");
		CARD_ISSUER.put("41", "신한카드");   CARD_ISSUER.put("51", "삼성카드");
		CARD_ISSUER.put("61", "현대카드");   CARD_ISSUER.put("71", "롯데카드");
		CARD_ISSUER.put("91", "NH농협카드"); CARD_ISSUER.put("W1", "우리카드");
		CARD_ISSUER.put("33", "우리BC카드"); CARD_ISSUER.put("31", "BC카드");
		CARD_ISSUER.put("3K", "기업BC카드"); CARD_ISSUER.put("15", "카카오뱅크");
		CARD_ISSUER.put("24", "토스뱅크");   CARD_ISSUER.put("3A", "케이뱅크");
		CARD_ISSUER.put("36", "씨티카드");   CARD_ISSUER.put("37", "우체국카드");
		CARD_ISSUER.put("34", "수협카드");   CARD_ISSUER.put("38", "새마을금고");
		CARD_ISSUER.put("39", "저축은행");   CARD_ISSUER.put("62", "신협카드");
		CARD_ISSUER.put("30", "KDB산업은행"); CARD_ISSUER.put("35", "전북은행");
		CARD_ISSUER.put("42", "제주은행");   CARD_ISSUER.put("46", "광주은행");
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
	
	// 마이페이지 결제내역
	private Map<String, Object> buildHistoryParam(String keyword, Long userId, String status, String type, String period) {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("keyword", keyword == null ? null : keyword.trim());
		param.put("status", ("PAID".equals(status) || "REFUND".equals(status)) ? status : null);
		param.put("type", ("PERSONAL".equals(type) || "TEAM".equals(type)) ? type : null);
 
		LocalDate today = LocalDate.now();
		LocalDate start;
		if ("6m".equals(period)) start = today.minusMonths(6);
		else if ("year".equals(period)) start = LocalDate.of(today.getYear(), 1, 1);
		else start = today.minusMonths(3); // 기본 3개월
		param.put("startDate", Timestamp.valueOf(start.atStartOfDay()));
		return param;
	}
	
	//마이페이지 결재내역 페이징
	@Override
	public List<Map<String, Object>> MypagePaymentList(PageInfo pageInfo, String keyword, Long userId, String status,
			String type, String period) throws Exception {
		Map<String, Object> param = buildHistoryParam(keyword, userId, status, type, period);
		 
		int total = userDao.selectHistoryCount(param).intValue();
		
		int allPage = (int) Math.ceil(total / (double) PAGE_SIZE);
		int cur = (total == 0) ? 1 : Math.min(Math.max(pageInfo.getCurPage(), 1), allPage);
		int startPage = (cur - 1) / 10 * 10 + 1;
		int endPage = Math.min(startPage + 9, allPage);
		pageInfo.setTotalCnt(total);
		pageInfo.setCurPage(cur);
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
 
		param.put("limit", PAGE_SIZE);
		param.put("offset", (cur - 1) * PAGE_SIZE);
		List<Map<String, Object>> list = userDao.selectHistoryList(param);
 
		// 결제수단 표시 문자열 만들기 (간편결제 > 카드)
		for (Map<String, Object> row : list) {
			String easy = (String) row.get("easyPaymentProvider");
			String issuer = (String) row.get("cardCompany");
			String number = (String) row.get("cardNumber");
			String label;
			if (easy != null && !easy.isEmpty()) {
				label = easy;
			} else if (issuer != null && !issuer.isEmpty()) {
				label = CARD_ISSUER.getOrDefault(issuer, "카드")
						+ (number != null && !number.isEmpty() ? " " + number : "");
			} else {
				label = (String) row.get("paymentMethod");
			}
			row.put("methodLabel", label);
		}
		return list;
	}
	
	//마이페이지 결재내역 탭 카운트
	@Override
	public Map<String, Object> MypagePaymentSummary(String keyword, Long userId, String status, String type,
			String period) throws Exception {
		return userDao.selectHistorySummary(buildHistoryParam(keyword, userId, null, null, period));
	}
}
