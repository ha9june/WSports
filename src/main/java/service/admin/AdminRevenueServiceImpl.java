package service.admin;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.PersonalPaymentDao;
import dao.PersonalPaymentDaoImpl;
import dao.TeamPaymentDao;
import dao.TeamPaymentDaoImpl;
import dto.RevenueChart;

public class AdminRevenueServiceImpl implements AdminRevenueService {
	private PersonalPaymentDao personalPaymentDao;
	private TeamPaymentDao teamPaymentDao;
	
	public AdminRevenueServiceImpl() {
		this.personalPaymentDao = new PersonalPaymentDaoImpl();
		this.teamPaymentDao = new TeamPaymentDaoImpl();
	}
	
	//총 매출
	@Override
	public Long gettotalRevenue() throws Exception {
		return personalPaymentDao.totalRevenuePersonal() 
					 + teamPaymentDao.totalRevenueTeam();
	}
	//총 수익
	@Override
	public Long gettotalProfit() throws Exception {
		return personalPaymentDao.totalProfitPersonal() 
				     + teamPaymentDao.totalProfitTeam();
	}
	//이번달 월간 매출
	@Override
	public Long getmonthlyRevenue() throws Exception {
		return personalPaymentDao.monthlyRevenuePersonal() 
				   + teamPaymentDao.monthlyRevenueTeam();
	}
	//이번달 월간 수익
	@Override
	public Long getmonthlyProfit() throws Exception {
		return personalPaymentDao.monthlyProfitPersonal() 
				   + teamPaymentDao.monthlyProfitTeam();
	}
	//기간 내 결제 건수
	@Override
	public Long getPeriodPaymentCnt(LocalDate startDate, LocalDate endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("startDate", startDate.toString());
		param.put("endDate", endDate.toString());
		return personalPaymentDao.selectPeriodPaymentCntPersonal(param) 
				   + teamPaymentDao.selectPeriodPaymentCntTeam(param);
	}
	//기간 내 총 매출
	@Override
	public Long getPeriodRevenueCnt(LocalDate startDate, LocalDate endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("startDate", startDate.toString());
		param.put("endDate", endDate.toString());
		return personalPaymentDao.selectPeriodRevenuePersonal(param) 
				   + teamPaymentDao.selectPeriodRevenueTeam(param);
	}
	//기간 내 총 수익
	@Override
	public Long getPeriodProfitCnt(LocalDate startDate, LocalDate endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("startDate", startDate.toString());
		param.put("endDate", endDate.toString());
		return personalPaymentDao.selectPeriodProfitPersonal(param) 
				   + teamPaymentDao.selectPeriodProfitTeam(param);
	}
	//이번달을 포함한 최근 6개월간의 월간 매출수익 그래프
	@Override
	public List<RevenueChart> getSixMonthChart() throws Exception {
		List<RevenueChart> list = new ArrayList<>();
		LocalDate now = LocalDate.now();
		long max = 0;
		// n = 5(5개월 전) → 0(이번 달) : 그래프 왼쪽부터 오래된 달
		for(int n=5;n>=0; n--) {
			long revenue = personalPaymentDao.sixMonthlyRevenuePersonal(n)
						 + teamPaymentDao.sixMonthlyRevenueTeam(n);
			long profit = (long) Math.floor(revenue*0.08);
			
			RevenueChart chart = new RevenueChart();
			chart.setMonth(now.minusMonths(n).getMonthValue() + "월");
			chart.setRevenue(revenue);
			chart.setProfit(profit);
			list.add(chart);
			
			max = Math.max(max, revenue);
		}
		
		//가장 큰 매출을 100%로 막대 높이 계산
		for(RevenueChart chart : list) {
			if(max>0) {
				chart.setRevenueHeight((int) (chart.getRevenue()*100/max));
				chart.setProfitHeight((int) (chart.getProfit()*100/max));
			}
		}
		return list;
	}

}
