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
		String requestType = request.getParameter("requestType");
		System.out.println(requestType);
		PersonalMatchService service = new PersonalMatchServiceImpl();
		
		if(requestType!=null &&  requestType.equals("ajax")) {
			try {
				List<PersonalMatch> recomandMatchList = service.getRecomandMatch();
				
				System.out.println(recomandMatchList);
				Gson gson = new Gson();
				response.getWriter().write(gson.toJson(recomandMatchList));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	
	}

}
