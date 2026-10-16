package controller.mypage;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.User;

@WebServlet("/mypage/penalty")
public class MyPagePanalty extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MyPagePanalty() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User user = (session == null) ? null : (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		Map<String, Object> param = new HashMap<>();
		param.put("userId", user.getUserId()); // 호출 전에 넣어야 함

		try (SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			List<Map<String, Object>> list = s.selectList("mapper.userpenalty.selectMyPenaltyList", param);

			int total = 0;
			boolean permanent = false;
			boolean suspended = false;
			String suspendEnd = null;
			LocalDateTime now = LocalDateTime.now();
			Integer latestScore = null;

			// 1) 행마다 부호 문자열과 색 클래스 만들기
			for (Map<String, Object> row : list) {
				int score = Integer.parseInt(String.valueOf(row.get("score")));
				row.put("scoreText", scoreText(score)); // "+19", "-1", "0"
				row.put("scoreClass", scoreClass(score)); // "plus", "minus", ""
			}

			int prev = 0;
			for (int i = list.size() - 1; i >= 0; i--) {
			    Map<String, Object> row = list.get(i);
			    int score = Integer.parseInt(String.valueOf(row.get("score")));
			    int diff = score - prev;                       // 20 → 19 이면 -1
			    row.put("scoreText", scoreText(diff));
			    row.put("scoreClass", scoreClass(diff));
			    if (Integer.parseInt(String.valueOf(row.get("cancelled"))) != 1)
			        prev = score;                              // 취소된 행은 기준에서 제외
			}

			// 3) 최근 받은 점수, 정지 여부 (최신순 그대로)
			for (Map<String, Object> row : list) {
				if (Integer.parseInt(String.valueOf(row.get("cancelled"))) == 1)
					continue;

				if (latestScore == null) {
					latestScore = Integer.parseInt(String.valueOf(row.get("score")));
					request.setAttribute("latestScoreText", scoreText(latestScore));
					request.setAttribute("latestScoreClass", scoreClass(latestScore));
				}

				if (Integer.parseInt(String.valueOf(row.get("permanentSuspension"))) == 1)
					permanent = true;

				Object end = row.get("suspensionEnd");
				if (end != null) {
					LocalDateTime endAt = LocalDateTime.parse(end.toString().replace(' ', 'T'));
					if (endAt.isAfter(now) && (suspendEnd == null || end.toString().compareTo(suspendEnd) > 0)) {
						suspended = true;
						suspendEnd = end.toString();
					}
				}
			}
			request.setAttribute("totalPoint", latestScore == null ? 0 : latestScore);
			request.setAttribute("penaltyList", list);
			request.setAttribute("totalPoint", total);
			request.setAttribute("permanent", permanent);
			request.setAttribute("suspended", suspended);
			request.setAttribute("suspendEnd", suspendEnd);
			request.setAttribute("latestScore", latestScore);
		}
		request.getRequestDispatcher("/jsp/mypage/myPagePenalty.jsp").forward(request, response);
	}

	private static String scoreText(int score) {
		if (score > 0)
			return "+" + score;
		if (score < 0)
			return String.valueOf(score); // 음수는 이미 "-1" 형태
		return "0";
	}

	private static String scoreClass(int score) {
		if (score > 0)
			return "plus";
		if (score < 0)
			return "minus";
		return "";
	}
}