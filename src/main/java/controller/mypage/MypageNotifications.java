package controller.mypage;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NotificationDao;
import dao.NotificationDaoImpl;
import dto.User;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;

/**
 * Servlet implementation class MypageNotifications
 */
@WebServlet("/mypage/notifications")
public class MypageNotifications extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MypageNotifications() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		NotificationDao notification = new NotificationDaoImpl();
		try {
			request.setAttribute("notiList", notification.selectMypageNotificationList(user.getUserId()));
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/mypage/notifications");
		}
		request.getRequestDispatcher("/jsp/mypage/myPageAlarm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String ctx = request.getContextPath();

		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			response.sendRedirect(ctx + "/auth/login");
			return;
		}

		String action = request.getParameter("action");
		NotificationDao dao = new NotificationDaoImpl();

		try {
			if ("readAll".equals(action)) {
				// 전체 읽음
				dao.updateMypageAllNotificationRead(user.getUserId());

			} else if ("read".equals(action)) {
				// 1건 읽음 후 관련 화면으로 이동
				long notificationId = Long.parseLong(request.getParameter("notificationId"));
				java.util.Map<String, Object> param = new java.util.HashMap<String, Object>();
				param.put("notificationId", notificationId);
				param.put("userId", user.getUserId());

				dao.updateMypageNotificationRead(param);
				String link = dao.selectLink(param);

				// 내부 경로만 허용 (오픈 리다이렉트 방지)
				if (link != null && link.startsWith("/") && !link.startsWith("//")) {
					response.sendRedirect(ctx + link);
					return;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.sendRedirect(ctx + "/mypage/notifications");
	}
}