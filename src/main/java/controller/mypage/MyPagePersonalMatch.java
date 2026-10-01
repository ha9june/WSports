package controller.mypage;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.PersonalMatch;
import dto.User;

import java.util.List;
import java.util.Map;

import util.PageInfo;

import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;

/**
 * Servlet implementation class MyPagePersonalMatch
 */
@WebServlet("/mypage/matches/participating")
public class MyPagePersonalMatch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyPagePersonalMatch() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    // 로그인 체크
	    HttpSession session = request.getSession(false);
	    User user = (session == null) ? null : (User) session.getAttribute("user");
	    if (user == null) {
	        response.sendRedirect(request.getContextPath() + "/login");   // 로그인 경로에 맞게 수정
	        return;
	    }
	    long userId = user.getUserId();
	    System.out.println(userId+"// 가져옴");

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
		
	    String month = request.getParameter("month");

	    PageInfo pageInfo = new PageInfo(page);
	    PersonalMatchService service = new PersonalMatchServiceImpl();
		try {
			List<PersonalMatch> list = service.MyPagePersonalMatchList(pageInfo, userId, month);
			 request.setAttribute("MyPagePersonalMatchList", list);
		     request.setAttribute("pageInfo", pageInfo);
		     request.setAttribute("month", month);   // 검색 조건 유지용
		     request.getRequestDispatcher("/jsp/mypage/myPagePersonalMatch.jsp").forward(request, response);
		
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "게시글 목록 조회 오류");
		}
	}
}
