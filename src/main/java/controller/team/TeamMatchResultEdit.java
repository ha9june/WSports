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
 * Servlet implementation class TeamMatchResultEdit
 */
@WebServlet("/team-match/result/edit")
public class TeamMatchResultEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamMatchResultEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			User user = (User) request.getSession().getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/auth/login");
				return;
			}
			
			Long teamMatchId = Long.parseLong(request.getParameter("teamMatchId"));
			TeamMatchService teamMatchService = new TeamMatchServiceImpl();
			TeamMatch teamMatch = teamMatchService.getTeamMatchNotUser(teamMatchId);
			
			
			if (!"경기 종료".equals(teamMatch.getStatus())) {
				request.setAttribute("error", "경기가 종료된 후에 이용할 수 있어요.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			
			request.setAttribute("teamMatch", teamMatch);
			TeamMatchParticipantService teamMatchParticipantService = new TeamMatchParticipantServiceImpl();
			TeamService teamService = new TeamServiceImpl();
			
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


			request.setAttribute("hostP", hostP);
			request.setAttribute("guestP", guestP);
			request.setAttribute("ourTeam", isHost ? "host" : "guest");
			
			TeamRatingService teamRatingService = new TeamRatingServiceImpl();
			Long targetTeamId = isHost ? guestTeam.getTeamId() : hostTeam.getTeamId();
			Double score = teamRatingService.getMyTeamRating(teamMatchId, targetTeamId, user.getUserId());
			
			request.setAttribute("score", score);
			request.getRequestDispatcher("/jsp/team/teamMatchResultEdit.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "경기 후 관리 수정 접속 중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user = (User) request.getSession().getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/auth/login");
				return;
			}
			
			TeamMatchService teamMatchService = new TeamMatchServiceImpl();
			TeamRatingService teamRatingService = new TeamRatingServiceImpl();
			TeamMatchParticipantService teamMatchParticipantService = new TeamMatchParticipantServiceImpl();
			
			Long teamMatchId = Long.parseLong(request.getParameter("teamMatchId"));
			TeamMatch teamMatch = teamMatchService.getTeamMatchNotUser(teamMatchId);
//			Long targetTeamId = Long.parseLong(request.getParameter("targetTeamId"));
			Double score = Double.parseDouble(request.getParameter("score"));
			
			List<TeamMatchParticipant> ps = teamMatchParticipantService.getTeamMatchParticipantList(teamMatchId);

			TeamMatchParticipant hostP = null, guestP = null;
			for (TeamMatchParticipant p : ps) {
				if (p.getTeamId().equals(teamMatch.getTeamId())) hostP = p;
				else guestP = p;
			}
			
			//호스트면 출석 반영
			boolean isHost = user.getUserId().equals(teamMatch.getUserId());
			if(isHost) {
				boolean attendHost = !"false".equals(request.getParameter("attendHost"));
				boolean attendGuest = !"false".equals(request.getParameter("attendGuest"));
				teamMatchParticipantService.modifyAttendance(attendHost, teamMatchId, hostP.getTeamId());
				teamMatchParticipantService.modifyAttendance(attendGuest, teamMatchId, guestP.getTeamId());
			}
			Long targetTeamId = isHost ? guestP.getTeamId() : hostP.getTeamId();
			//평점 업데이트 반환 0이면 인서트
			int result = teamRatingService.modifyTeamRating(score, teamMatchId, targetTeamId, user.getUserId()); 
			if(result == 0) {
				teamRatingService.makeTeamRating(targetTeamId, user.getUserId(), score, teamMatchId);
			}
			
			
			response.sendRedirect(request.getContextPath() + "/team-match/result/view?teamMatchId=" + teamMatchId);
		} catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 출석 및 평가 저장 중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

}
