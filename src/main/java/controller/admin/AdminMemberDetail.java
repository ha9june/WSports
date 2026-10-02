package controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.UserPenalty;
import service.admin.AdminMemberServiceImpl;

/**
 * Servlet implementation class AdminMemberDetail
 */
@WebServlet("/admin/member/detail")
public class AdminMemberDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminMemberDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminMemberServiceImpl service = new AdminMemberServiceImpl();
		try {
			Long userId = Long.parseLong(request.getParameter("userId"));
			List<Map<String, Object>> detail = service.getAdminMemberDetailList(userId);
			request.setAttribute("detail", detail);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "회원관리 상세 목록 조회 오류");
		}
		request.getRequestDispatcher("/jsp/admin/adminMemberDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminMemberServiceImpl service = new AdminMemberServiceImpl();
		try {
			Long userId = Long.parseLong(request.getParameter("userId"));

			String reason = request.getParameter("reason");
			String action = request.getParameter("action");

			if ("permanent".equals(action)) {
				// 영구 정지 (기간 없음)
				service.AdminUserPermanentPenalty(userId, reason);
			} else {
				// 기간 정지
				int days = Integer.parseInt(request.getParameter("days"));
				service.AdminUserPenalty(userId, days, reason);
			}
			
			response.getWriter().print("true");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("false");
		}
	}

}
