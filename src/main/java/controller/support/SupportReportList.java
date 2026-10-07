package controller.support;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.support.ReportService;
import service.support.ReportServiceImpl;
import util.PageInfo;

/**
 * Servlet implementation class SupportReportList
 */
@WebServlet("/support/report/list")
public class SupportReportList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportReportList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		Long userId = user.getUserId();
		
		String status = request.getParameter("status");
		if (status == null || status.isEmpty()) status = "ALL";
		
		String sPage = request.getParameter("page");
		Integer page = 1;
		if(sPage!=null && !sPage.isEmpty()) {
			page = Integer.parseInt(sPage);
		}
		
		PageInfo pageInfo = new PageInfo(page);
		ReportService service = new ReportServiceImpl();
		try {
			List<Map<String,Object>> reportList = service.reportList(pageInfo, userId, status);
			request.setAttribute("reportList", reportList);
			request.setAttribute("pageInfo", pageInfo);
			request.getRequestDispatcher("/jsp/support/reportList.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
