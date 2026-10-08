package controller.match;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.PersonalMatch;
import dto.User;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import util.AlertUtil;

/**
 * Servlet implementation class MatchEditForm
 */
@WebServlet("/match/edit/form")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크키(10MB)
	maxRequestSize = 1024 * 1024 * 10 * 5, // 전체 요청 최대 크키(50MB)
	fileSizeThreshold = 1024 * 1024 * 1 // 1MB 초과시 임시 디스크 경로 사용
)
public class MatchEditForm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchEditForm() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Long psersonalMatchId = Long.parseLong(request.getParameter("personalMatchId"));
		
		PersonalMatchService service = new PersonalMatchServiceImpl();
		try {
			
			PersonalMatch pMatch = service.getPersmalMatchDetail(psersonalMatchId);
			System.out.println(pMatch);
			request.setAttribute("personalMatch", pMatch);
			request.getRequestDispatcher("/jsp/match/personalMatchEdit.jsp").forward(request, response);;			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
	    if (user == null) {
	        response.sendRedirect(request.getContextPath() + "/auth/login");
	        return;
	    }
    	PersonalMatchService service = new PersonalMatchServiceImpl();

	    
	    String uploadPath = (String) request.getServletContext().getAttribute("uploadPath");
	    String realPath = request.getServletContext().getRealPath(uploadPath);
	    
	    Long personalMatchId;
	    try {
			personalMatchId = Long.parseLong(request.getParameter("personalMatchId"));
		} catch (NumberFormatException e) {
			AlertUtil.back(response, "잘못된 요청입니다.");
			return;
		}
	    
	    PersonalMatch origin = null;
		try {
			origin = service.getPersmalMatchDetail(personalMatchId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (origin == null) {
			AlertUtil.back(response, "존재하지 않는 경기입니다.");
			return;
		}
		if (user.getUserId() != origin.getUserId()) { // TODO: 필드명/타입(int, String) 맞추기
			AlertUtil.back(response, "수정 권한이 없습니다.");
			return;
		}
		
		
		PersonalMatch pm = new PersonalMatch();
		try {
            String sport = request.getParameter("sport");
            String title = request.getParameter("title");
            String address = request.getParameter("address");
            String addressDetail = request.getParameter("addressDetail");
            String gender = request.getParameter("gender");
            String content = request.getParameter("content");
            
            LocalDate matchDate = LocalDate.parse(request.getParameter("matchDate"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            LocalDateTime deadline = LocalDateTime.parse(request.getParameter("deadline"));
			
            BigDecimal lat = toDecimal(request.getParameter("lat"));
            BigDecimal lng = toDecimal(request.getParameter("lng"));
            
            String participationFeeStr = request.getParameter("fee");
            int participationFee = (participationFeeStr == null || participationFeeStr.replaceAll("[^0-9]", "").isEmpty())
                    ? 0 : Integer.parseInt(participationFeeStr.replaceAll("[^0-9]", ""));

            int minPeople = Integer.parseInt(request.getParameter("minPeople"));
            int maxPeople = Integer.parseInt(request.getParameter("maxPeople"));
            
            String ages = request.getParameter("ages");
            String levels = request.getParameter("levels");
            
            String[] addressArr = address.split(" ");
            String region = addressArr[0]+"시 "+addressArr[1];
            
            
            pm.setPersonalMatchId(personalMatchId);
            pm.setSport(sport);
            pm.setTitle(title);
            pm.setAddress(address);
            pm.setRegion(region);
            pm.setPlaceName(addressDetail);
            pm.setGender(gender);
            pm.setContent(content);
            
            pm.setMatchDate(matchDate);
            pm.setStartTime(startTime);
            pm.setEndTime(endTime);
            pm.setDeadline(deadline);
            
            pm.setLatitude(lat);
            pm.setLongitude(lng);
            
            pm.setParticipationFee(participationFee);
            pm.setFee(participationFee/10);
            pm.setMinPeople(minPeople);
            pm.setMaxPeople(maxPeople);
            
            pm.setAge20s(ages.contains("20대"));
            pm.setAge30s(ages.contains("30대"));
            pm.setAge40s(ages.contains("40대"));
            pm.setAge50s(ages.contains("50대"));
            pm.setAge60Plus(ages.contains("60대"));
            
            pm.setSkillIntro(levels.contains("입문"));
            pm.setSkillBeginner(levels.contains("초급"));
            pm.setSkillIntermediate(levels.contains("중급"));
            pm.setSkillAdvanced(levels.contains("상급"));
            
            pm.setDeleted(false);
            pm.setStatus("모집중");
            
            System.out.println(pm);
            

		} catch (Exception e) {
			AlertUtil.back(response,"입력값 형식이 올바르지 않습니다.");
			return;
		}
		
	    Collection<Part> parts = request.getParts();
	    for (Part part : parts) {

	    	if (!"keepImage".equals(part.getName())
	    	        && !"photos".equals(part.getName())) {
	    	    continue;
	    	}

	        System.out.println(part.getSubmittedFileName());
	        System.out.println(part.getName());
	    }
	    System.out.println("----------");
	    try {
            Long psersonalMatchId = service.updatePersonalMatch(pm,parts,realPath);
            System.out.println(psersonalMatchId);
            response.sendRedirect(request.getContextPath() + "/match/detail/view?psersonalMatchId=" + psersonalMatchId);
		} catch (Exception e) {
			e.printStackTrace();
			AlertUtil.back(response,"수정에 실패하였습니다. 관리자에게 문의하여 주세요.");
			return;
		}

	}
	private BigDecimal toDecimal(String s) {
        return (s == null || s.isBlank()) ? null : new BigDecimal(s.trim());
    }
}
