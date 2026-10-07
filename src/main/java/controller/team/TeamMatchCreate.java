package controller.team;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.Team;
import dto.TeamMatch;
import dto.User;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;

/**
 * Servlet implementation class TeamMatchCreate
 */
@WebServlet("/team-match/create")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크키(10MB)
maxRequestSize = 1024 * 1024 * 10 * 5, // 전체 요청 최대 크키(50MB)
fileSizeThreshold = 1024 * 1024 * 1 // 1MB 초과시 임시 디스크 경로 사용
)
public class TeamMatchCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamMatchCreate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TeamService teamService = new TeamServiceImpl();
		
		User user = (User)request.getSession().getAttribute("user");
	    if (user == null) {
	        response.sendRedirect(request.getContextPath() + "/auth/login");
	        return;
	    }
		try {
			List<Team> teamList = teamService.getTeamInfoByUserManager(user.getUserId());
			request.setAttribute("teamList", teamList);
			request.getRequestDispatcher("/jsp/team/teamMatchMakeForm.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 경기 만들기 접속중 오류 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TeamService teamService = new TeamServiceImpl();
		TeamMatchService teamMatchService = new TeamMatchServiceImpl();
		
		try {
			TeamMatch teamMatch = new TeamMatch();
			
			User user = (User) request.getSession().getAttribute("user");
			teamMatch.setUserId(user.getUserId());
			
			Long teamId = Long.parseLong(request.getParameter("teamNo"));
			teamMatch.setTeamId(teamId);
			
			Team team = teamService.getTeam(teamId);
			teamMatch.setSport(team.getSport());
			teamMatch.setTitle(request.getParameter("title"));
			teamMatch.setMatchDate(LocalDate.parse(request.getParameter("matchDate")));
			teamMatch.setStartTime(LocalTime.parse(request.getParameter("startTime")));
			
			LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
			if(endTime.equals("24:00")) {
				endTime = LocalTime.parse("23:59");
			}
			teamMatch.setEndTime(endTime);
			
			String address = request.getParameter("address");
			teamMatch.setAddress(address);
			
			teamMatch.setPlaceName(request.getParameter("placeName"));
			
			teamMatch.setLatitude(new BigDecimal(request.getParameter("latitude")));
			teamMatch.setLongitude(new BigDecimal(request.getParameter("longitude")));
			teamMatch.setMatchPeople(Integer.parseInt(request.getParameter("teamSize")));
			String participationFeeStr = request.getParameter("participationFee");
			int participationFee = (participationFeeStr == null || participationFeeStr.replaceAll("[^0-9]", "").isEmpty())
                    ? 0 : Integer.parseInt(participationFeeStr.replaceAll("[^0-9]", ""));
			teamMatch.setParticipationFee(participationFee);
			teamMatch.setFee((int)(participationFee * 0.08));
			teamMatch.setDeadline(LocalDateTime.parse(request.getParameter("deadline")));
			
			String ages = request.getParameter("ages");
			Set<String> agesSet = new HashSet<>();
			if (ages != null && !ages.isBlank()) {
				agesSet.addAll(Arrays.asList(ages.split(",")));
			}
			teamMatch.setAge20s(agesSet.contains("20대"));
			teamMatch.setAge30s(agesSet.contains("30대"));
			teamMatch.setAge40s(agesSet.contains("40대"));
			teamMatch.setAge50s(agesSet.contains("50대 이상"));
			teamMatch.setAge60Plus(agesSet.contains("연령 무관"));
			teamMatch.setGender(request.getParameter("gender"));
			
			String skill = request.getParameter("skill");
			Set<String> skillSet = new HashSet<>();
			if (skill != null && !skill.isBlank()) {
				skillSet.addAll(Arrays.asList(skill.split(",")));
			}
			
			teamMatch.setSkillIntro(agesSet.contains("입문"));
			teamMatch.setSkillBeginner(agesSet.contains("초급"));
			teamMatch.setSkillIntermediate(agesSet.contains("중급"));
			teamMatch.setSkillAdvanced(agesSet.contains("상급"));
			teamMatch.setContent(request.getParameter("content"));
			
			String uploadPath = (String) request.getServletContext().getAttribute("uploadPath");
			String realPath = request.getServletContext().getRealPath(uploadPath);
			List<Part> files = new ArrayList<>();
			for (Part p : request.getParts()) {
				if ("photos".equals(p.getName()) && p.getSize() > 0) {
					files.add(p);
				}
			}
			
            String[] addressArr = address.split(" ");
            String region;
            if(("서울").equals(addressArr[0])) {
            	region = addressArr[0]+"시 "+addressArr[1];
            }else {
            	region = addressArr[0]+"도 "+addressArr[1];
            }
            teamMatch.setRegion(region);

            Long teamMatchId = teamMatchService.makeTeamMatch(teamMatch, realPath, files);
            request.getRequestDispatcher("/team-match/detail?teamMatchId="+teamMatchId).forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 경기 생성중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
		
		

	}

}
