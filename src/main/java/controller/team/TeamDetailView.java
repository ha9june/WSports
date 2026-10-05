package controller.team;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.User;
import service.team.TeamApplicationService;
import service.team.TeamApplicationServiceImpl;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;
import service.team.TeamUserService;
import service.team.TeamUserServiceImpl;

/**
 * Servlet implementation class TeamDetailView
 */
@WebServlet("/team/detail/view")
public class TeamDetailView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamDetailView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		TeamService teamService = new TeamServiceImpl();
		TeamUserService teamUserService = new TeamUserServiceImpl();
		TeamMatchService teamMatchService = new TeamMatchServiceImpl();
		TeamApplicationService teamApplicationService = new TeamApplicationServiceImpl();
		
		
		User user = (User) session.getAttribute("user");
		
		String state = "public"; // 비가입자, 비회원

		try {
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			if(user != null) {
				String myRole = teamUserService.getRole(teamId, user.getUserId());
			    if (myRole != null) {
			        state = ("CAPTAIN".equals(myRole) || "VICE_CAPTAIN".equals(myRole)) ? "manager" : "member";
			    }else if(teamApplicationService.getApplication(teamId, user.getUserId()) != null) {
					state = "applicater";
				}
			}
			
			request.setAttribute("team", teamService.getTeam(teamId));
			request.setAttribute("state", state); //팀원인지 관리자인지 신청자인지 member // manager //applicater	
			if("member".equals(state) || "manager".equals(state)) { //팀원 혹은 팀 관리자면
				request.setAttribute("teamUserList", teamUserService.getTeamUserList(teamId));
				request.setAttribute("teamMatchList", teamMatchService.getTeamMatchList(teamId));
			}
			request.getRequestDispatcher("/jsp/team/teamDetail.jsp").forward(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 상세보기 중 오류 발생");
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
