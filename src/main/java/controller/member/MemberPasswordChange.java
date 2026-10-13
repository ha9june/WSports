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
 * Servlet implementation class MemberPasswordChange
 */
@WebServlet("/member/password/change")
public class MemberPasswordChange extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberPasswordChange() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User loginUser = (User) request.getSession().getAttribute("user");
		Long userId = loginUser.getUserId();
		
		String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String newPassword2 = request.getParameter("newPassword2");
        
        if(!newPassword.equals(newPassword2)) {
        	response.getWriter().write("mismatch");
        	return;
        }
        
        try {
        	MemberService service = new MemberServiceImpl();
            Boolean changed = service.passwordChange(userId,oldPassword,newPassword);
            if (changed) {
            	loginUser.setPassword(newPassword);
            }
            response.getWriter().write(changed ? "true" : "false");
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
}
