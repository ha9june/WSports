package controller.team;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.User;
import service.team.TeamPenaltyService;
import service.team.TeamPenaltyServiceImpl;

/**
 * Servlet implementation class MypageTeamPenalty
 */
@WebServlet("/team/penalty")
public class TeamPenaltyList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamPenaltyList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User user = (session == null) ? null : (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		String teamIdParam = request.getParameter("teamId");
		if (teamIdParam == null || !teamIdParam.matches("\\d+")) {
		    response.sendError(HttpServletResponse.SC_BAD_REQUEST);  
		    return;
		}
				TeamPenaltyService service = new TeamPenaltyServiceImpl();
		try {
			Map<String, Object> result = service.getMypageMyTeamPenalty(user.getUserId(), Long.parseLong(teamIdParam));
			if (result == null) { // 내가 속한 팀이 아님
				response.sendError(HttpServletResponse.SC_FORBIDDEN);
				return;
			}
			for (Map.Entry<String, Object> e : result.entrySet()) {
				request.setAttribute(e.getKey(), e.getValue());
			}
		} catch (Exception e) {
			throw new ServletException(e);
		}
		request.getRequestDispatcher("/jsp/team/teamPenaltyList.jsp").forward(request, response);
	}
}
