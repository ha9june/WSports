package controller.match;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PersonalMatch;
import dto.PersonalMatchParticipant;
import dto.TeamMatch;
import dto.User;
import dto.UserRating;
import service.match.PersonalMatchParticipantService;
import service.match.PersonalMatchParticipantServiceImpl;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import service.match.UserRatingService;
import service.match.UserRatingServiceImpl;
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
    // 경기 날짜 다음날 23:59:59까지만 출석/평점 수정 가능
    private boolean isEditable(PersonalMatch pMatch) {
    	LocalDateTime limit = pMatch.getMatchDate().plusDays(1).atTime(23, 59, 59);
    	return !LocalDateTime.now().isAfter(limit);
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
		PersonalMatchService pservice = new PersonalMatchServiceImpl();
		try {

			List<User> userList = pmpservice.getOtherPersonalMatchParticipantList(personalMatchId,user.getUserId());
			User me = pmpservice.getMyPersonalMatchParticipant(personalMatchId, user.getUserId());
			PersonalMatch pMatch = pservice.getPersonalMatchDetail(pm);	
			
			if (!isEditable(pMatch)) {
				request.getSession().setAttribute("toast", "경기 종료 다음날 23:59까지만 출석과 평점을 수정할 수 있어요.");
				response.sendRedirect(request.getContextPath() + "/match/after/profile/list?personalMatchId=" + personalMatchId);
				return;
			}
			request.setAttribute("me", me);
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
		User user = CheckUtil.getLoginUser(request);
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		Long personalMatchId = Long.parseLong(request.getParameter("personalMatchId"));

		boolean isHost = false;
		PersonalMatchService pmService = new PersonalMatchServiceImpl();
		PersonalMatch pm = new PersonalMatch();
		pm.setPersonalMatchId(personalMatchId);
		try {
			PersonalMatch pMatch = pmService.getPersonalMatchDetail(pm);
			if (pMatch == null) {
				AlertUtil.back(response, "존재하지 않는 경기입니다.");
				return;
			}
			if (!isEditable(pMatch)) {
				request.getSession().setAttribute("toast", "경기 종료 다음날 23:59까지만 출석과 평점을 수정할 수 있어요.");
				response.sendRedirect(request.getContextPath() + "/match/after/profile/list?personalMatchId=" + personalMatchId);
				return;
			}
			isHost = pMatch.getUserId().equals(user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
			AlertUtil.back(response, "경기 정보 조회에 실패했습니다. 관리자에게 문의하여 주세요");
			return;
		}

		PersonalMatchParticipantService pmpService = new PersonalMatchParticipantServiceImpl();
		UserRatingService urService = new UserRatingServiceImpl();

		try {
			// 본인 출석: 호스트만 변경 가능 (참가자는 값이 와도 무시)
			if (isHost) {
				String attendMe = request.getParameter("attendMe"); // "Y" / "N"
				if (attendMe != null) {
					PersonalMatchParticipant mine = new PersonalMatchParticipant();
					mine.setAttendance("Y".equals(attendMe));
					mine.setUserId(user.getUserId());
					mine.setPersonalMatchId(personalMatchId);
					pmpService.updateAttendacne(mine);
				}
			}

			for (int i = 0;; i++) {
				String userIdStr = request.getParameter("userId_" + i);
				if (userIdStr == null)
					break;

				Long userId = Long.parseLong(userIdStr);
				if (userId.equals(user.getUserId()))
					continue; // 본인은 평가 불가

				// 참가자 출석: 호스트만 변경 가능
				if (isHost) {
					String attend = request.getParameter("attend_" + i); // "Y" / "N"
					if (attend != null) {
						PersonalMatchParticipant pmp = new PersonalMatchParticipant();
						pmp.setAttendance("Y".equals(attend));
						pmp.setUserId(userId);
						pmp.setPersonalMatchId(personalMatchId);
						pmpService.updateAttendacne(pmp);
					}
				}

				// 평점: 0점(미선택)은 저장하지 않음
				String scoreStr = request.getParameter("score_" + i);
				BigDecimal score = (scoreStr == null || scoreStr.isEmpty()) ? BigDecimal.ZERO : new BigDecimal(scoreStr);
				if (score.compareTo(BigDecimal.ZERO) > 0) {
					UserRating ur = new UserRating();
					ur.setReceiverUserId(userId);
					ur.setEvaluatorUserId(user.getUserId());
					ur.setScore(score);
					ur.setMatchId(personalMatchId);
					ur.setMatchType("PersonalMatch");
					urService.saveUserRating(ur);
				}
			}

			response.sendRedirect(request.getContextPath() + "/match/after/profile/list?personalMatchId=" + personalMatchId);
		} catch (Exception e) {
			e.printStackTrace();
			AlertUtil.back(response, "별점 평가에 실패하였습니다. 관리자에게 문의하여 주세요");
			return;
		}
	}
}
