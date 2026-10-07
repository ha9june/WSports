package dao;

import java.util.Map;

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
	
}
