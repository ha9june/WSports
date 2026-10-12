package controller.match;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PersonalMatch;
import dto.User;
import service.match.PersonalMatchParticipantService;
import service.match.PersonalMatchParticipantServiceImpl;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import util.AlertUtil;
import util.CheckUtil;

/**
 * Servlet implementation class MatchAfterProfileListEdit
 */
@WebServlet("/match/after/profile/list/edit")
public class MatchAfterProfileListEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchAfterProfileListEdit() {
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
		PersonalMatch pm = new PersonalMatch();
		pm.setUserId(user.getUserId());
		pm.setPersonalMatchId(personalMatchId);
		
		PersonalMatchParticipantService pmpservice = new PersonalMatchParticipantServiceImpl();
		PersonalMatchService pㅜervice = new PersonalMatchServiceImpl();
		try {

			List<User> userList = pmpservice.getOtherPersonalMatchParticipantList(personalMatchId,user.getUserId());
			PersonalMatch pMatch = pㅜervice.getPersonalMatchDetail(pm);			
			request.setAttribute("userList", userList);
			request.setAttribute("personalMatch", pMatch);
			request.getRequestDispatcher("/jsp/match/personalMatchAfterProfileListEdit.jsp").forward(request, response);;			

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
		// TODO Auto-generated method stub
	}

}
