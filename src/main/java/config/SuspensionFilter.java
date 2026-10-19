package config;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.member.MemberService;
import service.member.MemberServiceImpl;
import util.AlertUtil;
import util.CheckUtil;

// 정지 회원이 막힌 기능에 접근하면 안내 모달을 띄우고 이전 화면으로 돌려보냄
@WebFilter("/*")
public class SuspensionFilter implements Filter {

	// 정지 회원이 쓸 수 없는 기능
	private static final Set<String> BLOCKED = new HashSet<>(Arrays.asList(
		"/match/write/form", "/match/edit/form",
		"/payment/confirm",
		"/team/create", "/team/application",
		"/team-match/create", "/team-match/create/check", "/team-match/edit",
		"/review/create", "/review/edit", "/review/comment",
		"/support/report/create"
	));

	private final MemberService memberService = new MemberServiceImpl();

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		String path = req.getRequestURI().substring(req.getContextPath().length());
		User user = CheckUtil.getLoginUser(req);

		// 막는 주소가 아니거나, 비로그인이거나, 관리자면 통과
		if (!BLOCKED.contains(path) || user == null || "Admin".equals(user.getGrade())) {
			chain.doFilter(request, response);
			return;
		}

		String msg;
		try {
			msg = memberService.getSuspensionMessage(user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
			chain.doFilter(request, response);   // 조회 실패 시 막지 않음
			return;
		}
		if (msg == null) {                        // 정지 아님
			chain.doFilter(request, response);
			return;
		}

		boolean ajax = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"))
				|| String.valueOf(req.getHeader("Accept")).contains("application/json");
		if (ajax) {
			// AJAX: 403 + 문구 (화면 스크립트가 showSuspendNotice 로 띄움)
			res.setStatus(HttpServletResponse.SC_FORBIDDEN);
			res.setContentType("text/plain; charset=UTF-8");
			res.getWriter().write(msg);
		} else {
			// 일반 요청: 안내 모달 + 이전 화면으로
			AlertUtil.notice(req, res, msg);
		}
	}
}