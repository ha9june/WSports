package controller.auth;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Notification;
import dto.User;
import dto.UserFcmToken;
import service.auth.AuthService;
import service.auth.AuthServiceImpl;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;
import service.notification.UserFcmTokenService;
import service.notification.UserFcmTokenServiceImpl;

/**
 * Servlet implementation class Login
 */
@WebServlet("/auth/login")
public class AuthLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/jsp/auth/login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");
		String fcmToken = request.getParameter("fcmToken");
		
		UserFcmToken userFcmToken = new UserFcmToken();
		userFcmToken.setFcmToken(fcmToken);

		
		AuthService service = new AuthServiceImpl();
		UserFcmTokenService userFcmTokenService = new UserFcmTokenServiceImpl();
		
		try {
			HttpSession session = request.getSession();
			User user = service.login(loginId);
			session.setAttribute("user", service.login(loginId));
			
			service.updateLastLogin(user.getLoginId());
			
			userFcmToken.setUserId(user.getUserId());
			userFcmTokenService.registerToken(userFcmToken);
			
			response.sendRedirect(request.getContextPath()+"/jsp/home/main.jsp"); // main suvlet으로 교체 필요 
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}

