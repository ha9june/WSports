package dto;

public class RevenueChart {
	private String month;       // 달
	private long revenue;       // 매출
	private long profit;        // 수익
	private int revenueHeight;  // 매출 막대 높이
	private int profitHeight;   // 수익 막대 높이
	
	public RevenueChart() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RevenueChart(String month, long revenue, long profit, int revenueHeight, int profitHeight) {
		super();
		this.month = month;
		this.revenue = revenue;
		this.profit = profit;
		this.revenueHeight = revenueHeight;
		this.profitHeight = profitHeight;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public long getRevenue() {
		return revenue;
	}

	public void setRevenue(long revenue) {
		this.revenue = revenue;
	}

	public long getProfit() {
		return profit;
	}

	public void setProfit(long profit) {
		this.profit = profit;
	}

	public int getRevenueHeight() {
		return revenueHeight;
	}

	public void setRevenueHeight(int revenueHeight) {
		this.revenueHeight = revenueHeight;
	}

	public int getProfitHeight() {
		return profitHeight;
	}

	public void setProfitHeight(int profitHeight) {
		this.profitHeight = profitHeight;
	}

	@Override
	public String toString() {
		return "RevenueChart [month=" + month + ", revenue=" + revenue + ", profit=" + profit + ", revenueHeight="
				+ revenueHeight + ", profitHeight=" + profitHeight + "]";
	}
	
}
