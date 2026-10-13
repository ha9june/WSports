package controller.payment;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;
import util.PageInfo;

/**
 * Servlet implementation class PaymentHistoryList
 */
@WebServlet("/payment/history/list")
public class PaymentHistoryList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentHistoryList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User loginUser = (User) request.getSession().getAttribute("user");
		Long userId = loginUser.getUserId();
		
		// 검색 기능
		String period = request.getParameter("period");
		if (!"6m".equals(period) && !"year".equals(period)) period = "3m";
		String keyword = request.getParameter("keyword");
		if (keyword != null && keyword.trim().isEmpty()) keyword = null;
		String status = request.getParameter("status");
		if (!"PAID".equals(status) && !"REFUND".equals(status)) status = null;
		String type = request.getParameter("type");
		if (!"PERSONAL".equals(type) && !"TEAM".equals(type)) type = null;
		
		String tab = "ALL";
		if (status != null) tab = status;
		else if (type != null) tab = type;
		
		int page = 1;
		try {
			String sPage = request.getParameter("page");
			if (sPage != null && !sPage.isEmpty()) page = Math.max(1, Integer.parseInt(sPage));
		} catch (NumberFormatException e) {
			page = 1;
		}
 
		PageInfo pageInfo = new PageInfo(page);
		PaymentService service = new PaymentServiceImpl();
		try {
			List<Map<String, Object>> paymentList = service.MypagePaymentList(pageInfo, keyword, userId, status, type, period);
			Map<String, Object> summary = service.MypagePaymentSummary(keyword, userId, status, type, period);
			
			request.setAttribute("paymentList", paymentList);
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("summary", summary);
			request.setAttribute("tab", tab);
			request.setAttribute("period", period);
			request.setAttribute("keyword", keyword);
			request.setAttribute("status", status);
			request.setAttribute("type", type);
			request.getRequestDispatcher("/jsp/payment/paymentList.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}