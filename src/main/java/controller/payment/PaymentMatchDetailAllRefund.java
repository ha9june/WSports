package controller.payment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.User;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import util.TossKey;

/**
 * Servlet implementation class PaymentMatchDetailAllRefund
 */
@WebServlet("/payment/match/detail/allrefund")
public class PaymentMatchDetailAllRefund extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentMatchDetailAllRefund() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

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
	    
	    
	    String matchType = request.getParameter("matchType");//Personal,Team
	    String matchTitle = request.getParameter("matchTitle");
	    Long matchId = Long.parseLong(request.getParameter("matchId"));
	    
	    Boolean isAdmin = ("Admin").equals(user.getGrade());

	    
	    // 현재는 개인경기만 모든유저에게 횐불
//	    if(!("Personal").equals(matchType)) {
//	    	request.setAttribute("error", "개인 경기가 아닙니다.");
//			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
//			return;
//	    }
	    
		PaymentService psService = new PaymentServiceImpl();
		
		try {
			boolean allRefunded = false; 
			
			if("Personal".equals(matchType)) {
				allRefunded = psService.allRefundPersonalMatch(
						matchId, matchTitle, TossKey.SECRET_KEY);
			}else if("Team".equals(matchType)) {
				allRefunded = psService.allRefundTeamMatch(matchId, matchTitle, TossKey.SECRET_KEY);
			}
			
			
			if (!allRefunded) {
				request.setAttribute("error", "모두 환불 실패. 관리자에게 문의하여 주세요");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			
			PersonalMatchService pmService = new PersonalMatchServiceImpl();
			TeamMatchService tmService = new TeamMatchServiceImpl();
			if("Personal".equals(matchType)) {
				if(isAdmin) {
					pmService.updateStatusDeleteOfAdmin(matchId);
				}else {
					pmService.updateStatusCancelOfHost(matchId);
				}
				request.getSession().setAttribute("toast", "'"+matchTitle+"' 글을 삭제했습니다.");
	            response.sendRedirect(request.getContextPath() + "/match/list");
	            
			}else if("Team".equals(matchType)) {
				tmService.modifyTeamMatchToDeleted(matchId);
				request.getSession().setAttribute("toast", "'"+matchTitle+"' 글을 삭제했습니다.");
				response.sendRedirect(request.getContextPath() + "/team-match/list");
			}
			

	
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "환불실패쓰");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
			return;
			
		}


	    
	}

}
