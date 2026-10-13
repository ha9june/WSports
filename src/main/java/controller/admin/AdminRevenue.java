package controller.admin;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
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
	    LocalDate endDate;
	    LocalDate startDate;
	    
		try {
			// 조회 기간 받기 (없으면 최근 7일)
			String startParam = request.getParameter("startDate");
			String endParam = request.getParameter("endDate");

			endDate = (endParam == null || endParam.isEmpty()) ? LocalDate.now() : LocalDate.parse(endParam);
			startDate = (startParam == null || startParam.isEmpty()) ? endDate.minusDays(6) : LocalDate.parse(startParam);
		}catch (DateTimeParseException e) {
		    // 잘못된 날짜가 오면 기본값(최근 7일)으로
		    endDate = LocalDate.now();
		    startDate = endDate.minusDays(6);
		}
		// 시작일이 종료일보다 늦으면 서로 바꿈
		if (startDate.isAfter(endDate)) {
			LocalDate temp = startDate;
			startDate = endDate;
			endDate = temp;
		}
		try {
			request.setAttribute("totalRevenue", service.gettotalRevenue());//총 매출
			request.setAttribute("totalProfit", service.gettotalProfit());//총 수익
			request.setAttribute("monthlyRevenue", service.getmonthlyRevenue());//이번달 월간 매출
			request.setAttribute("monthlyProfit", service.getmonthlyProfit());//이번달 월간 수익
			request.setAttribute("chartList", service.getSixMonthChart());//이번달을 포함한 최근 6개월간의 월간 매출/수익 그래프
			request.setAttribute("periodPaymentCnt", service.getPeriodPaymentCnt(startDate, endDate));//기간 내 결제 건수
			request.setAttribute("periodRevenueCnt", service.getPeriodRevenueCnt(startDate, endDate));//기간 내 결제 건수
			request.setAttribute("periodProfitCnt", service.getPeriodProfitCnt(startDate, endDate));//기간 내 결제 건수
		
			request.setAttribute("startDate", startDate);  // 달력에 표시할 시작일
			request.setAttribute("endDate", endDate);      // 달력에 표시할 종료일
			
			request.getRequestDispatcher("/jsp/admin/adminRevenue.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "매출 정보를 불러오는 중 요류가 발생했습니다.");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

}
