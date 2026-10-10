package controller.support;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.support.InquiryService;
import service.support.InquiryServiceImpl;

/**
 * Servlet implementation class SupportInquiryDetail
 */
@WebServlet("/support/inquiry/detail")
public class SupportInquiryDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportInquiryDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User)request.getSession().getAttribute("user");
		
		Long inquiryId = Long.parseLong(request.getParameter("inquiryId"));
		InquiryService service = new InquiryServiceImpl();
		try {
			request.setAttribute("inquiry", service.detailInquiry(inquiryId));
			request.getRequestDispatcher("/jsp/support/inquiryDetail.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
