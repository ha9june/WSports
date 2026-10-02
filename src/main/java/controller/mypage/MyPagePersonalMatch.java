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
		// TODO Auto-generated constructor stub
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
		// 선택 날짜 (yyyy-MM-dd)
		String date = request.getParameter("date");
		try {
			if (date != null && !date.isEmpty())
				LocalDate.parse(date);
			else
				date = null;
		} catch (Exception e) {
			date = null;
		}
		
	    // 조회 월: ym 우선 → month → date의 월 → 이번 달
	    YearMonth current;
	    try {
	        String ymParam = request.getParameter("ym");
	        if (ymParam == null || ymParam.isEmpty()) ymParam = request.getParameter("month");
	        if (ymParam != null && !ymParam.isEmpty()) {
	            current = YearMonth.parse(ymParam);           // 잘못된 값이면 예외
	        } else if (date != null) {
	            current = YearMonth.from(LocalDate.parse(date));
	        } else {
	            current = YearMonth.now();
	        }
	    } catch (Exception e) {
	        current = YearMonth.now();
	    }
		
	    String month = current.toString();             // yyyy-MM
	    String status = request.getParameter("status");
	    String sport = request.getParameter("sport");
	    
		PageInfo pageInfo = new PageInfo(page);
		PersonalMatchService service = new PersonalMatchServiceImpl();
		try {
			List<PersonalMatch> list = service.MyPagePersonalMatchList(pageInfo, userId, month, status,sport);

	        request.setAttribute("match", list);
	        request.setAttribute("calMatch", list);           // 달력 강조용
	        request.setAttribute("pageInfo", pageInfo);
	        request.setAttribute("month", month);
	        request.setAttribute("ym", month);
	        request.setAttribute("status", status);
	        request.setAttribute("selectedDate", date);
	        request.setAttribute("sport", sport);
	        
	        
	        // 월 이동용
	        request.setAttribute("prevMonth", current.minusMonths(1).toString());
	        request.setAttribute("nextMonth", current.plusMonths(1).toString());
	        request.setAttribute("todayDate", LocalDate.now().toString());
	        
	        // 날짜를 눌렀을 때만 해당 날짜 경기로 필터
	        if (date != null) {
	            List<PersonalMatch> filtered = new ArrayList<>();
	            for (PersonalMatch pm : list) {
	                if (date.equals(String.valueOf(pm.getMatchDate()))) filtered.add(pm);
	            }
	            request.setAttribute("match", filtered);
	        }
			
			request.getRequestDispatcher("/jsp/mypage/myPagePersonalMatch.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "경기 목록 조회 오류");
		}
	}
}
