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
import service.support.InquiryService;
import service.support.InquiryServiceImpl;
import util.PageInfo;

/**
 * Servlet implementation class SupportInquiryList
 */
@WebServlet("/support/inquiry/list")
public class SupportInquiryList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportInquiryList() {
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
		InquiryService service = new InquiryServiceImpl();
		try {
			List<Map<String,Object>> inquiryList = service.inquiryList(pageInfo, userId, status);
			request.setAttribute("inquiryList", inquiryList);
			request.setAttribute("pageInfo", pageInfo);
			request.getRequestDispatcher("/jsp/support/inquiryList.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
