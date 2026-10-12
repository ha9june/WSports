package service.payment;

import dto.PersonalMatch;
import dto.PersonalPayment;
import dto.TeamMatch;
import dto.TeamPayment;

public interface PaymentService {
	//알림 넣어라
	void completePersonalPayment(String responseJson, Long userId, Long matchId) throws Exception;
	void completeTeamPayment(String responseStr, Long userId, Long matchId, Long teamId) throws Exception;
	PersonalPayment getPersonalPaymentByPaymentKey(String paymentKey) throws Exception;
	TeamPayment getTeamPaymentByPaymentKey(String paymentKey) throws Exception;
	//검증 - 개인
	Integer getPersonalMatchTotalAmount(Integer matchId) throws Exception;
	//검증 - 팀
	Integer getTeamMatchTotalAmount(Integer matchId) throws Exception;

	//경기정보 가져오기 -개인
	PersonalMatch getPersonalPaymentMatch(String paymentKey) throws Exception;
	//경기정보 가져오기 - 팀
	TeamMatch getTeamPaymentMatch(String paymentKey) throws Exception;
	
	//팀 경기 한건 죄회
	TeamMatch getTeamMatch(Long matchId) throws Exception;
	//중복 참가 확인
	boolean isAlreadyJoined(Long userId, Long matchId, boolean isTeam) throws Exception;
	//개인 경기 환불
	void refundPersonalPayment(String paymentKey, Long userId, String reason, String secretKey) throws Exception;
	//모집 기간 내 상대 팀이 없을 때 모집 팀 결제 자동 환불 (스케줄러 용)
	boolean autoRefundHostTeamPayment(Long matchId, String secretKey) throws Exception;
}
