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

import dto.TeamMatch;
import dto.User;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamUserService;
import service.team.TeamUserServiceImpl;

/**
 * Servlet implementation class TeamMatchEdit
 */
@WebServlet("/team-match/edit")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크키(10MB)
maxRequestSize = 1024 * 1024 * 10 * 5, // 전체 요청 최대 크키(50MB)
fileSizeThreshold = 1024 * 1024 * 1 // 1MB 초과시 임시 디스크 경로 사용
)
public class TeamMatchEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamMatchEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user = (User)request.getSession().getAttribute("user");
			Long teamMatchId = Long.parseLong(request.getParameter("teamMatchId"));
			if(user == null) {
				response.sendRedirect(request.getContextPath()+"/auth/login");
				return;
			}
			TeamMatchService teamMatchService = new TeamMatchServiceImpl();
			TeamMatch tm = teamMatchService.getTeamMatchNotUser(teamMatchId);
			if((!tm.getUserId().equals(user.getUserId()))) {
				request.setAttribute("error", "글 작성자가 아닙니다.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			if(!(tm.getStatus().equals("모집중"))){
				request.setAttribute("error", "상대팀이 있으면 수정할 수 없어요.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			List<String> ageList = new ArrayList<>();
			if (Boolean.TRUE.equals(tm.getAge20s())) ageList.add("20대");
			if (Boolean.TRUE.equals(tm.getAge30s())) ageList.add("30대");
			if (Boolean.TRUE.equals(tm.getAge40s())) ageList.add("40대");
			if (Boolean.TRUE.equals(tm.getAge50s())) ageList.add("50대 이상");
			if (Boolean.TRUE.equals(tm.getAge60Plus())) ageList.add("연령 무관");

			List<String> skillList = new ArrayList<>();
			if (Boolean.TRUE.equals(tm.getSkillIntro())) skillList.add("입문");
			if (Boolean.TRUE.equals(tm.getSkillBeginner())) skillList.add("초급");
			if (Boolean.TRUE.equals(tm.getSkillIntermediate())) skillList.add("중급");
			if (Boolean.TRUE.equals(tm.getSkillAdvanced())) skillList.add("상급");

			List<String> imageList = new ArrayList<>();
			for (String img : new String[]{tm.getImage1(), tm.getImage2(), tm.getImage3(), tm.getImage4(), tm.getImage5()}) {
			    if (img != null && !img.isEmpty()) imageList.add(img);
			}
			
			request.setAttribute("t", tm);
			request.setAttribute("agesValue", String.join(",", ageList));
			request.setAttribute("skillsValue", String.join(",", skillList));
			request.setAttribute("imageList", imageList);
			
			request.getRequestDispatcher("/jsp/team/teamMatchEdit.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "상대팀 찾기 글 수정 접속 중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		TeamMatchService teamMatchService = new TeamMatchServiceImpl();
		TeamUserService teamUserService = new TeamUserServiceImpl();

		try {
			Long teamMatchId = Long.parseLong(request.getParameter("teamMatchId"));

			// 기존 글 조회 (작성자/상태/팀 확인용)
			TeamMatch origin = teamMatchService.getTeamMatchNotUser(teamMatchId);
			if (origin == null || !origin.getUserId().equals(user.getUserId())) {
				request.setAttribute("error", "수정 권한이 없어요.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			
			if (!"모집중".equals(origin.getStatus())) {
				request.setAttribute("error", "상대팀이 있으면 수정할 수 없어요.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			
			// 현재 주장/부주장인지도 확인
			String role = teamUserService.getRole(origin.getTeamId(), user.getUserId());
			if (!"CAPTAIN".equals(role) && !"VICE_CAPTAIN".equals(role)) {
				request.setAttribute("error", "주장 또는 부주장만 수정할 수 있어요.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}

			TeamMatch teamMatch = new TeamMatch();
			teamMatch.setTeamMatchId(teamMatchId);
			teamMatch.setUserId(user.getUserId());          // update where 조건용

			teamMatch.setTitle(request.getParameter("title"));
			teamMatch.setContent(request.getParameter("content"));
			teamMatch.setMatchDate(LocalDate.parse(request.getParameter("matchDate")));
			teamMatch.setStartTime(LocalTime.parse(request.getParameter("startTime")));

			String endStr = request.getParameter("endTime");
			teamMatch.setEndTime("24:00".equals(endStr) ? LocalTime.of(23, 59, 59) : LocalTime.parse(endStr));

			String address = request.getParameter("address");
			teamMatch.setAddress(address);
			teamMatch.setPlaceName(request.getParameter("placeName"));
			teamMatch.setLatitude(new BigDecimal(request.getParameter("latitude")));
			teamMatch.setLongitude(new BigDecimal(request.getParameter("longitude")));

			teamMatch.setMatchPeople(Integer.parseInt(request.getParameter("teamSize")));

			String feeStr = request.getParameter("participationFee");
			String feeDigits = feeStr == null ? "" : feeStr.replaceAll("[^0-9]", "");
			int participationFee = feeDigits.isEmpty() ? 0 : Integer.parseInt(feeDigits);
			teamMatch.setParticipationFee(participationFee);
			teamMatch.setFee((int) (participationFee * 0.08));      // 작성 때와 같은 수수료 규칙

			teamMatch.setDeadline(LocalDateTime.parse(request.getParameter("deadline")));

			// 연령대
			String ages = request.getParameter("ages");
			Set<String> agesSet = new HashSet<>();
			if (ages != null && !ages.isBlank()) {
				agesSet.addAll(Arrays.asList(ages.split(",")));
			}
			boolean anyAge = agesSet.contains("연령 무관");
			teamMatch.setAge20s(anyAge || agesSet.contains("20대"));
			teamMatch.setAge30s(anyAge || agesSet.contains("30대"));
			teamMatch.setAge40s(anyAge || agesSet.contains("40대"));
			teamMatch.setAge50s(anyAge || agesSet.contains("50대 이상"));
			teamMatch.setAge60Plus(anyAge);

			// 성별
			teamMatch.setGender(request.getParameter("gender"));

			// 팀 레벨
			String skill = request.getParameter("skill");
			Set<String> skillSet = new HashSet<>();
			if (skill != null && !skill.isBlank()) {
				skillSet.addAll(Arrays.asList(skill.split(",")));
			}
			teamMatch.setSkillIntro(skillSet.contains("입문"));
			teamMatch.setSkillBeginner(skillSet.contains("초급"));
			teamMatch.setSkillIntermediate(skillSet.contains("중급"));
			teamMatch.setSkillAdvanced(skillSet.contains("상급"));

			// 지역 (작성 때와 같은 규칙)
			String[] addressArr = address.split(" ");
			String region = "서울".equals(addressArr[0]) ? addressArr[0] + "시 " + addressArr[1]
					: addressArr[0] + "도 " + addressArr[1];
			teamMatch.setRegion(region);

			// 사진: 남길 기존 사진 + 새로 올린 사진
			String[] keepArr = request.getParameterValues("keepImages");
			List<String> keepImages = keepArr == null ? new ArrayList<>() : new ArrayList<>(Arrays.asList(keepArr));

			String uploadPath = (String) request.getServletContext().getAttribute("uploadPath");
			String realPath = request.getServletContext().getRealPath(uploadPath);
			List<Part> files = new ArrayList<>();
			for (Part p : request.getParts()) {
				if ("photos".equals(p.getName()) && p.getSize() > 0) {
					files.add(p);
				}
			}
			if (keepImages.size() + files.size() > 5) {
				request.setAttribute("error", "사진은 최대 5장까지 올릴 수 있어요.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}

			// 서비스에서: 새 파일 저장 → keepImages + 새 파일명을 image1~5에 순서대로 채우고(남는 칸 null) update 실행
			int updated = teamMatchService.modifyTeamMatch(teamMatch, keepImages, realPath, files);
			if (updated == 0) {
				request.setAttribute("error", "수정할 수 없는 경기예요.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}

			response.sendRedirect(request.getContextPath() + "/team-match/detail/view?teamMatchId=" + teamMatchId);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 경기 수정중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

}
