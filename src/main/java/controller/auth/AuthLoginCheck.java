package controller.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.auth.AuthService;
import service.auth.AuthServiceImpl;

/**
 * Servlet implementation class AuthLoginCheck
 */
@WebServlet("/auth/login/check")
public class AuthLoginCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthLoginCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");

		AuthService service = new AuthServiceImpl();
		try {
			User user = service.loginCheck(loginId, password);
			//있으면 user 
			//없으면 null
			 if(user != null) {
			 	response.getWriter().write("true");
			 } else {
			 	response.getWriter().write("false");
			 }
		} catch(Exception e) {
			e.printStackTrace();
			response.getWriter().write("로그인 체크 오류");
		}
	}
}
