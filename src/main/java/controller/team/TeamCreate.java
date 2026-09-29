package controller.team;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.Team;
import dto.User;

/**
 * Servlet implementation class TeamCreate
 */
@WebServlet("/team/create")
@MultipartConfig(
		maxFileSize = 1024*1024*10, //개별 파일 최대 크키(10MB)
		maxRequestSize = 1024*1024*10*5, //전체 요청 최대 크키(50MB)
		fileSizeThreshold = 1024*1024*1 //1MB 초과시 임시 디스크 경로 사용
	)
public class TeamCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamCreate() {
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
		User user = new User();
		Team team = new Team();
		
		String uploadPath = (String)request.getServletContext().getAttribute("uploadPath");
		String realPath = request.getServletContext().getRealPath(uploadPath);
		
		Part logoImg = request.getPart("logoImg");
		Part activityImg1 = request.getPart("activityImg1");
		Part activityImg2 = request.getPart("activityImg2");
		Part activityImg3 = request.getPart("activityImg3");
		Part activityImg4 = request.getPart("activityImg4");
		Part activityImg5 = request.getPart("activityImg5");
		System.out.println(logoImg);
		System.out.println(activityImg1);
		System.out.println(activityImg2);
		System.out.println(activityImg3);
		System.out.println(activityImg4);
		System.out.println(activityImg5);
		
		team.setTeamName(request.getParameter("teamName"));
		team.setSport(request.getParameter("sportCode"));
		
		String days = request.getParameter("days");
		boolean dayMon = days.contains("월");
		boolean dayTue = days.contains("화");
		boolean dayWed = days.contains("수");
		boolean dayThu = days.contains("목");
		boolean dayFri = days.contains("금");
		boolean daySat = days.contains("토");
		boolean daySun = days.contains("일");
		team.setDayMon(dayMon);
		team.setDayTue(dayTue);
		team.setDayWed(dayWed);
		team.setDayThu(dayThu);
		team.setDayFri(dayFri);
		team.setDaySat(daySat);
		team.setDaySun(daySun);
		
		String times = request.getParameter("times");
		boolean time0609 = times.contains("새벽 06~09시");
		boolean time0912 = times.contains("오전 09~12시");
		boolean time1218 = times.contains("오후 12~18시");
		boolean time1822 = times.contains("저녁 18~22시");
		boolean time2206 = times.contains("야간 22~06시");
		team.setTime0609(time0609);
		team.setTime0912(time0912);
		team.setTime1218(time1218);
		team.setTime1822(time1822);
		team.setTime2206(time2206);
		
		String ages = request.getParameter("ages");
		boolean age20s = ages.contains("20대");
		boolean age30s = ages.contains("30대");
		boolean age40s = ages.contains("40대");
		boolean age50s = ages.contains("50대 이상");
		boolean age60Plus = ages.contains("연령무관");
		team.setAge20s(age20s);
		team.setAge30s(age30s);
		team.setAge40s(age40s);
		team.setAge50s(age50s);
		team.setAge60Plus(age60Plus);
		
		
		
		
		

	}

}
