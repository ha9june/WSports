package controller.match;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PersonalMatch;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;

/**
 * Servlet implementation class MatchDetail
 */
@WebServlet("/match/detail/view")
public class MatchDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num = Integer.parseInt(request.getParameter("num"));
		
		PersonalMatchService service = new PersonalMatchServiceImpl();
		try {
			
			Map<String,Object> pMatch = service.getPersmalMatchDetail(num);
			System.out.println(pMatch);
			request.setAttribute("personalMatch", pMatch);
			request.getRequestDispatcher("/jsp/match/personalMatchDetail.jsp").forward(request, response);;			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
	}

}
