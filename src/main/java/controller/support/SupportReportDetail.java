package controller.support;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.support.ReportService;
import service.support.ReportServiceImpl;

/**
 * Servlet implementation class SupportReportDetail
 */
@WebServlet("/support/report/detail")
public class SupportReportDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportReportDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User)request.getSession().getAttribute("user");
		
		Long reportId = Long.parseLong(request.getParameter("reportId"));
		ReportService service = new ReportServiceImpl();
		try {
			request.setAttribute("report", service.detailReport(reportId));
			request.getRequestDispatcher("/jsp/support/reportDetail.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
