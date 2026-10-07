package controller.match;

import java.io.IOException;
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

/**
 * Servlet implementation class MatchCreate
 */
@WebServlet("/match/create")
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크키(10MB)
	maxRequestSize = 1024 * 1024 * 10 * 5, // 전체 요청 최대 크키(50MB)
	fileSizeThreshold = 1024 * 1024 * 1 // 1MB 초과시 임시 디스크 경로 사용
)
public class MatchCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchCreate() {
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

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
	    if (user == null) {
	        response.sendRedirect(request.getContextPath() + "/auth/login");
	        return;
	    }
	    long userId = user.getUserId();
		String uploadPath = (String) request.getServletContext().getAttribute("uploadPath");
		String realPath = request.getServletContext().getRealPath(uploadPath);
	    
	    try {
			PersonalMatch pm = new PersonalMatch();

            String sport = request.getParameter("sport");
            String title = request.getParameter("title");
            String address = request.getParameter("address");
            String gender = request.getParameter("gender");
            String content = request.getParameter("content");

            LocalDate matchDate = LocalDate.parse(request.getParameter("matchDate"));
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            LocalDateTime deadline = LocalDateTime.parse(request.getParameter("deadline"));

            BigDecimal lat = toDecimal(request.getParameter("lat"));
            BigDecimal lng = toDecimal(request.getParameter("lng"));

            // 숫자: 참가비는 "10,000원" 같은 입력에서 숫자만 추출
            String participationFeeStr = request.getParameter("fee");
            int participationFee = (participationFeeStr == null || participationFeeStr.replaceAll("[^0-9]", "").isEmpty())
                    ? 0 : Integer.parseInt(participationFeeStr.replaceAll("[^0-9]", ""));

            int minPeople = Integer.parseInt(request.getParameter("minPeople"));
            int maxPeople = Integer.parseInt(request.getParameter("maxPeople"));

            // 복수 선택
            String ages = request.getParameter("ages");
            String levels = request.getParameter("levels");
            
            System.out.println(address);
            String[] addressArr = address.split(" ");
            String region = addressArr[0]+"시";
            String addr = region+" "+addressArr[1];
            
            
            
            pm.setUserId(userId);
            
            pm.setSport(sport);
            pm.setTitle(title);
            pm.setAddress(addr);
            pm.setRegion(region);
            pm.setAddress(addr);
            pm.setRegion(region);
            pm.setPlaceName(address);
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
            
            //create_at, update_at, deleted = false,status = 모집중
            
            Collection<Part> parts = request.getParts();


            
            PersonalMatchService service = new PersonalMatchServiceImpl();
            Long psersonalMatchId = service.createPersonalMatch(pm,parts,realPath);
            
            System.out.println(psersonalMatchId);

            response.sendRedirect(request.getContextPath() + "/match/detail/view?num=" + psersonalMatchId);
            //response.sendRedirect(request.getContextPath() + "/jsp/match/personalMatchList.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            //forwardError(request, response, "입력값 형식이 올바르지 않습니다.");
        }
		
		

		
	    
	    
		
	}
	
	private BigDecimal toDecimal(String s) {
        return (s == null || s.isBlank()) ? null : new BigDecimal(s.trim());
    }

}
