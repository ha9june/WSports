package controller.team;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.User;
import service.team.TeamService;
import service.team.TeamServiceImpl;

/**
 * Servlet implementation class TeamDelete
 */
@WebServlet("/team/delete")
public class TeamDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamDelete() {
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
		HttpSession session = request.getSession(false);
		User user = (session == null) ? null : (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		Long teamId = Long.parseLong(request.getParameter("teamId"));
		String from = request.getParameter("from");
		String back = "mypage".equals(from) ? "/mypage/clubs" : "/team/list";

		TeamService teamService = new TeamServiceImpl();
		try {
			boolean admin = "Admin".equals(user.getGrade());
			String reason = request.getParameter("reason");
			reason = (reason == null) ? "" : reason.trim();

			if (admin) {
				// 관리자는 모든 팀 삭제 가능, 사유 필수
				if (reason.isEmpty() || reason.length() > 100) {
					session.setAttribute("toast", "삭제 사유를 100자 이내로 입력해 주세요.");
					response.sendRedirect(request.getContextPath() + "/team/detail/view?teamId=" + teamId);
					return;
				}
			} else {
				// 일반 회원은 본인 팀의 주장일 때만 가능
				Long captainId = teamService.getCaptainUserId(teamId);
				if (captainId == null || !captainId.equals(user.getUserId())) {
					request.setAttribute("error", "팀 주장만 팀 삭제 가능합니다.");
					request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
					return;
				}
			}

			teamService.removeTeam(teamId, admin, user.getUserId(), reason);
			
			session.setAttribute("toast", "팀을 삭제했어요.");
			

			response.sendRedirect(request.getContextPath() + back);
		} catch (IllegalStateException e) {
			session.setAttribute("toast", e.getMessage());
			String dest = "mypage".equals(from)
					? "/mypage/clubs"
					: "/team/detail/view?teamId=" + teamId;
			response.sendRedirect(request.getContextPath() + dest);
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("toast", "팀 삭제 중 문제가 생겼어요. 잠시 후 다시 시도해 주세요.");
			response.sendRedirect(request.getContextPath() + back);
		}
	}

}
