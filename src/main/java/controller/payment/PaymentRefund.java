package controller.payment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;
import util.TossKey;

/**
 * Servlet implementation class PaymentRefund
 */
@WebServlet("/payment/refund")
public class PaymentRefund extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()   
     */
    
    public PaymentRefund() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 확인
		User loginUser = (User)request.getSession().getAttribute("user");
		if (loginUser == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}
		
		String paymentKey = request.getParameter("paymentKey");
		String cancelReason = request.getParameter("cancelReason");
		if (cancelReason == null || cancelReason.isBlank()) {
			cancelReason = "참가자 환불 요청";
		}
		
		if(paymentKey == null || paymentKey.isEmpty()) {
			request.getSession().setAttribute("refundMsg","잘못된 요청입니다." );
			response.sendRedirect(request.getContextPath()+"/jsp/payment/paymentList.jsp");
			return;
		}
		
		//개인 경기 환불 (팀 경기는 스케줄러가 자동 환불)
		PaymentService service = new PaymentServiceImpl();
		boolean isTeam = false;
		try {
			//개인 결제에 없으면 팀 결제
			isTeam = (service.getPersonalPaymentByPaymentKey(paymentKey) == null);
			
			if(isTeam) {
				service.refundTeamPayment(paymentKey, loginUser.getUserId(), cancelReason, TossKey.SECRET_KEY);
				request.getSession().setAttribute("refundMsg", "환불이 완료되었습니다.");
			}else {
				service.refundPersonalPayment(paymentKey, loginUser.getUserId(), cancelReason, TossKey.SECRET_KEY);
				request.getSession().setAttribute("refundMsg", "환불이 완료되었습니다.");
			}
			
		}catch (IllegalStateException e) {
			// 검증 실패 (본인 결제 아님, 모집 마감 이후 등)
			request.getSession().setAttribute("refundMsg", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("refundMsg", "환불 처리 중 오류가 발생했습니다.");
		}
		//결제 상세로 돌아가기
		response.sendRedirect(request.getContextPath()+"/info?paymentKey=" + paymentKey + "&matchType="+(isTeam ? "team" : "personal"));
	}

}
