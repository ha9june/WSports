package controller.team;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Team;
import dto.TeamMatch;
import dto.TeamMatchParticipant;
import dto.User;
import service.team.TeamMatchParticipantService;
import service.team.TeamMatchParticipantServiceImpl;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamRatingService;
import service.team.TeamRatingServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;

/**
 * Servlet implementation class TeamMatchResultView
 */
@WebServlet("/team-match/result/view")
public class TeamMatchResultView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamMatchResultView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			//로그인 안하면 로그인 시키기
			User user = (User) request.getSession().getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/auth/login");
				return;
			}
			//이 경기 참여자(호스트, 참가 신청 아이디) 확인
			TeamMatchService teamMatchService = new TeamMatchServiceImpl();
			TeamMatchParticipantService teamMatchParticipantService = new TeamMatchParticipantServiceImpl();
			TeamService teamService = new TeamServiceImpl();
			TeamRatingService teamRatingService = new TeamRatingServiceImpl();
			
			Long teamMatchId = Long.parseLong(request.getParameter("teamMatchId"));
			TeamMatch teamMatch = teamMatchService.getTeamMatchNotUser(teamMatchId);
			
			if (!"경기 종료".equals(teamMatch.getStatus())) {
				request.getSession().setAttribute("toast", "경기 종료 후에 이용할 수 있어요.");
				response.sendRedirect(request.getContextPath() + "/team-match/detail/view?teamMatchId=" + teamMatchId);
				return;
			}
			List<TeamMatchParticipant> ps = teamMatchParticipantService.getTeamMatchParticipantList(teamMatchId);

			TeamMatchParticipant hostP = null, guestP = null;
			for (TeamMatchParticipant p : ps) {
				if (p.getTeamId().equals(teamMatch.getTeamId())) hostP = p;
				else guestP = p;
			}
			
			if (hostP == null || guestP == null) {
				request.setAttribute("error", "상대 팀이 확정되지 않은 경기예요.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}

			boolean isHost = user.getUserId().equals(teamMatch.getUserId());
			boolean isGuest = guestP != null && user.getUserId().equals(guestP.getUserId());
			if (!isHost && !isGuest) {
				request.setAttribute("error", "경기 참가 팀만 접근할 수 있어요.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			
			Team hostTeam = teamService.getTeam(hostP.getTeamId());
			Team guestTeam = teamService.getTeam(guestP.getTeamId());
			request.setAttribute("hostTeam", hostTeam);
			request.setAttribute("guestTeam", guestTeam);
			
			request.setAttribute("teamMatch", teamMatch);
			
			request.setAttribute("hostP", hostP);
			request.setAttribute("guestP", guestP);
			request.setAttribute("ourTeam", isHost ? "host" : "guest");

			//점수 가져오기
			Long targetTeamId = isHost ? guestTeam.getTeamId() : hostTeam.getTeamId();
			Double score = teamRatingService.getMyTeamRating(teamMatchId, targetTeamId, user.getUserId());
			
			request.setAttribute("score", score);
			
			
			request.getRequestDispatcher("/jsp/team/teamMatchResultDetail.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "경기 후 출석 및 평점 조회중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
