package controller.payment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PaymentFailController
 */
@WebServlet("/payment/fail")
public class PaymentFailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentFailController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//토스가 붙여 보내는 값
		String code = request.getParameter("code");
		String message = request.getParameter("message");
		
		String title;
		String desc;
		if ("PAY_PROCESS_CANCELED".equals(code) || "USER_CANCEL".equals(code)) {
			title = "결제를 취소했어요";
			desc = "참가하려면 다시 결제해 주세요.";
		} else {
			title = "결제에 실패했어요";
			desc = (message != null && !message.isBlank()) ? message : "잠시 후 다시 시도해 주세요.";
		}
		request.setAttribute("failTitle", title);
		request.setAttribute("failDesc", desc);
		request.getRequestDispatcher("/jsp/payment/toss_fail.jsp").forward(request, response);
		
	}

}
