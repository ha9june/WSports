package controller.payment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;

/**
 * Servlet implementation class PaymentCompleteController
 */
@WebServlet("/payment/complete")
public class PaymentCompleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentCompleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String paymentKey = request.getParameter("paymentKey");
		String matchIdParam = request.getParameter("matchId");
		boolean isTeam = "team".equals(request.getParameter("matchType"));
		
		if (paymentKey == null || matchIdParam == null) {
			response.sendRedirect(request.getContextPath() + "/jsp/match/personalMatchList.jsp");
			return;
		}
		
		try {
			PaymentService paymentService = new PaymentServiceImpl();
			Long matchId = Long.parseLong(matchIdParam);
			Object payment;
			Object match;
			
			if(isTeam) {
				payment = paymentService.getPersonalPaymentByPaymentKey(paymentKey);
				match = paymentService.getTeamPaymentByPaymentKey(paymentKey);
				
			} else {
				payment = paymentService.getPersonalPaymentByPaymentKey(paymentKey);
				PersonalMatchService personalMatchService = new PersonalMatchServiceImpl();
				match = personalMatchService.getPersmalMatchDetail(matchId);
			}
				request.setAttribute("payment", payment);
				request.setAttribute("match", match);
				request.setAttribute("isTeam", isTeam);
				request.getRequestDispatcher("/jsp/payment/orderComplete.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect(request.getContextPath() + "/jsp/match/personalMatch.jsp");
			}
	}
}
