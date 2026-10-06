package controller.support;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Report;
import dto.User;
import service.support.ReportService;
import service.support.ReportServiceImpl;

/**
 * Servlet implementation class SupportReportCreate
 */
@WebServlet("/support/report/create")
public class SupportReportCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportReportCreate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			User user = (User)request.getSession().getAttribute("user");
			request.setAttribute("loginUser", user);
			request.getRequestDispatcher("/jsp/support/reportWrite.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User)request.getSession().getAttribute("user");
		
		Report report = new Report();
		report.setUserId(user.getUserId());
		report.setType(request.getParameter("reportType"));
		report.setTitle(request.getParameter("title"));
		report.setContent(request.getParameter("content"));
		
		String postType = request.getParameter("targetType");
		String postId = request.getParameter("targetNo");
		
		if (postType != null && !postType.isEmpty()) {
			report.setPostType(postType);
		}
		if (postId != null && !postId.isEmpty()) {
		    report.setPostId(Long.parseLong(postId));
		}
		
		ReportService service = new ReportServiceImpl();
		try {
			service.write(report);
			response.sendRedirect(request.getContextPath()+"/jsp/support/reportList.jsp");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
