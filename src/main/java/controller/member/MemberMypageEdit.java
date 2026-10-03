package controller.member;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.member.MemberService;
import service.member.MemberServiceImpl;

/**
 * Servlet implementation class MemberMypageEdit
 */
@WebServlet("/member/mypage/edit")
public class MemberMypageEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberMypageEdit() {
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
			request.getRequestDispatcher("/jsp/mypage/myPageUpdateUser.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = new User();
		user.setName(request.getParameter("name"));
		user.setEmail(request.getParameter("email"));
		user.setNickname(request.getParameter("nickname"));
		LocalDate birthDate = LocalDate.parse(request.getParameter("birth"));
		user.setBirthDate(birthDate);
		user.setPhone(request.getParameter("phone"));
		user.setBankName(request.getParameter("bank"));
		user.setAccountNumber(request.getParameter("accountNo"));
		user.setAccountHolder(request.getParameter("accountHolder"));
		
		MemberService service = new MemberServiceImpl();
		try {
			service.mypageEdit(user);
			request.getRequestDispatcher("/jsp/mypage/myPageUser.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
