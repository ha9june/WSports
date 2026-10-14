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
@WebServlet("/match/participant/update")
public class MatchParticipantStatusUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchParticipantStatusUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = CheckUtil.getLoginUser(request);
		if (user == null) {
		    response.sendRedirect(request.getContextPath() + "/auth/login");
		    return;
		}
	    
	    
		Long personalMatchId = Long.parseLong(request.getParameter("personalMatchId"));
		String updateType = request.getParameter("updateType");
		
		PersonalMatchParticipant pmp = new PersonalMatchParticipant();
		pmp.setUserId(user.getUserId());
		pmp.setPersonalMatchId(personalMatchId);
		if(updateType.equals("participant")) {
			pmp.setAttendance(true);
			pmp.setStatus("결제완료");
		}else if(updateType.equals("participantCancel")) {
			pmp.setAttendance(false);
			pmp.setStatus("취소");
		}

		
		PersonalMatchParticipantService pmpService = new PersonalMatchParticipantServiceImpl();

		try {
			HashMap<String, Object> param = new HashMap<>();
			param.put("userId",user.getUserId());
			param.put("personalMatchId",personalMatchId);
			//먼저 조회
			PersonalMatchParticipant participant = pmpService.getParticipant(param);
			Boolean applied = false;
			//
			if(participant==null) {
				if(updateType.equals("participant")) {
					pmpService.addPersonalMatchParticipant(pmp);
					AlertUtil.redirect(response, "참가가 완료되었습니다.", request.getContextPath() + "/match/detail/view?personalMatchId="+personalMatchId);
					return;
				}
			}else {
				if(updateType.equals("participant")) {
					pmpService.updateParticipantCancel(pmp);
					AlertUtil.redirect(response, "참가가 완료되었습니다.", request.getContextPath() + "/match/detail/view?personalMatchId="+personalMatchId);

				}else if(updateType.equals("participantCancel")) {
					pmpService.updateParticipantCancel(pmp);
					AlertUtil.redirect(response, "참가가 취소되었습니다.", request.getContextPath() + "/match/detail/view?personalMatchId="+personalMatchId);

				}
			}
			

		} catch (Exception e) {
			e.printStackTrace();
			AlertUtil.back(response,"참가/취소에 실패하였습니다. 관리자에게 문의해 주세요");
			return;		
		}
		


		
	
	}



}
