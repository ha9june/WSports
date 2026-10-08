package dao;

import java.util.Map;

import dto.PersonalMatch;
import dto.PersonalPayment;

public interface PersonalPaymentDao {
	Long totalRevenuePersonal() throws Exception;//총 매출
	Long totalProfitPersonal() throws Exception; //총 수익
	Long monthlyRevenuePersonal() throws Exception; //이번달 월간 매출
	Long monthlyProfitPersonal() throws Exception; //이번달 월간 수익
	Long sixMonthlyRevenuePersonal(int n) throws Exception; //이번달을 포함한 최근 6개월간의 월간 매출
	Long sixMonthlyProfitPersonal(int n) throws Exception; //이번달을 포함한 최근 6개월간의 월간 수익
	Long selectPeriodPaymentCntPersonal(Map<String, Object> param) throws Exception; //기간 내 결제 건수
	Long selectPeriodRevenuePersonal(Map<String, Object> param) throws Exception; //기간 내 총 매출
	Long selectPeriodProfitPersonal(Map<String, Object> param) throws Exception; //기간 내 총 수익
	
	//결제내역 선택
	PersonalPayment selectPersonalPaymentHistory(String paymentKey) throws Exception;
	//검증
	Integer selectPersonalMatchTotalAmount(Integer matchId) throws Exception;
	//결제 내역 + 참가자 등록
	void insertPersonalPaymentParticipant(PersonalPayment personalPayment, Long userId, Long matchId) throws Exception;
	//경기정보 가져오기
	PersonalMatch selectPersonalPaymentMatch(String paymentKey) throws Exception;
	//중복참가 확인
	Integer selectPersonalJoinCnt(Long userId, Long matchId) throws Exception;
	
	
}
