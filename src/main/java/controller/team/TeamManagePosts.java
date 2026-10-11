package controller.team;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.TeamMatch;
import dto.User;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamUserService;
import service.team.TeamUserServiceImpl;

/**
 * Servlet implementation class TeamManagePosts
 */
@WebServlet("/team/manage/posts")
public class TeamManagePosts extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamManagePosts() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user = (User)request.getSession().getAttribute("user");
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			if(user == null) {
				response.sendRedirect(request.getContextPath()+"/auth/login");
				return;
			}
			TeamUserService teamUserService = new TeamUserServiceImpl();
			String teamRole = teamUserService.getRole(teamId, user.getUserId());
			if(!(teamRole.equals("CAPTAIN") || teamRole.equals("VICE_CAPTAIN"))) {
				request.setAttribute("error", "팀 관리는 팀장 혹은 부팀장만 이용 가능합니다.");
				request.getRequestDispatcher("/jsp/common/error.jsp");
				return;
			}
			TeamMatchService teamMatchService = new TeamMatchServiceImpl();
			List<TeamMatch> teamMatchList = teamMatchService.getTeamMatchList(teamId);
			
			request.setAttribute("teamMatchList", teamMatchList);
			request.setAttribute("teamId", teamId);
			request.setAttribute("teamRole", teamRole);
			
			request.getRequestDispatcher("/jsp/team/teamManagePosts.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 작성글 관리 접속 중 에러 발생");
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
