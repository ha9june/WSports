package controller.home;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.PersonalMatch;
import dto.Team;
import dto.TeamSearchCondition;
import dto.User;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;
import util.MatchSearchInfo;

/**
 * Servlet implementation class HomeMain
 */
@WebServlet("/home/main")
public class HomeMain extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeMain() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		

		
		PersonalMatchService matchService = new PersonalMatchServiceImpl();
		TeamService teamService = new TeamServiceImpl();
		try {
			
			MatchSearchInfo searchInfo = new MatchSearchInfo();
			TeamSearchCondition condition = new TeamSearchCondition();
			if(user!=null) {
				
				String[] preferredSports = new String[] {
					user.getPreferredSport1(),
				    user.getPreferredSport2(),
				    user.getPreferredSport3()
				};
				searchInfo.setSearchType("RECOMAND");
				searchInfo.setRegions(new String[] {
						user.getPreferredRegion1(),
					    user.getPreferredRegion2(),
					    user.getPreferredRegion3()
					});
				searchInfo.setSports(preferredSports);
				
				
				condition.setSearchType("RECOMAND");
				condition.setSports(preferredSports);
				
				
			}else {
				searchInfo.setSearchType("POPULAR");
				condition.setSearchType("NEW");
			}

			List<PersonalMatch> nowMatchList = matchService.getNowMatchList(searchInfo);
			List<Team> nowTeamList = teamService.getNowTeamList(condition);

			System.out.println(nowMatchList);
			System.out.println(nowTeamList);
			
			request.setAttribute("nMList", nowMatchList);
			request.setAttribute("nTList", nowTeamList);
			request.getRequestDispatcher("/jsp/home/main.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	
	}
}
