package controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.notification.UserFcmTokenService;
import service.notification.UserFcmTokenServiceImpl;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/auth/logout/submit")
public class AuthLogoutSubmit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthLogoutSubmit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserFcmTokenService userFcmTokenService = new UserFcmTokenServiceImpl();
		
		try {
			User user = (User)request.getSession().getAttribute("user");
			Long userId = user.getUserId();
	    	String fcmToken = (String) request.getSession().getAttribute("fcmToken");
	    	
	    	userFcmTokenService.changeActiveUserFcmToken(userId, fcmToken);
	    	request.getSession().removeAttribute("user");
			request.getRequestDispatcher("/home/main").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		
	}
}
