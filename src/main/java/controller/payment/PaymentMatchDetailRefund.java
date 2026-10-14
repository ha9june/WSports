package controller.payment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.User;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;

/**
 * Servlet implementation class PaymentMatchDetailRefund
 */
@WebServlet("/payment/match/detail/refund")
public class PaymentMatchDetailRefund extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentMatchDetailRefund() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
	    if (user == null) {
	        response.sendRedirect(request.getContextPath() + "/auth/login");
	        return;
	    }
	    
	    Long userId = user.getUserId();
	    String matchType = request.getParameter("matchType");//Personal,Team
		Long matchId = Long.parseLong(request.getParameter("matchId"));
		String cancelReason = request.getParameter("cancelReason");
		
		
		
		PaymentService psService = new PaymentServiceImpl();
		
		try {
			String paymentKey = psService.getPaymentKey(userId, matchId, matchType);
			
			if(paymentKey == null) {
				request.setAttribute("error", "취소에 실패하였습니다.");
				request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
				return;
			}
			
		
			request.setAttribute("matchType", matchType);
			request.setAttribute("matchId", matchId);
			request.setAttribute("cancelReason", cancelReason);
			request.setAttribute("paymentKey", paymentKey);
			request.setAttribute("requestType", "setAttribute");
			
			System.out.println(paymentKey);

			
			request.getRequestDispatcher("/payment/refund").forward(request, response);


			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.setAttribute("error", "취소에 실패하였습니다.");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
			return;
		}


	}



}
