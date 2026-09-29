package controller.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.auth.AuthService;
import service.auth.AuthServiceImpl;

/**
 * Servlet implementation class Login
 */
@WebServlet("/auth/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		
		AuthService service = new AuthServiceImpl();
		try {
			HttpSession session = request.getSession();
			session.setAttribute("user", service.login(loginId, password));
			response.sendRedirect(request.getContextPath()+"/jsp/home/main.jsp"); // main suvlet으로 교체 필요 
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
