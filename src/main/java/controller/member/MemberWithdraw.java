package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.User;
import service.member.MemberService;
import service.member.MemberServiceImpl;

/**
 * Servlet implementation class MemberWithdraw
 */
@WebServlet("/member/withdraw")
public class MemberWithdraw extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberWithdraw() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		User loginUser = (User) session.getAttribute("user");
		Long userId = loginUser.getUserId();
		
		String returnUrl = request.getParameter("returnUrl");
        if ("!/member/mypage/edit".equals(returnUrl)) returnUrl = "/member/mypage/view";
        
		try {
			MemberService service = new MemberServiceImpl();
        	Boolean withdraw = service.withdraw(userId);
        	if (!withdraw) {
        		response.sendRedirect(request.getContextPath()+returnUrl+"?withdraw=fail");
                return;
        	} else {
        		session.invalidate();
        		response.sendRedirect(request.getContextPath()+"/home/main");    		
        	}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
