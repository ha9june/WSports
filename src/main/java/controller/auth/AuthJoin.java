package controller.auth;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.auth.AuthService;
import service.auth.AuthServiceImpl;

/**
 * Servlet implementation class Join
 */
@WebServlet("/auth/join")
public class AuthJoin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthJoin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/jsp/auth/join.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = new User();
		user.setLoginId(request.getParameter("loginId"));
		user.setName(request.getParameter("name"));
		user.setPassword(request.getParameter("password"));
		user.setEmail(request.getParameter("email"));
		user.setNickname(request.getParameter("nickname"));
		LocalDate birthDate = LocalDate.parse(request.getParameter("birth"));
		user.setBirthDate(birthDate);
		user.setPhone(request.getParameter("phone"));
		user.setGender(request.getParameter("gender"));
		
		String preferredRegion1 = request.getParameter("preferredRegion1");
		String preferredRegion2 = request.getParameter("preferredRegion2");
		String preferredRegion3 = request.getParameter("preferredRegion3");
		String preferredSport1 = request.getParameter("preferredSport1");
		String preferredSport2 = request.getParameter("preferredSport2");
		String preferredSport3 = request.getParameter("preferredSport3");

		if (preferredRegion1 != null && !preferredRegion1.isEmpty()) {
		    user.setPreferredRegion1(preferredRegion1);
		}
		if (preferredRegion2 != null && !preferredRegion2.isEmpty()) {
		    user.setPreferredRegion2(preferredRegion2);
		}
		if (preferredRegion3 != null && !preferredRegion3.isEmpty()) {
		    user.setPreferredRegion3(preferredRegion3);
		}
		if (preferredSport1 != null && !preferredSport1.isEmpty()) {
		    user.setPreferredSport1(preferredSport1);
		}
		if (preferredSport2 != null && !preferredSport2.isEmpty()) {
		    user.setPreferredSport2(preferredSport2);
		}
		if (preferredSport3 != null && !preferredSport3.isEmpty()) {
		    user.setPreferredSport3(preferredSport3);
		}
		
		AuthService service = new AuthServiceImpl();
		try {
			service.join(user);
			request.getRequestDispatcher("/jsp/auth/login.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
