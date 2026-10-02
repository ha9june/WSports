package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;

/**
 * Servlet implementation class MemberMypageView
 */
@WebServlet("/member/mypage/view")
public class MemberMypageView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberMypageView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user = (User)request.getSession().getAttribute("user");
			request.setAttribute("loginUser", user);
			request.getRequestDispatcher("/jsp/mypage/myPageUser.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
