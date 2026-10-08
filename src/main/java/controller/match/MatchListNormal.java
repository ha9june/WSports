package controller.match;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dto.PersonalMatch;
import dto.User;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import util.MatchSearchInfo;

/**
 * Servlet implementation class MatchListNormal
 */
@WebServlet("/match/list/normal")
public class MatchListNormal extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchListNormal() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		String requestType = request.getParameter("requestType");
		Integer page = Integer.parseInt(request.getParameter("page"));
		
		String sportsParam = request.getParameter("sports");
		String gender = request.getParameter("gender");
		String agesParam = request.getParameter("ages");
		String skillsParam = request.getParameter("skills");
		String startDataParam = request.getParameter("startDate");
		String endDataParam = request.getParameter("endDate");
		String keyword = request.getParameter("keyword");
		String[] regions = request.getParameterValues("regions");
		
		String[] sports = sportsParam != null && !sportsParam.isBlank()
		        ? sportsParam.split(",")
		        : null;
		String[] ages = agesParam != null && !agesParam.isBlank()
		        ? agesParam.split(",")
		        : null;
		String[] skills = skillsParam != null && !skillsParam.isBlank()
		        ? skillsParam.split(",")
		        : null;
		
		LocalDate startDate = startDataParam == null || startDataParam.isBlank()
		        ? null
		        : LocalDate.parse(startDataParam);

		LocalDate endDate = endDataParam == null || endDataParam.isBlank()
		        ? null
		        : LocalDate.parse(endDataParam);
		
		int startIndex = (page-1)*4;

		MatchSearchInfo searchInfo = new MatchSearchInfo();
		searchInfo.setStartIndex(startIndex);
		searchInfo.setSports(sports);
		searchInfo.setGender(gender);
		searchInfo.setAges(ages);
		searchInfo.setSkills(skills);
		searchInfo.setStartDate(startDate);
		searchInfo.setEndDate(endDate);
		searchInfo.setKeyword(keyword);
		searchInfo.setRegions(regions);
		if(user!=null) {
			searchInfo.setUserId(user.getUserId());
		}

		
		System.out.println(searchInfo);
		
		

		PersonalMatchService service = new PersonalMatchServiceImpl();
		if(requestType!=null &&  requestType.equals("ajax")) {
			try {
				List<PersonalMatch> normalMatchList = service.getNormalMatchList(searchInfo);
				
				System.out.println(normalMatchList);
				Gson gson = new Gson();
				response.getWriter().write(gson.toJson(normalMatchList));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	
	}

}
