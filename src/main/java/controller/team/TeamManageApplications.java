package controller.team;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Team;
import dto.TeamApplication;
import service.team.TeamApplicationService;
import service.team.TeamApplicationServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;

/**
 * Servlet implementation class TeamManageApplications
 */
@WebServlet("/team/manage/applications")
public class TeamManageApplications extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamManageApplications() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			TeamService teamService = new TeamServiceImpl();
			TeamApplicationService teamApplicationService = new TeamApplicationServiceImpl();
		
		try {
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			Team team = teamService.getTeam(teamId);
			request.setAttribute("team", team);
			
			List<TeamApplication> taList = teamApplicationService.getApplicationList(teamId);
			request.setAttribute("teamApplicationList", taList);
			request.setAttribute("applicationCnt", taList.size());
			
			request.getRequestDispatcher("/jsp/team/teamManageApplication.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 관리 이동 중 에러 발생");
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
