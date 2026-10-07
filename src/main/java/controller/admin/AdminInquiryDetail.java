package controller.admin;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.admin.AdminInquiryService;
import service.admin.AdminInquiryServiceImpl;

/**
 * Servlet implementation class AdminInquiryDetail
 */
@WebServlet("/admin/inquiry/detail")
public class AdminInquiryDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminInquiryDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInquiryServiceImpl service = new AdminInquiryServiceImpl();
		try {
			Long inquiryId = Long.parseLong(request.getParameter("inquiryId"));
			Map<String, Object> inquirydetail = service.getAdminInquiryDetail(inquiryId);
			request.setAttribute("inquirydetail", inquirydetail);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "문의 상세 조회 오류");
		}
		request.getRequestDispatcher("/jsp/admin/adminInquiryDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInquiryServiceImpl service = new AdminInquiryServiceImpl();
		try {
			// 지금 로그인한 관리자 번호 (세션에서)
			User user = (User) request.getSession().getAttribute("user");
			Long adminId = user.getUserId();
			
			Long inquiryId = Long.parseLong(request.getParameter("inquiryId"));
			String answer = request.getParameter("answer");
			
			service.AdminInquiryAnswer(inquiryId, answer, adminId);
			response.getWriter().print("true");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("false");
		}
	}

}
