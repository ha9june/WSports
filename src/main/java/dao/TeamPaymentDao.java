package dao;

import java.util.Map;

import dto.TeamMatch;
import dto.TeamPayment;

public interface TeamPaymentDao {
	Long totalRevenueTeam() throws Exception; //총 매출
	Long totalProfitTeam() throws Exception; //총 수익
	Long monthlyRevenueTeam() throws Exception; //이번달 월간 매출
	Long monthlyProfitTeam() throws Exception; //이번달 월간 수익
	Long sixMonthlyRevenueTeam(int n) throws Exception; //이번달을 포함한 최근 6개월간의 월간 매출
	Long sixMonthlyProfitTeam(int n) throws Exception; //이번달을 포함한 최근 6개월간의 월간 수익
	Long selectPeriodPaymentCntTeam(Map<String, Object> param) throws Exception; //기간 내 결제 건수
	Long selectPeriodRevenueTeam(Map<String, Object> param) throws Exception; //기간 내 총 매출
	Long selectPeriodProfitTeam(Map<String, Object> param) throws Exception; //기간 내 총 수익
	
	//결제내역 삽입
	void insertTeamPaymentParticipant(TeamPayment teamPayment, Long userID, Long matchId, Long teamId) throws Exception;
	//결제내역 선택
	TeamPayment selectTeamPaymentHistory(String paymentKey) throws Exception;	
	//검증
	Integer selectTeamMatchTotalAmount(Integer matchId) throws Exception;
	//경기정보 가져오기
	TeamMatch selectTeamPaymentMatch(String paymentKey) throws Exception;
	//팀 경기 한 건 조회
	TeamMatch selectTeamMatch(Long matchId) throws Exception;
	//중복참가 확인
	Integer selectTeamJoinCnt(Long userId, Long matchId) throws Exception;
	//팀 경기 모집자, 제목
	Map<String, Object> selectTeamMatchWriter(Long matchId) throws Exception;
	
	//모집팀 결제 조회 : 스케줄러 자동 환불용
	Map<String, Object> selectHostTeamPayment(Long matchId) throws Exception;
	//결제 취소 + 참가 취소 (경기 상태는 변경하지 않음)
	void updateTeamPaymentRefund(Map<String, Object> param) throws Exception;
	//팀 환불 대상 조회 (본인 + 주최팀 결제)
	Map<String, Object> selectTeamRefundTarget(Map<String, Object> param) throws Exception;
	//주최팀 환불 : 결제 취소 + 참가 취소 + 경기 취소(한 트랜잭션), 경기 취소된 행 수 반환
	Integer updateTeamHostRefund(Map<String, Object> param) throws Exception;
	
	//결제번호 가져오기
	String selectPaymentKey(Map<String, Object> param) throws Exception;
}
