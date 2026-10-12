package controller.payment;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PersonalMatch;
import dto.PersonalPayment;
import dto.User;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;

/**
 * Servlet implementation class info
 */
@WebServlet("/info")
public class PaymentDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    //결제 내역 상세 조회
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentDetailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String paymentKey = request.getParameter("paymentKey");
        
		try {
			PaymentService paymentService = new PaymentServiceImpl();
			//paymentKey로 개인 결제를 먼저 찾고, 없으면 팀 결제
			PersonalPayment personalPayment = paymentService.getPersonalPaymentByPaymentKey(paymentKey);
			boolean isTeam = (personalPayment == null);
			boolean canRefund = false;
			Object payment;
			
			if (isTeam) {
				payment = paymentService.getTeamPaymentByPaymentKey(paymentKey);
				request.setAttribute("match", paymentService.getTeamPaymentMatch(paymentKey));
			} else {
				PersonalMatch personalMatch = paymentService.getPersonalPaymentMatch(paymentKey);
				payment = personalPayment;
				request.setAttribute("match", personalMatch);

				// 환불 가능 여부 : 본인 로그인 + 환불 전 + 모집자 아님 + 모집 마감 전
				User loginUser = (User) request.getSession().getAttribute("user");
				canRefund = loginUser != null && personalMatch != null
						&& !"CANCELED".equals(personalPayment.getPaymentStatus())
						&& !loginUser.getUserId().equals(personalMatch.getUserId())
						&& personalMatch.getDeadline() != null
						&& LocalDateTime.now().isBefore(personalMatch.getDeadline());
			}
			request.setAttribute("payment", payment);
			request.setAttribute("isTeam", isTeam);
			request.setAttribute("canRefund", canRefund);

			request.getRequestDispatcher("/jsp/payment/paymentDetail.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "결제 내역 조회 오류");
			request.getRequestDispatcher("/jsp/payment/paymentDetail.jsp").forward(request, response);
		}
	}
}
