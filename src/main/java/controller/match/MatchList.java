package controller.match;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.PersonalMatch;
import dto.User;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;

/**
 * Servlet implementation class MatchList
 */
@WebServlet("/match/list")
public class MatchList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


//		response.sendRedirect(
//			    request.getContextPath() + "/jsp/match/personalMatchList.jsp"
//			);
//		
		request.getRequestDispatcher("/jsp/match/personalMatchList.jsp").forward(request, response);;

		
		
		
		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
