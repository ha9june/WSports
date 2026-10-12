package controller.team;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PageInfo;
import dto.Team;
import dto.TeamMatch;
import dto.User;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;
import service.team.TeamUserService;
import service.team.TeamUserServiceImpl;

/**
 * Servlet implementation class TeamInfoPosts
 */
@WebServlet("/team/info/posts")
public class TeamInfoPosts extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamInfoPosts() {
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
			
			TeamService teamService = new TeamServiceImpl();
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			Team team = teamService.getTeam(teamId);
			
			int page = 1;
			try { page = Integer.parseInt(request.getParameter("page")); } catch (Exception e) {}
			PageInfo pageInfo = new PageInfo(page);
			
			TeamMatchService teamMatchService = new TeamMatchServiceImpl();
			List<TeamMatch> teamMatchList = teamMatchService.getTeamPostList(teamId, pageInfo);
			
			
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("team", team);
			request.setAttribute("teamMatchList", teamMatchList);
			request.setAttribute("teamId", teamId);
			
			request.getRequestDispatcher("/jsp/team/teamInfoPosts.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 작성글 보기 접속 중 에러 발생");
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
