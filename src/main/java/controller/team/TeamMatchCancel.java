package controller.team;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.TeamMatch;
import dto.User;
import service.team.TeamMatchParticipantService;
import service.team.TeamMatchParticipantServiceImpl;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;

/**
 * Servlet implementation class TeamMatchCancel
 */
@WebServlet("/team-match/cancel")
public class TeamMatchCancel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamMatchCancel() {
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
		User user = (User) request.getSession().getAttribute("user");
		if(user == null) {
			response.sendRedirect(request.getContextPath()+"/auth/login");
			return;
		}
		try {
			Long teamMatchId = Long.parseLong(request.getParameter("teamMatchId"));
			
			TeamMatchService teamMatchService = new TeamMatchServiceImpl();
			TeamMatchParticipantService tmpService = new TeamMatchParticipantServiceImpl();
			TeamMatch teamMatch = teamMatchService.getTeamMatchNotUser(teamMatchId);
			if (teamMatch == null) {
			    request.setAttribute("error", "존재하지 않거나 삭제된 경기입니다.");
			    request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
			    return;
			}
			if(!(teamMatch.getUserId().equals(user.getUserId()))){
				request.setAttribute("error", "팀 경기 취소는 작성자만 할 수 있습니다.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			//경기 상태를 경기 취소로 변경
			int statusCnt = teamMatchService.modifyTeamMatchToCancel(teamMatchId);
			if(statusCnt == 0) {
				request.setAttribute("error", "이미 상대 팀이 확정되어 취소할 수 없는 경기입니다.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			String cancelReason = "작성자 경기 취소";
			//경기 참가자에서 수정하기.
			int partiCnt = tmpService.modifyTeamMatchParticipantToCancel(cancelReason, teamMatchId, user.getUserId());
			if(partiCnt == 0) {
				System.out.println("참가자 상태 안 바뀜");
			}
			response.sendRedirect(request.getContextPath()+"/team-match/detail/view?teamMatchId="+teamMatchId);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 경기 취소시 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

}
