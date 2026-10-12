package controller.payment;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;

/**
 * Servlet implementation class PaymentRefund
 */
@WebServlet("/payment/refund")
public class PaymentRefund extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// 토스페이먼츠 테스트 시크릿 키
    private static final String SECRET_KEY = loadSecretKey();
    /**
     * @see HttpServlet#HttpServlet()   
     */
    
    private static String loadSecretKey() {
    	try (InputStream is = TossPaymentController.class.getClassLoader()
    			.getResourceAsStream("resource/db.properties")) {   // mybatis-config.xml의 resource 경로와 같게
    		Properties props = new Properties();
    		props.load(is);
    		return props.getProperty("toss.secret.key");
    	} catch (Exception e) {
    		throw new RuntimeException("토스 시크릿 키를 불러오지 못했습니다.", e);
    	}
    }   
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
		String matchType = request.getParameter("matchType"); //팀인가 개인인가
		boolean isTeam = "team".equals(matchType);
		
		if(paymentKey == null || paymentKey.isEmpty()) {
			request.getSession().setAttribute("refundMsg","잘못된 요청입니다." );
			response.sendRedirect(request.getContextPath()+"/jsp/payment/paymentList.jsp");
			return;
		}
		if (cancelReason == null || cancelReason.isBlank()) {
			cancelReason = isTeam ? "팀 경기 환불 요청" : "참가자 환불 요청";
		}
		
		//환불 후 돌아갈 결제 상세 주소
		PaymentService service = new PaymentServiceImpl();
		try {
			if(isTeam) {
				service.refundTeamPayment(paymentKey, loginUser.getUserId(), cancelReason,  SECRET_KEY);
			}else {
				service.refundPersonalPayment(paymentKey, loginUser.getUserId(), cancelReason,  SECRET_KEY);
			}
			request.getSession().setAttribute("refundMsg", "환불이 완료되었습니다.");
		}catch (IllegalStateException e) {
			// 검증 실패 (본인 결제 아님, 모집 마감 이후, 상대 팀 있음 등)
			request.getSession().setAttribute("refundMsg", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("refundMsg", "환불 처리 중 오류가 발생했습니다.");
		}
		//결제 상세로 돌아가기
		response.sendRedirect(request.getContextPath()+"/info?paymentKey=" + paymentKey + "&matchType=" + (isTeam ? "team" : "personal"));
	}

}
