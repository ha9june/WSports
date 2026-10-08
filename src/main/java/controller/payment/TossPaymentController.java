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

import dto.User;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
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
		String state = request.getParameter("state");
		if(state == null || state.isEmpty()) state = "match";
		boolean isTeam = state.startsWith("teamMatch");
		
		String matchIdParam = request.getParameter("matchId");
		if(matchIdParam == null || matchIdParam.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/jsp/match/personalMatchList.jsp");
			return;
		}
		Long matchId = Long.parseLong(matchIdParam);

		try {
			// 로그인 확인
			User loginUser = (User) request.getSession().getAttribute("user");
			if (loginUser == null) {
				response.sendRedirect(request.getContextPath() + "/jsp/match/personalMatchList.jsp");
				return;
			}
						
			PaymentService paymentService = new PaymentServiceImpl();
			// 중복 참가 확인
			if (paymentService.isAlreadyJoined(loginUser.getUserId(), matchId, isTeam)) {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().write("<script>alert('이미 참가한 경기입니다.'); history.back();</script>");
				return;
			}

			Object match;
			Integer totalAmount;
			
			if(isTeam) {
				//팀 경기 상세 조회 서비스
				match = null;totalAmount = paymentService.getTeamMatchTotalAmount(matchId.intValue());
				totalAmount = paymentService.getTeamMatchTotalAmount(matchId.intValue());
			} else {
				PersonalMatchService personalMatchService = new PersonalMatchServiceImpl();
				match = personalMatchService.getPersmalMatchDetail(matchId);
				totalAmount = paymentService.getPersonalMatchTotalAmount(matchId.intValue());
			}

			if(totalAmount ==null || match == null) {
				response.sendRedirect(request.getContextPath()+"/jsp/match/personalMatchList.jsp");
				return;
			}
			request.setAttribute("match", match);
			request.setAttribute("totalAmount", totalAmount);
			request.getRequestDispatcher("/jsp/payment/toss_checkout.jsp").forward(request, response);
		
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath()+"/jsp/match/personalMatchList.jsp");
		}
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

		String matchType = requestJson.optString("matchType", "personal");
		int matchId = requestJson.optInt("matchId", 0);
		
		// 로그인 회원 확인 (토스 승인 전에 체크)
		User loginUser = (User) request.getSession().getAttribute("user");
		Long userId = (loginUser != null) ? loginUser.getUserId() : null;
		if (userId == null) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.getWriter().write("{\"message\":\"로그인이 필요합니다.\"}");
			return;
		}

		PaymentService paymentService = new PaymentServiceImpl();
		
		// 중복 참가 확인 (토스 승인 전에 차단)
		try {
			if (paymentService.isAlreadyJoined(userId, (long) matchId, "team".equals(matchType))) {
				response.setStatus(HttpServletResponse.SC_CONFLICT);
				response.getWriter().write("{\"code\":\"ALREADY_JOINED\",\"message\":\"이미 참가한 경기입니다.\"}");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("{\"message\":\"참가 여부 확인 중 오류가 발생했습니다.\"}");
			return;
		}
		// [필수 검증 로직]
		// DB에서 orderId로 주문을 조회하여, 저장된 결제 예정 금액과 넘어온 amount가 일치하는지 확인
		// [필수 검증] 경기 테이블의 참가비+수수료와 넘어온 amount 비교
		try {
			Integer expected = "team".equals(matchType)
					? paymentService.getTeamMatchTotalAmount(matchId)
					: paymentService.getPersonalMatchTotalAmount(matchId);

			if (expected == null || expected != amount) {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				response.getWriter().write("{\"message\":\"결제 금액이 일치하지 않습니다.\"}");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("{\"message\":\"금액 검증 중 오류가 발생했습니다.\"}");
			return;
		}

		// 2. 토스페이먼츠 인증 헤더 생성 (Basic Authorization)
		// 시크릿 키 뒤에 ':'를 붙인 후 Base64 인코딩
		String authHeader = "Basic "
				+ Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));
		
		// 토스에는 필요한 세 값 전송
		JSONObject confirmJson = new JSONObject();
		confirmJson.put("paymentKey", paymentKey);
		confirmJson.put("orderId", orderId);
		confirmJson.put("amount", amount);

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
				byte[] input = confirmJson.toString().getBytes(StandardCharsets.UTF_8);
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
				if ("team".equals(matchType)) {
					paymentService.completeTeamPayment(responseStr.toString(), userId, (long)matchId);// DB 상태 변경 트랜잭션 실행
				} else {
					paymentService.completePersonalPayment(responseStr.toString(), userId, (long) matchId);// DB 상태 변경 트랜잭션 실행
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
