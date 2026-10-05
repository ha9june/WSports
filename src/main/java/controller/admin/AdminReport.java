package controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PageInfo;
import service.admin.AdminReportService;
import service.admin.AdminReportServiceImpl;

/**
 * Servlet implementation class AdminReport
 */
@WebServlet("/admin/report")
public class AdminReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminReport() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminReportService service = new AdminReportServiceImpl();
		try {
			// 주소의 ?page= 값 받기 (없으면 1페이지)
			String pageParam = request.getParameter("page");
			Integer page = (pageParam == null || pageParam.isEmpty()) ? 1 : Integer.parseInt(pageParam);

			// 주소의 ?status= 값 받기 (없으면 전체)
			String status = request.getParameter("status");
			if (status == null || status.isEmpty()) status = "ALL";
			
			String keyword = request.getParameter("keyword");
			if (keyword == null) keyword = "";
			keyword = keyword.trim(); // 앞뒤 공백 제거
			
			PageInfo pageInfo = new PageInfo(page);
			List<Map<String, Object>> reportlist = service.getAdminReportList(pageInfo, status);
			System.out.println(reportlist+"서블렛");
			request.setAttribute("reportlist", reportlist); // 신고 목록
			
			request.setAttribute("pageInfo", pageInfo);     // 페이지 정보

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "정산관리 목록 조회 오류");
		}
		request.getRequestDispatcher("/jsp/admin/adminReport.jsp").forward(request, response);
	}

}
