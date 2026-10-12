package controller.match;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PersonalMatch;
import dto.PersonalMatchParticipant;
import dto.User;
import dto.UserRating;
import service.match.PersonalMatchParticipantService;
import service.match.PersonalMatchParticipantServiceImpl;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import service.match.UserRatingService;
import service.match.UserRatingServiceImpl;
import util.CheckUtil;

/**
 * Servlet implementation class MatchAfterSave
 */
@WebServlet("/match/after/save")
public class MatchAfterSave extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MatchAfterSave() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = CheckUtil.getLoginUser(request);
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		Long personalMatchId = Long.parseLong(request.getParameter("personalMatchId"));

		Boolean isHost = false;
		PersonalMatchService pmService = new PersonalMatchServiceImpl();
		PersonalMatch pm = new PersonalMatch();
		pm.setPersonalMatchId(personalMatchId);
		try {
			PersonalMatch pMatch = pmService.getPersonalMatchDetail(pm);
			if (pMatch.getUserId().equals(user.getUserId())) {
				isHost = true;
			}
		} catch (Exception e) {
			e.printStackTrace();

		}

		PersonalMatchParticipantService pmpService = new PersonalMatchParticipantServiceImpl();

		for (int i = 0;; i++) {
			String userIdStr = request.getParameter("userId_" + i);
			if (userIdStr == null)
				break; // null 체크는 변환 전에

			Long userId = Long.parseLong(userIdStr);
			String attend = request.getParameter("attend_" + i); // "Y" / "N" (호스트만)
			String scoreStr = request.getParameter("score_" + i);
			BigDecimal score = (scoreStr == null || scoreStr.isEmpty()) ? BigDecimal.ZERO : new BigDecimal(scoreStr);

			UserRating ur = new UserRating();
			ur.setReceiverUserId(userId);
			ur.setEvaluatorUserId(user.getUserId());
			ur.setScore(score);
			ur.setMatchId(personalMatchId);
			ur.setMatchType("PersonalMatch");
			PersonalMatchParticipant pmp = new PersonalMatchParticipant();

			if (isHost) {

				pmp.setAttendance(attend.equals("Y"));
				pmp.setUserId(userId);
				pmp.setPersonalMatchId(personalMatchId);
			}


			UserRatingService urService = new UserRatingServiceImpl();
			
			  try { 
				  urService.saveUserRating(ur);
				  if(isHost) 
					  pmpService.updateAttendacne(pmp);
			  }
			  catch (Exception e) { // TODO Auto-generated catch block e.printStackTrace();
				  e.printStackTrace();
			  }


		}

		// response.sendRedirect(request.getContextPath() +
		// "/match/after/profile/list?personalMatchId=" + personalMatchId);
	}

}
