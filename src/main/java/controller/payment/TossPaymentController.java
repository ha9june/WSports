package controller.payment;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;

/**
 * Servlet implementation class PaymentHistoryList
 */
@WebServlet("/payment/confirm")
public class TossPaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// 토스페이먼츠 테스트 시크릿 키
    private static final String SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
    /**
     * @see HttpServlet#HttpServlet()   
     */
    public TossPaymentController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/toss_checkout.jsp").forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		// 1. 요청 본문(JSON) 읽기
		StringBuilder sb = new StringBuilder();
		try (BufferedReader reader = request.getReader()) {
			String line;
			while ((line = reader.readLine()) != null) {
				sb.append(line);
			}
		}

		JSONObject requestJson = new JSONObject(sb.toString());
		String paymentKey = requestJson.getString("paymentKey");
		String orderId = requestJson.getString("orderId");
		int amount = requestJson.getInt("amount");

		// [필수 검증 로직]
		// DB에서 orderId로 주문을 조회하여, 저장된 결제 예정 금액과 넘어온 amount가 일치하는지 확인
		// boolean isAmountValid = orderService.verifyAmount(orderId, amount);
		// if (!isAmountValid) { response.setStatus(400); return; }

		// 2. 토스페이먼츠 인증 헤더 생성 (Basic Authorization)
		// 시크릿 키 뒤에 ':'를 붙인 후 Base64 인코딩
		String authHeader = "Basic "
				+ Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));

		// 3. 토스 승인 API 통신
		HttpURLConnection conn = null;
		try {
			URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", authHeader);
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setDoOutput(true);

			// 요청 페이로드 전송
			try (OutputStream os = conn.getOutputStream()) {
				byte[] input = requestJson.toString().getBytes(StandardCharsets.UTF_8);
				os.write(input, 0, input.length);
			}

			// 4. 응답 확인
			int statusCode = conn.getResponseCode();
			InputStream is = (statusCode >= 200 && statusCode < 300) ? conn.getInputStream() : conn.getErrorStream();

			StringBuilder responseStr = new StringBuilder();
			try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
				String line;
				while ((line = br.readLine()) != null) {
					responseStr.append(line);
				}
			}

			System.out.println(responseStr);
			
			if (statusCode >= 200 && statusCode < 300) {
				// [결제 성공 처리]
				// JSONObject responseJson = new JSONObject(responseStr.toString());
				PaymentService paymentService = new PaymentServiceImpl();
				String matchType = requestJson.optString("matchType", "personal");
				
				if ("team".equals(matchType)) {
					paymentService.completeTeamPayment(responseStr.toString());// DB 상태 변경 트랜잭션 실행
				} else {
					paymentService.completePersonalPayment(responseStr.toString());// DB 상태 변경 트랜잭션 실행
				}
				response.setStatus(HttpServletResponse.SC_OK);
			} else {
				// 결제 승인 실패 (카드 한도 초과, 잔액 부족 등)
				response.setStatus(statusCode);
			}

			response.getWriter().write(responseStr.toString());

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("{\"message\":\"서버 내부 통신 오류가 발생했습니다.\"}");
		} finally {
			if (conn != null) {
				conn.disconnect();
			}
		}
	}
}
