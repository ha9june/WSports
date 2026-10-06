package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.admin.AdminNoticeService;
import service.admin.AdminNoticeServiceImpl;

/**
 * Servlet implementation class AdminNoticeWrite
 */
@WebServlet("/admin/notice/write")
public class AdminNoticeWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminNoticeWrite() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/jsp/admin/adminNoticeWrite.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminNoticeService service = new AdminNoticeServiceImpl();
		try {
			// 지금 로그인한 관리자 번호 (세션에서)
			User user = (User) request.getSession().getAttribute("user");
			Long adminId = user.getUserId();

			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String type = request.getParameter("type");
			Boolean isPinned = "on".equals(request.getParameter("isPinned"));
			System.out.println("isPinned 값 : [" + request.getParameter("isPinned") + "]");
			
			service.AdminNoticeWrite(title, content, isPinned, adminId, type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/admin/notice");
	}

}
