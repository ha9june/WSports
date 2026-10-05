package controller.member;

import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dto.User;
import service.member.MemberService;
import service.member.MemberServiceImpl;

/**
 * Servlet implementation class MemberProfileEdit
 */
@WebServlet("/member/profile/edit")
@MultipartConfig(
		maxFileSize = 1024*1024*10, // 개별 파일 최대 크기(10MB)
		maxRequestSize = 1024*1024*10*5, // 전체 요청 최대 크기(50MB)
		fileSizeThreshold = 1024*1024*1 // 1MB 초과시 임시 디스크 경로 사용
)
public class MemberProfileEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberProfileEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user = (User)request.getSession().getAttribute("user");
			request.setAttribute("loginUser", user);
			request.getRequestDispatcher("/jsp/mypage/myPageUpdateProfile.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User loginUser = (User)request.getSession().getAttribute("user");
		
		User user = new User();
		
		Part profileImage = request.getPart("profileImg");
		String uploadPath = (String)request.getServletContext().getAttribute("profilePath");
		String realPath = request.getServletContext().getRealPath(uploadPath);
		
		boolean deleteImg = "true".equals(request.getParameter("deleteImg"));
		
		user.setLoginId(loginUser.getLoginId());
		String preferredRegion1 = request.getParameter("preferredRegion1");
		String preferredRegion2 = request.getParameter("preferredRegion2");
		String preferredRegion3 = request.getParameter("preferredRegion3");
		String preferredSport1 = request.getParameter("preferredSport1");
		String preferredSport2 = request.getParameter("preferredSport2");
		String preferredSport3 = request.getParameter("preferredSport3");
		String soccerSkill = request.getParameter("soccerSkill");
		String basketballSkill = request.getParameter("basketballSkill");
		String tennisSkill = request.getParameter("tennisSkill");
		String badmintonSkill = request.getParameter("badmintonSkill");
		String bio = request.getParameter("intro");

		if (preferredRegion1 != null && !preferredRegion1.isEmpty()) {
		    user.setPreferredRegion1(preferredRegion1);
		}
		if (preferredRegion2 != null && !preferredRegion2.isEmpty()) {
		    user.setPreferredRegion2(preferredRegion2);
		}
		if (preferredRegion3 != null && !preferredRegion3.isEmpty()) {
		    user.setPreferredRegion3(preferredRegion3);
		}
		if (preferredSport1 != null && !preferredSport1.isEmpty()) {
		    user.setPreferredSport1(preferredSport1);
		}
		if (preferredSport2 != null && !preferredSport2.isEmpty()) {
		    user.setPreferredSport2(preferredSport2);
		}
		if (preferredSport3 != null && !preferredSport3.isEmpty()) {
		    user.setPreferredSport3(preferredSport3);
		}
		if (soccerSkill != null && !soccerSkill.isEmpty()) {
		    user.setSoccerSkill(soccerSkill);
		}
		if (basketballSkill != null && !basketballSkill.isEmpty()) {
		    user.setBasketballSkill(basketballSkill);
		}
		if (tennisSkill != null && !tennisSkill.isEmpty()) {
		    user.setTennisSkill(tennisSkill);
		}
		if (badmintonSkill != null && !badmintonSkill.isEmpty()) {
		    user.setBadmintonSkill(badmintonSkill);
		}
		if (bio != null && !bio.isEmpty()) {
		    user.setBio(bio);
		}
		
		MemberService service = new MemberServiceImpl();
		try {
			User updateUser = service.profileEdit(user, realPath, profileImage, deleteImg);
			request.getSession().setAttribute("user", updateUser);
			response.sendRedirect(request.getContextPath()+"/member/profile/view");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}