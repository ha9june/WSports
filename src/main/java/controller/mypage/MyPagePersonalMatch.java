package controller.mypage;

import java.io.IOException;
import java.time.LocalDate;
import java.time.YearMonth;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.SystemPropertyUtils;

import dto.PersonalMatch;
import dto.User;

import java.util.ArrayList;
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
		// TODO Auto-generated constructora stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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
	    String status = request.getParameter("status");
	    String sport = request.getParameter("sport");
	    //달력
	    String startDate = request.getParameter("startDate");
	    String endDate = request.getParameter("endDate");
	    if (startDate != null && startDate.isEmpty()) startDate = null;
	    if (endDate != null && endDate.isEmpty()) endDate = null;
		PageInfo pageInfo = new PageInfo(page);
		PersonalMatchService service = new PersonalMatchServiceImpl();
		
		try {
			List<PersonalMatch> list = service.MyPagePersonalMatchList(pageInfo,userId,status,sport,startDate,endDate);
	        request.setAttribute("match", list);
	        request.setAttribute("pageInfo", pageInfo);
	        request.setAttribute("status", status);
	        request.setAttribute("sport", sport);
	        request.setAttribute("startDate", startDate);
			request.setAttribute("endDate", endDate);
			request.setAttribute("matchDates", service.getMyPagePersonalMatchDates(userId, status, sport));
			System.out.println("list=" + list.size() + ", curPage=" + pageInfo.getCurPage()
		    + ", allPage=" + pageInfo.getAllPage());
			request.getRequestDispatcher("/jsp/mypage/myPagePersonalMatch.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "개인 경기 목록 조회 오류");
		}
	}
}
