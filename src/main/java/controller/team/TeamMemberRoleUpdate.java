package controller.team;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.team.TeamUserService;
import service.team.TeamUserServiceImpl;

/**
 * Servlet implementation class TeamMemberRoleUpdate
 */
@WebServlet("/team/member/role-update")
public class TeamMemberRoleUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamMemberRoleUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			TeamUserService teamUserService = new TeamUserServiceImpl();
			
			User loginUser = (User) request.getSession().getAttribute("user");
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			Long targetUserId = Long.parseLong(request.getParameter("userId")); // 대상 팀원
			String role = request.getParameter("role");
			
			String myRole = teamUserService.getRole(teamId, loginUser.getUserId());
			if (!"CAPTAIN".equals(myRole)) {
			    request.setAttribute("error", "부팀장 임명/해제는 팀장만 가능합니다.");
			    request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
			    return;
			}

			
			String targetRole = teamUserService.getRole(teamId, targetUserId); //변경할 대상의 역할
			boolean validRole = "VICE_CAPTAIN".equals(role) || "MEMBER".equals(role); //이상한거 거르기
			if (!validRole || targetRole == null || "CAPTAIN".equals(targetRole)) {
			    request.setAttribute("error", "변경할 수 없는 요청입니다.");
			    request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
			    return;
			}
			
			teamUserService.modifyTeamUserRole(teamId, targetUserId, role);

			String result = "VICE_CAPTAIN".equals(role) ? "vice" : "revoke";
			response.sendRedirect(request.getContextPath()
					+ "/team/manage/members?teamId=" + teamId + "&result=" + result);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀원 권한 변경 중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

}
