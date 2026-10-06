package controller.mypage;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TeamApplicationDao;
import dao.TeamApplicationDaoImpl;
import dto.PersonalMatch;
import dto.TeamApplication;
import dto.User;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import service.match.TeamMatchService;
import service.match.TeamMatchServiceImpl;
import service.team.TeamApplicationService;
import service.team.TeamApplicationServiceImpl;
import util.PageInfo;

/**
 * Servlet implementation class MypageClubs
 */
@WebServlet("/mypage/clubs")
public class MypageClubs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MypageClubs() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				//로그인 체크	
				HttpSession session = request.getSession(false);
				User user = (session == null) ? null : (User) session.getAttribute("user");
				if(user==null) {
					response.sendRedirect(request.getContextPath()+"/login");
					return;// 로그인 경로 수정
				}
				long userId = user.getUserId();

				// 페이지 번호 (기본 1)
				int page = 1;
				String sPage = request.getParameter("page");
				if (sPage != null && !sPage.isEmpty()) {
					try {
						page = Integer.parseInt(sPage);
					} catch (NumberFormatException e) {
						page = 1;
					}
				}
				String state = request.getParameter("state");
				if (state == null || state.isEmpty()) state = "joined";
				String status = request.getParameter("status");
			    String sport = request.getParameter("sport");
				PageInfo pageInfo = new PageInfo(page);
				TeamApplicationService service = new TeamApplicationServiceImpl();
				
				try {
					List<Map<String, Object>> list;
					if ("applications".equals(state)) {
						list = service.MypageMyTeamList(pageInfo, userId, status, sport);   // 가입 신청 (승인 대기)
					} else {
						list = service.MypageJoinedTeamList(pageInfo, userId, status, sport);       // 가입한 팀 (승인)
					}
			        request.setAttribute("match", list);
			        request.setAttribute("pageInfo", pageInfo);
			        request.setAttribute("status", status);
			        request.setAttribute("sport", sport);
			        request.setAttribute("state", state);
					request.getRequestDispatcher("/jsp/mypage/myPageMyTeam.jsp").forward(request, response);
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("err", "개인 경기 목록 조회 오류");
				}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
