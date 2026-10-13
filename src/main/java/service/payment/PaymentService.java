package service.payment;

import java.util.List;
import java.util.Map;

import dto.PersonalMatch;
import dto.PersonalPayment;
import dto.PersonalSettlement;
import dto.TeamMatch;
import dto.TeamPayment;
import util.PageInfo;

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
	
	// 마이페이지 결제내역
	List<Map<String, Object>> MypagePaymentList(PageInfo pageInfo, String keyword, Long userId, String status, String type, String period) throws Exception;
	Map<String, Object> MypagePaymentSummary(String keyword, Long userId, String status, String type, String period) throws Exception;

	//개인 경기 환불
	void refundPersonalPayment(String paymentKey, Long userId, String reason, String secretKey) throws Exception;
	//모집 기간 내 상대 팀이 없을 때 모집 팀 결제 자동 환불 (스케줄러 용)
	boolean autoRefundHostTeamPayment(Long matchId, String secretKey) throws Exception;
	//개인경기 최소 인원 미달 자동 환불 (스케줄러 용)
	boolean autoRefundPersonalMatch(Long matchId, String title, String secretKey) throws Exception;
	//경기 종료 시 개인경기 정산 내역에 추가하기
	Long putPersonalSettlement(PersonalSettlement ps) throws Exception;
	//팀 경기 결제 취소 : 주최팀 모집자 본인 + 상대 팀 결제 전 + 모집 마감 전
	void refundTeamPayment(String paymentKey, Long userId, String reason, String secretKey) throws Exception;
	
	String getPaymentKey(Long userId,Long matchId,String matchType) throws Exception;

}
