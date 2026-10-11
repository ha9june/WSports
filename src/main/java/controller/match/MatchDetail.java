package controller.match;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.PersonalMatch;
import dto.PersonalMatchParticipant;
import dto.User;
import service.match.PersonalMatchParticipantService;
import service.match.PersonalMatchParticipantServiceImpl;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import util.CheckUtil;

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
		User user = CheckUtil.getLoginUser(request);
		if (user == null) {
		    response.sendRedirect(request.getContextPath() + "/auth/login");
		    return;
		}

		Long personalMatchId = Long.parseLong(request.getParameter("personalMatchId"));

		PersonalMatchService pmService = new PersonalMatchServiceImpl();
		PersonalMatchParticipantService pmpService = new PersonalMatchParticipantServiceImpl();
		try {
			
			PersonalMatch pm = new PersonalMatch();
			pm.setPersonalMatchId(personalMatchId);
			if(user!=null)
				pm.setUserId(user.getUserId());
			

			PersonalMatch pMatch = pmService.getPersonalMatchDetail(pm);
			
			Boolean applied = false;
			if(user!=null) {
				HashMap<String,Object> map = new HashMap<>();
				map.put("userId", user.getUserId());
				map.put("personalMatchId", personalMatchId);
				PersonalMatchParticipant participant = pmpService.getParticipant(map);
				if(participant != null && participant.getStatus().equals("결제완료")) {
					applied = true;
				}
			}
			request.setAttribute("applied",applied);
			System.out.println(pMatch);
			request.setAttribute("personalMatch", pMatch);
			request.getRequestDispatcher("/jsp/match/personalMatchDetail.jsp").forward(request, response);	
			
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
