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
User loginUser = (User)request.getSession().getAttribute("user");
		
		User user = new User();
		user.setLoginId(loginUser.getLoginId());
		user.setName(request.getParameter("name"));
		user.setEmail(request.getParameter("email"));
		user.setNickname(request.getParameter("nickname"));
		LocalDate birthDate = LocalDate.parse(request.getParameter("birth"));
		user.setBirthDate(birthDate);
		user.setPhone(request.getParameter("phone"));
		
		String bank = request.getParameter("bank");
		String accountNo = request.getParameter("accountNo");
		String accountHolder = request.getParameter("accountHolder");
		
		if(bank != null && !bank.isEmpty() && !"은행 선택".equals(bank)) {
			user.setBankName(bank);
		}
		if(accountNo != null && !accountNo.isEmpty()) {
			user.setAccountNumber(accountNo);
		}
		if(accountHolder != null && !accountHolder.isEmpty()) {
			user.setAccountHolder(accountHolder);
		}
		
		MemberService service = new MemberServiceImpl();
		try {
			User updateUser = service.mypageEdit(user);
			request.getSession().setAttribute("user", updateUser);
			response.sendRedirect(request.getContextPath()+"/member/mypage/view");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
