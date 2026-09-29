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

//모든 URL 패턴(/*)에 필터 적용
@WebFilter(
		urlPatterns = "/*",
		initParams = {
				@WebInitParam(name="uploadPath", value="/uploads"),
				@WebInitParam(name="profilePath", value="/profiles")
		}
)
public class CommonFilter implements Filter {
	
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
		
		chain.doFilter(req, res);

	}

}
