package service.payment;

import java.time.OffsetDateTime;

import org.json.JSONObject;

import dao.PersonalPaymentDao;
import dao.PersonalPaymentDaoImpl;
import dao.TeamPaymentDao;
import dao.TeamPaymentDaoImpl;
import dto.PersonalPayment;
import dto.TeamPayment;

public class PaymentServiceImpl implements PaymentService {
	private PersonalPaymentDao personalPaymentDao;
	private TeamPaymentDao teamPaymentDao;
	public PaymentServiceImpl() {
		this.personalPaymentDao = new PersonalPaymentDaoImpl();
		this.teamPaymentDao = new TeamPaymentDaoImpl();
	}
	@Override
	public void completePersonalPayment(String responseStr) throws Exception {
		JSONObject json = new JSONObject(responseStr);	
		PersonalPayment personal = new PersonalPayment();
		
		personal.setOrderId(json.getString("orderId"));
		personal.setPaymentKey(json.optString("paymentKey", "")); // 실제 응답의 paymentKey
		personal.setOrderName(json.getString("orderName"));
		personal.setPaymentStatus(json.getString("status"));
		personal.setPaymentMethod(json.getString("paymentmethod"));
		personal.setTotalAmount(json.getInt("totalAmount"));
		personal.setBalance(json.getInt("balance"));
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
		personal.setRawResponse(responseStr);		
		personalPaymentDao.insertPaymentHistory(personal);
	}

	@Override
	public void completeTeamPayment(String responseStr) throws Exception {
		JSONObject json = new JSONObject(responseStr);	
		TeamPayment team = new TeamPayment();
		
		team.setOrderId(json.getString("orderId"));
		team.setPaymentKey(json.optString("paymentKey", "")); // 실제 응답의 paymentKey
		team.setOrderName(json.getString("orderName"));
		team.setPaymentStatus(json.getString("status"));
		team.setPaymentMethod(json.getString("paymentmethod"));
		team.setTotalAmount(json.getInt("totalAmount"));
		team.setBalance(json.getInt("balance"));
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

		// 5. 응답 원본 전체 보관
		team.setRawResponse(responseStr);		
		teamPaymentDao.insertPaymentHistory(team);
	}


	@Override
	public PersonalPayment getPersonalPaymentByPaymentKey(String paymentKey) throws Exception {
		return personalPaymentDao.selectPaymentHistory(paymentKey);
	}

	@Override
	public TeamPayment getTeamPaymentByPaymentKey(String paymentKey) throws Exception {
		return teamPaymentDao.selectPaymentHistory(paymentKey);
	}

}
