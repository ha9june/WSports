package controller.match;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.match.PersonalMatchParticipantService;
import service.match.PersonalMatchParticipantServiceImpl;
import util.AlertUtil;
import util.CheckUtil;

/**
 * Servlet implementation class PersonalMatchProfile
 */
@WebServlet("/match/detail/profile/list")
public class MatchDetailProfileList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchDetailProfileList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = CheckUtil.getLoginUser(request);
		if (user == null) {
		    response.sendRedirect(request.getContextPath() + "/auth/login");
		    return;
		}
		Long personalMatchId = Long.parseLong(request.getParameter("personalMatchId"));
		
		
		PersonalMatchParticipantService service = new PersonalMatchParticipantServiceImpl();
		
		try {
			List<User> userList = service.getPersonalMatchParticipantList(personalMatchId);
			request.setAttribute("userList", userList);
			System.out.println(userList);
			request.getRequestDispatcher("/jsp/match/personalMatchProfileList.jsp").forward(request, response);;

		} catch (Exception e) {
			e.printStackTrace();
			AlertUtil.back(response,"프로필 리스트 조회 에러");
			return;		
		}
		
		
		
	    
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
	}

}
