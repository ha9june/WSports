package dao;

import java.util.Map;

import dto.PersonalPayment;
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
	
}
