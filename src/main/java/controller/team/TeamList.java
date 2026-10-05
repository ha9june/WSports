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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;

import dto.Team;
import dto.TeamSearchCondition;
import service.team.TeamService;
import service.team.TeamServiceImpl;

/**
 * Servlet implementation class TeamList
 */
@WebServlet("/team/list")
public class TeamList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int page = 1;

		String pageParam = request.getParameter("page");

		if (pageParam != null && !pageParam.isEmpty()) {
		    page = Integer.parseInt(pageParam);
		}
		
		int offset = (page - 1) * 12;
		
		String sportsParam = request.getParameter("sports");
		String daysParam = request.getParameter("days");
		String skillsParam = request.getParameter("skills");

		String[] sports = sportsParam != null && !sportsParam.isBlank()
		        ? sportsParam.split(",")
		        : null;

		String[] days = daysParam != null && !daysParam.isBlank()
		        ? daysParam.split(",")
		        : null;

		String[] skills = skillsParam != null && !skillsParam.isBlank()
		        ? skillsParam.split(",")
		        : null;

		String[] regions = request.getParameterValues("regions");

		String gender = request.getParameter("gender");
		String keyword = request.getParameter("keyword");
		String sort = request.getParameter("sort");
		
		TeamSearchCondition condition = new TeamSearchCondition();
		condition.setOffset(offset);
		condition.setSports(sports);
		condition.setGender(gender);
		condition.setDays(days);
		condition.setSkills(skills);
		condition.setRegions(regions);
		condition.setKeyword(keyword);
		condition.setSort(sort);
		
		TeamService teamService = new TeamServiceImpl();
		String requestType = request.getParameter("requestType");
		try {
			List<Team> teamList = teamService.getTeamList(condition);
			int teamCnt = teamService.getTemaListCnt(condition);
			if ("ajax".equals(requestType)) {
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    
		        Map<String, Object> result = new HashMap<>();
		        result.put("teamList", teamList);
		        result.put("teamCnt", teamCnt);
			    
		        Gson gson = new GsonBuilder()
		                .registerTypeAdapter(
		                    LocalDateTime.class,
		                    (JsonSerializer<LocalDateTime>) (src, type, context) ->
		                        new JsonPrimitive(src.toString())
		                )
		                .create();
		        request.setAttribute("teamCnt", teamCnt);
			    response.getWriter().write(gson.toJson(result));
			} else {
			    request.setAttribute("teamList", teamList);
			    request.setAttribute("teamCnt", teamCnt);
			    request.getRequestDispatcher("/jsp/team/teamList.jsp").forward(request, response);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
