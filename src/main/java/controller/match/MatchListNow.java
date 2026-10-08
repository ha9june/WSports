package controller.match;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
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
 * Servlet implementation class MatchListRecomand
 */
@WebServlet("/match/list/now")
public class MatchListNow extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchListNow() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String requestType = request.getParameter("requestType");
		String searchType = request.getParameter("searchType");

		
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		System.out.println("-------------------------");
		System.out.println(user);
		
		PersonalMatchService service = new PersonalMatchServiceImpl();
		
		if(requestType!=null &&  requestType.equals("ajax")) {
			try {
				
				MatchSearchInfo searchInfo = new MatchSearchInfo();
				searchInfo.setSearchType(searchType);
				if(user!=null) {
					searchInfo.setRegions(new String[] {
					    user.getPreferredRegion1(),
					    user.getPreferredRegion2(),
					    user.getPreferredRegion3()
					});
					searchInfo.setSports(new String[] {
					    user.getPreferredSport1(),
					    user.getPreferredSport2(),
					    user.getPreferredSport3()
					});
					searchInfo.setUserId(user.getUserId());
				}       
				List<PersonalMatch> nowMatchList = service.getNowMatchList(searchInfo);
				
				
				System.out.println(nowMatchList);
				Gson gson = new Gson();
				response.getWriter().write(gson.toJson(nowMatchList));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
