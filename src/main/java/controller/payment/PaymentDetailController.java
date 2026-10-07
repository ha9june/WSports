package controller.payment;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PersonalPayment;
import dto.TeamPayment;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;

/**
 * Servlet implementation class info
 */
@WebServlet("/info")
public class PaymentDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String paymentKey = request.getParameter("paymentKey");
        
		try {
			PaymentService paymentService = new PaymentServiceImpl();
			String matchType = request.getParameter("matchType");
			
			////////////////////////////////paymentKey 만으로 찾아야 하는 상황
			/*Object payment = paymentService.getPersonalPaymentByPaymentKey(paymentKey);
			boolean isTeam = false;
			if (payment == null) {
				payment = paymentService.getTeamPaymentByPaymentKey(paymentKey);
				isTeam = true;
			}*/ 
			//////////////////////////////
			Object payment;
			boolean isTeam = "team".equals(matchType);

	        // DB 조회
			if (isTeam) {
				payment = paymentService.getTeamPaymentByPaymentKey(paymentKey);
			} else {
				payment = paymentService.getPersonalPaymentByPaymentKey(paymentKey);
			}
			request.setAttribute("payment", payment);
			request.setAttribute("isTeam", isTeam);
	        
	        request.getRequestDispatcher("/paymentDetail.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "결제 내역 조회 오류");
			request.getRequestDispatcher("/paymentDetail.jsp").forward(request, response);
		}
	}
}
