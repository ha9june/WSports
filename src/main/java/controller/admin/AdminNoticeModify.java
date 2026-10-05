package controller.admin;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.AdminNoticeServiceImpl;

/**
 * Servlet implementation class AdminNoticeModify
 */
@WebServlet("/admin/notice/modify")
public class AdminNoticeModify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminNoticeModify() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminNoticeServiceImpl service = new AdminNoticeServiceImpl();
		try {
			Long noticeId = Long.parseLong(request.getParameter("noticeId"));
			Map<String, Object> detail = service.getAdminNoticeDetailList(noticeId);
			System.out.println("공지 상세 : " + detail);
			request.setAttribute("detail", detail);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "회원관리 상세 목록 조회 오류");
		}
		request.getRequestDispatcher("/jsp/admin/adminNoticeModify.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminNoticeServiceImpl service = new AdminNoticeServiceImpl();
		try {
			Long noticeId = Long.parseLong(request.getParameter("noticeId"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String type = request.getParameter("type");
			service.getAdminNoticeModify(noticeId, title, content, type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/admin/notice");
	}

}
