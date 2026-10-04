package controller.match;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.PersonalMatch;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import util.MatchSearchInfo;

/**
 * Servlet implementation class MatchListMap
 */
@WebServlet("/match/list/map")
public class MatchListMap extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchListMap() {
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
		String requestType = request.getParameter("requestType");

		String sportsParam = request.getParameter("sports");
		String gender = request.getParameter("gender");
		String agesParam = request.getParameter("ages");
		String skillsParam = request.getParameter("skills");
		
		BigDecimal minLat = new BigDecimal(request.getParameter("minLat"));
		BigDecimal maxLat = new BigDecimal(request.getParameter("maxLat"));
		BigDecimal minLng = new BigDecimal(request.getParameter("minLng"));
		BigDecimal maxLng = new BigDecimal(request.getParameter("maxLng"));
		
		String[] sports = sportsParam != null && !sportsParam.isBlank()
		        ? sportsParam.split(",")
		        : null;
		String[] ages = agesParam != null && !agesParam.isBlank()
		        ? agesParam.split(",")
		        : null;
		String[] skills = skillsParam != null && !skillsParam.isBlank()
		        ? skillsParam.split(",")
		        : null;

		MatchSearchInfo searchInfo = new MatchSearchInfo();
		searchInfo.setSports(sports);
		searchInfo.setGender(gender);
		searchInfo.setAges(ages);
		searchInfo.setSkills(skills);
		searchInfo.setMaxLat(maxLat);
		searchInfo.setMinLat(minLat);
		searchInfo.setMaxLng(maxLng);
		searchInfo.setMinLng(minLng);
		
		System.out.println(searchInfo);
		
		PersonalMatchService service = new PersonalMatchServiceImpl();
		if(requestType!=null &&  requestType.equals("ajax")) {
			try {
				List<PersonalMatch> mapMatchList = service.getMapMatch(searchInfo);
				
				System.out.println(mapMatchList);
				Gson gson = new Gson();
				response.getWriter().write(gson.toJson(mapMatchList));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}

}
