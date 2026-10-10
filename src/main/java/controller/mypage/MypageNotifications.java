package controller.mypage;

import java.io.IOException;
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
			NotificationDao notification = new NotificationDaoImpl();
		try {
			request.setAttribute("notiList",
					notification.selectMypageNotificationList(user.getUserId()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/jsp/mypage/myPageAlarm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
