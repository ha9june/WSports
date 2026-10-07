package controller.match;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.PersonalMatchParticipant;
import dto.User;
import service.match.PersonalMatchParticipantService;
import service.match.PersonalMatchParticipantServiceImpl;
import util.AlertUtil;
import util.CheckUtil;

/**
 * Servlet implementation class PersonalMatchParticipation
 */
@WebServlet("/match/detail/participation")
public class MatchParticipantAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchParticipantAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = CheckUtil.getLoginUser(request);
		if (user == null) {
		    response.sendRedirect(request.getContextPath() + "/auth/login");
		    return;
		}
	    
	    
		Long personalMatchId = Long.parseLong(request.getParameter("personalMatchId"));
		

		
		PersonalMatchParticipant pmp = new PersonalMatchParticipant();
		pmp.setUserId(user.getUserId());
		pmp.setPersonalMatchId(personalMatchId);
		pmp.setAttendance(true);
		
		PersonalMatchParticipantService service = new PersonalMatchParticipantServiceImpl();
		
		
		try {
			HashMap<String, Object> searchParam = new HashMap<>();
			searchParam.put("userId",user.getUserId());
			searchParam.put("personalMatchId",personalMatchId);
			Boolean isParticipant = service.isPersonalMatchParticipant(searchParam);
			
			if(isParticipant) {
				AlertUtil.back(response,"이미 참가중인 경기입니다.");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			AlertUtil.back(response,"경기체크 에러");
			return;		
		}
		
		try {
			service.addPersonalMatchParticipant(pmp);
			AlertUtil.redirect(response, "참가가완료되었습니다..", request.getContextPath() + "/match/detail/view?num="+personalMatchId);
		} catch (Exception e) {
			e.printStackTrace();
			AlertUtil.back(response,"매치 참가에 실패하였습니다. 관리자에게 문의해 주세요");
			return;
		}

		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
	}

}
