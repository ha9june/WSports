package controller.match;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		BigDecimal minLat = new BigDecimal(request.getParameter("minLat"));
		BigDecimal maxLat = new BigDecimal(request.getParameter("maxLat"));
		BigDecimal minLng = new BigDecimal(request.getParameter("minLng"));
		BigDecimal maxLng = new BigDecimal(request.getParameter("maxLng"));
		String requestType = request.getParameter("requestType");

		Map<String, Object> param = new HashMap<>();
		param.put("minLat", minLat);
		param.put("maxLat", maxLat);
		param.put("minLng", minLng);
		param.put("maxLng", maxLng);
		
		PersonalMatchService service = new PersonalMatchServiceImpl();
		if(requestType!=null &&  requestType.equals("ajax")) {
			try {
				List<PersonalMatch> mapMatchList = service.getMapMatch(param);
				
				System.out.println(mapMatchList);
				Gson gson = new Gson();
				response.getWriter().write(gson.toJson(mapMatchList));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}

}
