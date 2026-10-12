package controller.team;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Notification;
import dto.Team;
import dto.User;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;
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
			TeamService teamService = new TeamServiceImpl();
			
			User loginUser = (User) request.getSession().getAttribute("user");
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			Team team = teamService.getTeam(teamId);
			Long targetUserId = Long.parseLong(request.getParameter("userId")); // 대상 팀원
			String role = request.getParameter("role");
			
			String myRole = teamUserService.getRole(teamId, loginUser.getUserId());
			if (!"CAPTAIN".equals(myRole)) {
			    request.setAttribute("error", "부주장 임명/해제는 주장만 가능합니다.");
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

			NotificationService notificationService = new NotificationServiceImpl();
			Notification alarm = new Notification();
			String title = "VICE_CAPTAIN".equals(role)
					? "부주장으로 임명되었어요"
					: "부주장 권한이 해제되었어요";
			String content = "VICE_CAPTAIN".equals(role)
					? "'" + team.getTeamName() + "' 팀의 부주장으로 지정되었습니다."
					: "'" + team.getTeamName() + "' 팀에서 일반 팀원으로 변경되었습니다.";
			
			alarm.setTitle(title);
			alarm.setContent(content);
			alarm.setUserId(targetUserId);
			alarm.setLink("/team/detail/view?teamId=" + teamId);
			notificationService.sendNotification(alarm);
			
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
