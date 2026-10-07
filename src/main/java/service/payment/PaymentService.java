package service.payment;

import dto.PersonalPayment;
import dto.TeamPayment;

public interface PaymentService {
	void completePersonalPayment(String responseStr) throws Exception;
	void completeTeamPayment(String responseStr) throws Exception;
	PersonalPayment getPersonalPaymentByPaymentKey(String paymentKey) throws Exception;
	TeamPayment getTeamPaymentByPaymentKey(String paymentKey) throws Exception;
}
