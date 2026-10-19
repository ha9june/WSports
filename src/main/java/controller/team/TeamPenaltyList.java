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
		    long teamId = Long.parseLong(teamIdParam);
		    TeamPenaltyService service = new TeamPenaltyServiceImpl();
		    try {
		        // 1) 역할 확인: 주장/부주장만 접근 가능
		        String role = service.getMyTeamRole(user.getUserId(), teamId);
		        boolean isManager = "CAPTAIN".equals(role) || "VICE_CAPTAIN".equals(role);
		        if (!isManager) {
		            response.sendRedirect(request.getContextPath() + "/team/detail/view?teamId=" + teamId);
		            return;
		        }
		        request.setAttribute("isManager", true);

		        // 2) 패널티 데이터 조회
		        Map<String, Object> result =
		                service.getMypageMyTeamPenalty(user.getUserId(), teamId);
		        if (result == null) {
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