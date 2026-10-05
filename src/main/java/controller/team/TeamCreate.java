package controller.team;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.Notification;
import dto.Team;
import dto.User;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;

/**
 * Servlet implementation class TeamCreate
 */
@WebServlet("/team/create")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크키(10MB)
		maxRequestSize = 1024 * 1024 * 10 * 5, // 전체 요청 최대 크키(50MB)
		fileSizeThreshold = 1024 * 1024 * 1 // 1MB 초과시 임시 디스크 경로 사용
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
			request.getRequestDispatcher("/jsp/team/teamMakeForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Team team = new Team();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
	    if (user == null) {
	        response.sendRedirect(request.getContextPath() + "/auth/login");
	        return;
	    }
	    
		long userId = user.getUserId();

		String uploadPath = (String) request.getServletContext().getAttribute("uploadPath");
		String realPath = request.getServletContext().getRealPath(uploadPath);

		Part profileImage = request.getPart("profileImage");
		Part activityImg1 = request.getPart("activityImg1");
		Part activityImg2 = request.getPart("activityImg2");
		Part activityImg3 = request.getPart("activityImg3");
		Part activityImg4 = request.getPart("activityImg4");
		Part activityImg5 = request.getPart("activityImg5");

		team.setTeamName(request.getParameter("teamName"));
		team.setSport(request.getParameter("sportCode"));

		String days = request.getParameter("days");
		Set<String> daysSet = new HashSet<>();

		if (days != null && !days.isBlank()) {
			daysSet.addAll(Arrays.asList(days.split(",")));
		}

		team.setDayMon(daysSet.contains("월"));
		team.setDayTue(daysSet.contains("화"));
		team.setDayWed(daysSet.contains("수"));
		team.setDayThu(daysSet.contains("목"));
		team.setDayFri(daysSet.contains("금"));
		team.setDaySat(daysSet.contains("토"));
		team.setDaySun(daysSet.contains("일"));
		String times = request.getParameter("times");
		Set<String> timesSet = new HashSet<>();

		if (times != null && !times.isBlank()) {
			timesSet.addAll(Arrays.asList(times.split(",")));
		}

		team.setTime0609(timesSet.contains("새벽 06~09시"));
		team.setTime0912(timesSet.contains("오전 09~12시"));
		team.setTime1218(timesSet.contains("오후 12~18시"));
		team.setTime1822(timesSet.contains("저녁 18~22시"));
		team.setTime2206(timesSet.contains("야간 22~06시"));

		String ages = request.getParameter("ages");
		Set<String> agesSet = new HashSet<>();

		if (ages != null && !ages.isBlank()) {
			agesSet.addAll(Arrays.asList(ages.split(",")));
		}

		team.setAge20s(agesSet.contains("20대"));
		team.setAge30s(agesSet.contains("30대"));
		team.setAge40s(agesSet.contains("40대"));
		team.setAge50s(agesSet.contains("50대 이상"));
		team.setAge60Plus(agesSet.contains("연령 무관"));

		String[] regions = request.getParameterValues("regions");
		if (regions != null && regions.length >= 1)
			team.setRegion1(regions[0]);
		if (regions != null && regions.length >= 2)
			team.setRegion2(regions[1]);
		if (regions != null && regions.length >= 3)
			team.setRegion3(regions[2]);

		team.setGender(request.getParameter("gender"));
		team.setSkill(request.getParameter("skill"));
		team.setDescription(request.getParameter("intro"));

		TeamService teamService = new TeamServiceImpl();

		try {
			Long teamId = teamService.makeTeam(team, userId, realPath, profileImage, activityImg1, activityImg2,
					activityImg3, activityImg4, activityImg5);
			request.setAttribute("teamId", teamId);

		    response.sendRedirect(request.getContextPath()+"/team/detail/view?teamId="+ teamId);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
