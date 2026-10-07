package controller.admin;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.RevenueChart;
import service.admin.AdminRevenueService;
import service.admin.AdminRevenueServiceImpl;

/**
 * Servlet implementation class AdminRevenue
 */
@WebServlet("/admin/revenue")
public class AdminRevenue extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminRevenue() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminRevenueService service = new AdminRevenueServiceImpl();
		try {
			// 조회 기간 받기 (없으면 최근 7일)
			String startParam = request.getParameter("startDate");
			String endParam = request.getParameter("endDate");

			LocalDate endDate = (endParam == null || endParam.isEmpty()) ? LocalDate.now() : LocalDate.parse(endParam);
			LocalDate startDate = (startParam == null || startParam.isEmpty()) ? endDate.minusDays(6) : LocalDate.parse(startParam);

			// 시작일이 종료일보다 늦으면 서로 바꿈
			if (startDate.isAfter(endDate)) {
				LocalDate temp = startDate;
				startDate = endDate;
				endDate = temp;
			}
			
			Long totalRevenue = service.gettotalRevenue();
			Long totalProfit = service.gettotalProfit();
			Long monthlyRevenue = service.getmonthlyRevenue();
			Long monthlyProfit = service.getmonthlyProfit();
			List<RevenueChart> chartList = service.getSixMonthChart();
			Long periodPaymentCnt = service.getPeriodPaymentCnt(startDate, endDate);
			Long periodRevenueCnt = service.getPeriodRevenueCnt(startDate, endDate);
			Long periodProfitCnt = service.getPeriodProfitCnt(startDate, endDate);
			
			request.setAttribute("totalRevenue", totalRevenue);//총 매출
			request.setAttribute("totalProfit", totalProfit);//총 수익
			request.setAttribute("monthlyRevenue", monthlyRevenue);//이번달 월간 매출
			request.setAttribute("monthlyProfit", monthlyProfit);//이번달 월간 수익
			request.setAttribute("chartList", chartList);//이번달을 포함한 최근 6개월간의 월간 매출/수익 그래프
			request.setAttribute("periodPaymentCnt", periodPaymentCnt);//기간 내 결제 건수
			request.setAttribute("periodRevenueCnt", periodRevenueCnt);//기간 내 결제 건수
			request.setAttribute("periodProfitCnt", periodProfitCnt);//기간 내 결제 건수
			
			request.setAttribute("startDate", startDate);  // 달력에 표시할 시작일
			request.setAttribute("endDate", endDate);      // 달력에 표시할 종료일
			
			request.getRequestDispatcher("/jsp/admin/adminRevenue.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "에휴 ㅉㅉ");
		}
	}

}
