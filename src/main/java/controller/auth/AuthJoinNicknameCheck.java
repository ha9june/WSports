package controller.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.auth.AuthService;
import service.auth.AuthServiceImpl;

/**
 * Servlet implementation class CheckUserNickname
 */
@WebServlet("/auth/join/nickname-check")
public class AuthJoinNicknameCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthJoinNicknameCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nickname = request.getParameter("nickname");
		AuthService service = new AuthServiceImpl();
		try {
			boolean isExist = service.checkUserNickname(nickname);
			response.getWriter().write(String.valueOf(isExist));
		} catch(Exception e) {
			e.printStackTrace();
			response.getWriter().write("닉네임 중복 체크 오류");
		}
	}
}
