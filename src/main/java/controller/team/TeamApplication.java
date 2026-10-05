package controller.team;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Notification;
import dto.Team;
import dto.User;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;
import service.team.TeamApplicationService;
import service.team.TeamApplicationServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;

/**
 * Servlet implementation class TeamApplication
 */
@WebServlet("/team/application")
public class TeamApplication extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamApplication() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**ㄴ
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		TeamService teamService = new TeamServiceImpl();
		

		
		try {
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			User user = (User)session.getAttribute("user");
			
		    if (user == null) {
		        response.sendRedirect(request.getContextPath() + "/auth/login");
		        return;
		    }
			
			Team team = teamService.getTeam(teamId);
			String sport = team.getSport();
			if ("축구/풋살".equals(sport)) {
			    request.setAttribute("sportSkill", user.getSoccerSkill());
			} else if ("농구".equals(sport)) {
			    request.setAttribute("sportSkill", user.getBasketballSkill());
			} else if ("테니스".equals(sport)) {
			    request.setAttribute("sportSkill", user.getTennisSkill());
			} else if ("배드민턴".equals(sport)) {
			    request.setAttribute("sportSkill", user.getBadmintonSkill());
			}
			
			String regions ="";
			String sports = "";
			String[] regionLabel = {user.getPreferredRegion1(), user.getPreferredRegion2(), user.getPreferredRegion3()};
			String[] sportLabel = {user.getPreferredSport1(), user.getPreferredSport2(), user.getPreferredSport3()};
			List<String> rParts = new ArrayList<>();
			List<String> sParts = new ArrayList<>();
			for(int i=0; i<3; i++) {
				if(regionLabel[i] != null && regionLabel[i].length() > 0) {
					rParts.add(regionLabel[i]);
				}
				if(sportLabel[i] != null && sportLabel[i].length() > 0) {
					sParts.add(sportLabel[i]);
				}
			}
			regions = String.join(" · ", rParts);
			sports = String.join(" · ", sParts);
			
			request.setAttribute("sports", sports);
			request.setAttribute("regions", regions);
			
			request.setAttribute("team", team);
			request.getRequestDispatcher("/jsp/team/teamApplication.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 가입신청 중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TeamApplicationService teamApplicationService = new TeamApplicationServiceImpl();

		//가입신청
		try {
			
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			String message = request.getParameter("message");
			User user = (User)request.getSession().getAttribute("user");
			
		    if (user == null) {
		        response.sendRedirect(request.getContextPath() + "/auth/login");
		        return;
		    }

		    teamApplicationService.application(teamId, user, message);
		    
		    response.sendRedirect(request.getContextPath() + "/team/detail/view?teamId=" + teamId);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "가입 신청 중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

}
