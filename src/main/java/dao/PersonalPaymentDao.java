package dao;

import java.util.Map;

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
}
