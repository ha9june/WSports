package controller.mypage;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.User;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;

/**
 * Servlet implementation class MypageMatchesSaved
 */
@WebServlet("/mypage/matches/saved")
public class MypageMatchesSaved extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MypageMatchesSaved() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/jsp/mypage/myPageHeartMatch.jsp").forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain; charset=UTF-8");
		//로그인 체크	
		HttpSession session = request.getSession(false);
		User user = (session == null) ? null : (User) session.getAttribute("user");
		if(user==null) {
			response.getWriter().write("login");
			return;// 로그인 경로 수정
		}
		long userId = user.getUserId();
		long matchId = Long.parseLong(request.getParameter("matchId"));
//		String heart = request.getParameter("heart");
		String matchType = request.getParameter("matchType");
		PersonalMatchService service = new PersonalMatchServiceImpl();
		
		if (matchType == null || matchType.isEmpty()) {
		    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		    response.getWriter().write("error");
		    return;
		}
		
		Map<String ,Object> param = new HashMap<>();
		param.put("matchId", matchId);
		param.put("userId", userId);
		param.put("matchType",matchType);
		try {
			boolean toggle = service.toggleMyPageHeartMatch(userId, matchId, matchType);
			response.getWriter().write(toggle ? "insert":"delete");
		}catch(Exception e) {
			e.printStackTrace();
			response.getWriter().write("오류가 생겼습니다.");
			
		}
		
	
	
	}
}
