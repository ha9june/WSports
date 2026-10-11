package controller.team;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Team;
import dto.User;
import service.team.TeamService;
import service.team.TeamServiceImpl;
import service.team.TeamUserService;
import service.team.TeamUserServiceImpl;

/**
 * Servlet implementation class TeamManageMembers
 */
@WebServlet("/team/manage/members")
public class TeamManageMembers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamManageMembers() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {			
			User user = (User)request.getSession().getAttribute("user");
			if(user == null) {
				response.sendRedirect(request.getContextPath()+"/auth/login");
				return;
			}
			TeamUserService teamUserService = new TeamUserServiceImpl();
			TeamService teamService = new TeamServiceImpl();
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			String teamRole = teamUserService.getRole(teamId, user.getUserId());
			if( !(teamRole.equals("CAPTAIN")  || teamRole.equals("VICE_CAPTAIN")) ) {
				request.setAttribute("error", "팀 관리는 팀장 혹은 부팀장만 이용 가능합니다.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			Team team = teamService.getTeam(teamId);
			List<User> userList = teamUserService.getTeamUserList(teamId);
			
			request.setAttribute("team", team);
			request.setAttribute("userList", userList);
			request.setAttribute("teamId", teamId);
			request.setAttribute("teamRole", teamRole);
			
			request.getRequestDispatcher("/jsp/team/teamManageMembers.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀원 관리 접속중 에러 발생");
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
