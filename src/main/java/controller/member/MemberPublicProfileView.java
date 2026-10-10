package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.member.MemberService;
import service.member.MemberServiceImpl;

/**
 * Servlet implementation class MemberPublicProfileView
 */
@WebServlet("/member/publicProfile/view")
public class MemberPublicProfileView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberPublicProfileView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Long targetId = Long.parseLong(request.getParameter("userId"));
		MemberService service = new MemberServiceImpl();
		try {
			request.setAttribute("publicProfile", service.publicProfile(targetId));
			request.setAttribute("teamList", service.publicProfileTeams(targetId));
			request.getRequestDispatcher("/jsp/member/userProfileInfo.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
