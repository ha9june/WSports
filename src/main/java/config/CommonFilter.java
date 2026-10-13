package config;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserRatingDao;
import dao.UserRatingDaoImpl;
import dto.User;

//모든 URL 패턴(/*)에 필터 적용
@WebFilter(
		urlPatterns = "/*",
		initParams = {
				@WebInitParam(name="uploadPath", value="/uploads"),
				@WebInitParam(name="profilePath", value="/profiles")
		}
)

public class CommonFilter implements Filter {
	
	private final UserRatingDao ratingDao = new UserRatingDaoImpl();
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		//1. FilterConfig에서 필터 전용 파라미터 꺼내기
		String uploadPath = filterConfig.getInitParameter("uploadPath");
		String profilePath = filterConfig.getInitParameter("profilePath");
		
		//2. ServletContext에 전역 속성(Attribute)으로 저장
		ServletContext context = filterConfig.getServletContext();
		context.setAttribute("uploadPath", uploadPath);
		context.setAttribute("profilePath", profilePath);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");	
		
		// ===== 사이드바 평점 =====
		if ("GET".equalsIgnoreCase(req.getMethod())) {
		    String path = req.getRequestURI().substring(req.getContextPath().length());
		    boolean sidebarPage = path.startsWith("/mypage/")
		            || path.startsWith("/member/")
		            || path.startsWith("/settlement/")
		            || path.startsWith("/payment/")
		            || path.startsWith("/support/");

		    if (sidebarPage) {
		        HttpSession session = req.getSession(false);
		        Object user = (session == null) ? null : session.getAttribute("user");
		        if (user != null) {
		            try {
		            	long userId = ((User) user).getUserId();   // 교체: 실제 DTO/getter
		            	req.setAttribute("myRatingSummary", ratingDao.selectRatingSummaryByUserId(userId));
		            } catch (Exception e) {
		                e.printStackTrace();   // 실패해도 페이지는 뜸
		            }
		        }
		    }
		}
		
		chain.doFilter(req, res);

		
	}

}
