package controller.match;

import java.io.IOException;
import java.util.Collections;
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
		String data = request.getParameter("data");
		System.out.println(data);
		System.out.println(requestType);
		System.out.println(searchType);
		PersonalMatchService service = new PersonalMatchServiceImpl();
		
		if(requestType!=null &&  requestType.equals("ajax")) {
			try {
				List<PersonalMatch> recomandMatchList = service.getRecomandMatch();
				
				if(searchType.equals("POPULAR")) {
					Collections.swap(recomandMatchList, 0, 1);
				}else if(searchType.equals("END")) {
					Collections.swap(recomandMatchList, 0, 2);
				}else if(searchType.equals("NEW")) {
					Collections.swap(recomandMatchList, 1, 2);
				}else {
					
				}
				System.out.println(recomandMatchList);
				Gson gson = new Gson();
				response.getWriter().write(gson.toJson(recomandMatchList));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
