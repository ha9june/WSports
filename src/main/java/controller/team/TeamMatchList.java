package controller.team;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
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

import dto.TeamMatch;
import dto.TeamSearchCondition;
import dto.User;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;

/**
 * Servlet implementation class TeamMatchList
 */
@WebServlet("/team-match/list")
public class TeamMatchList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamMatchList() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    private String[] split(String s) {
        return (s == null || s.trim().isEmpty()) ? null : s.split(",");
    }
    
    private String emptyToNull(String s) {
        return (s == null || s.trim().isEmpty()) ? null : s;
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user = (User)request.getSession().getAttribute("user");
			TeamMatchService teamMatchService = new TeamMatchServiceImpl();
			
			TeamSearchCondition cond = new TeamSearchCondition();
			String[] sports = split(request.getParameter("sports"));
			String gender  = emptyToNull(request.getParameter("gender"));
			if ("성별 무관".equals(gender)) gender = null;
			String[] days = split(request.getParameter("days"));
			String[] skills = split(request.getParameter("skills"));
			String[] ages = split(request.getParameter("ages"));
			if (ages != null && java.util.Arrays.asList(ages).contains("연령 무관")) {
			    ages = null;
			}
			String[] matchPeople = split(request.getParameter("matchPeople"));

			String[] regions = request.getParameterValues("regions");
			String startDate = emptyToNull(request.getParameter("startDate"));
			String endDate = emptyToNull(request.getParameter("endDate"));
			String keyword = emptyToNull(request.getParameter("keyword"));
			
			if(user != null) {
				cond.setUserId(user.getUserId());
			}
			
			int page = 1;
			try { page = Integer.parseInt(request.getParameter("page")); } catch (Exception e) { page = 1; }
			if (page < 1) page = 1;
			
			int offset = (page - 1) * 5;
			
			cond.setOffset(offset);
		    cond.setSports(sports);
		    cond.setGender(gender);
		    cond.setDays(days);
		    cond.setSkills(skills);
		    cond.setAges(ages);
		    cond.setMatchPeople(matchPeople);
		    cond.setRegions(regions);
		    cond.setStartDate(startDate);
		    cond.setEndDate(endDate);
		    cond.setKeyword(keyword);
		    
		    List<TeamMatch> teamMatchList = teamMatchService.getTeamMatchListSearch(cond);
		    request.setAttribute("teamMatchList", teamMatchList);
		    
		    String requestType = request.getParameter("requestType");
		    int teamMatchCnt = teamMatchService.getTeamMatchListSearchCnt(cond);
		    if ("ajax".equals(requestType)) {
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    
		        Map<String, Object> result = new HashMap<>();
		        result.put("teamMatchList", teamMatchList);
		        result.put("teamMatchCnt", teamMatchCnt);
			    
		        Gson gson = new GsonBuilder()
		        	    .registerTypeAdapter(LocalDate.class,
		        	        (JsonSerializer<LocalDate>) (s, t, c) -> new JsonPrimitive(s.toString()))
		        	    .registerTypeAdapter(LocalTime.class,
		        	        (JsonSerializer<LocalTime>) (s, t, c) -> new JsonPrimitive(s.toString()))
		        	    .registerTypeAdapter(LocalDateTime.class,
		        	        (JsonSerializer<LocalDateTime>) (s, t, c) -> new JsonPrimitive(s.toString()))
		        	    .create();
		        request.setAttribute("teamMatchCnt", teamMatchCnt);
			    response.getWriter().write(gson.toJson(result));
			} else {
				request.setAttribute("teamMatchCnt", teamMatchCnt);
			    request.setAttribute("cond", cond);
			    request.setAttribute("startDate", startDate);
			    request.setAttribute("endDate", endDate);
				request.getRequestDispatcher("/jsp/team/teamMatchList.jsp").forward(request, response);
			}  
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "상대팀 찾기 로딩중 오류 발생");
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
