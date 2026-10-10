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
import dto.User;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;

/**
 * Servlet implementation class TeamMatchParticipantsList
 */
@WebServlet("/team-match/participants/list")
public class TeamMatchParticipantsList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamMatchParticipantsList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			TeamService teamService = new TeamServiceImpl();
			
			User user = (User) request.getSession().getAttribute("user");
		    if (user == null) {
		        response.sendRedirect(request.getContextPath() + "/auth/login");
		        return;
		    }
			Long teamMatchId = Long.parseLong(request.getParameter("teamMatchId"));
			TeamMatchService teamMatchService = new TeamMatchServiceImpl();
			TeamMatch teamMatch = teamMatchService.getTeamMatchNotUser(teamMatchId);
			List<Team> teamList = teamService.getTeamMatchParticipantsProfileList(teamMatchId);
			Team hostTeam = null;
			Team guestTeam = null;
			for(Team t : teamList) {
				if(teamMatch.getTeamId().equals(t.getTeamId())) {
					hostTeam = t;
				}else {
					guestTeam = t;
				}
			}
			
			request.setAttribute("teamMatchId", teamMatchId);
			request.setAttribute("hostTeam", hostTeam);
			request.setAttribute("guestTeam", guestTeam);

			request.getRequestDispatcher("/jsp/team/teamMatchParticipants.jsp").forward(request, response);

		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "참가 팀 확인중 에러 발생");
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
