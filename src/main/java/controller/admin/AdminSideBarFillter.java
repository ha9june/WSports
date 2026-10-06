package controller.admin;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;

import service.admin.AdminSideBarService;
import service.admin.AdminSideBarServiceImpl;

/**
 * Servlet Filter implementation class AdminFillter
 */
@WebFilter("/admin/*")
public class AdminSideBarFillter implements Filter {
	private AdminSideBarService service = new AdminSideBarServiceImpl();
    /**
     * @see HttpFilter#HttpFilter()
     */
    public AdminSideBarFillter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		// 화면을 그리는 GET 요청일 때만 조회 (POST 저장 등에서는 생략)
		if("GET".equals(request.getMethod())){
			try {
				request.setAttribute("adminStats", service.getAdminStats());
				System.out.println("필터 : " + request.getAttribute("adminStats"));
			} catch (Exception e) {
				e.printStackTrace(); // 통계 조회가 실패해도 페이지는 열리게
			}
		}
		chain.doFilter(req, res); // 원래 서블릿으로 진행s
	}

}
