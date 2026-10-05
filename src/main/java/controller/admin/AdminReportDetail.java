package controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.admin.AdminReportServiceImpl;

/**
 * Servlet implementation class AdminReportDetail
 */
@WebServlet("/admin/report/detail")
public class AdminReportDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminReportDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminReportServiceImpl service = new AdminReportServiceImpl();
		try {
			Long reportId = Long.parseLong(request.getParameter("reportId"));
			Map<String, Object> reportdetail = service.getAdminReportDetail(reportId);
			request.setAttribute("reportdetail", reportdetail);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "정산관리 목록 조회 오류");
		}
		request.getRequestDispatcher("/jsp/admin/adminReportDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("세션 user : " + request.getSession().getAttribute("user"));
		AdminReportServiceImpl service = new AdminReportServiceImpl();
		try {
			// 지금 로그인한 관리자 번호 (세션에서)
			User user = (User) request.getSession().getAttribute("user");
			Long adminId = user.getUserId();
			
			Long reportId = Long.parseLong(request.getParameter("reportId"));
			String answer = request.getParameter("answer");
			
			service.AdminReportAnswer(reportId, answer, adminId);
			response.getWriter().print("true");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("false");
		}
	}

}
