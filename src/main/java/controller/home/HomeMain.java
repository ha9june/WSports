package controller.home;

import java.io.IOException;
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
 * Servlet implementation class HomeMain
 */
@WebServlet("/home/main")
public class HomeMain extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeMain() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		

		
		PersonalMatchService service = new PersonalMatchServiceImpl();
		try {
			
			MatchSearchInfo searchInfo = new MatchSearchInfo();
			if(user!=null) {
				searchInfo.setSearchType("RECOMAND");
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
			}else {
				searchInfo.setSearchType("POPULAR");
			}

			List<PersonalMatch> nowMatchList = service.getNowMatchList(searchInfo);
			System.out.println(nowMatchList);

			request.setAttribute("nList", nowMatchList);
			request.getRequestDispatcher("/jsp/home/main.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	
	}
}
