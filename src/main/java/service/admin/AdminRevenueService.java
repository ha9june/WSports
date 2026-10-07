package service.admin;

import java.time.LocalDate;
import java.util.List;

import dto.RevenueChart;

public interface AdminRevenueService {
	Long gettotalRevenue() throws Exception;//총 매출
	Long gettotalProfit() throws Exception;//총 수익
	Long getmonthlyRevenue() throws Exception;//이번달 월간 매출
	Long getmonthlyProfit() throws Exception;//이번달 월간 수익
	List<RevenueChart> getSixMonthChart() throws Exception; //이번달을 포함한 최근 6개월간의 월간 매출수익 그래프
	Long getPeriodPaymentCnt(LocalDate startDate, LocalDate endDate) throws Exception;//기간 내 결제 건수
	Long getPeriodRevenueCnt(LocalDate startDate, LocalDate endDate) throws Exception;//기간 내 결제 건수
	Long getPeriodProfitCnt(LocalDate startDate, LocalDate endDate) throws Exception;//기간 내 결제 건수
}
