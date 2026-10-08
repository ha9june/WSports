package controller.support;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Inquiry;
import dto.User;
import service.support.InquiryService;
import service.support.InquiryServiceImpl;

/**
 * Servlet implementation class SupportInquiryCreate
 */
@WebServlet("/support/inquiry/create")
public class SupportInquiryCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportInquiryCreate() {
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
			request.getRequestDispatcher("/jsp/support/inquiryWrite.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User)request.getSession().getAttribute("user");
		
		Inquiry inquiry = new Inquiry();
		inquiry.setUserId(user.getUserId());
		inquiry.setType(request.getParameter("inquiryType"));
		inquiry.setTitle(request.getParameter("title"));
		inquiry.setContent(request.getParameter("content"));
		
		InquiryService service = new InquiryServiceImpl();
		try {
			service.writeInquiry(inquiry);
			response.sendRedirect(request.getContextPath()+"/jsp/support/inquiryList.jsp");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
