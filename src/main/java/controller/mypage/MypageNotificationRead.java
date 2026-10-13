package controller.mypage;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.notification.NotificationServiceImpl;

/**
 * Servlet implementation class MypageNotificationRead
 */
@WebServlet("/mypage/notifications/read")
public class MypageNotificationRead extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MypageNotificationRead() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		String idParam = request.getParameter("id");
		if (user == null || idParam == null || !idParam.matches("\\d+")) {
			response.sendRedirect(request.getContextPath() + "/mypage/notifications");
			return;
		}
		String link = null;
		try {
			link = new NotificationServiceImpl().readAndGetLink(Long.parseLong(idParam), user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath()
				+ (link == null || link.isEmpty() ? "/mypage/notifications" : link));
	}
}
