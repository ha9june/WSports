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
import service.support.NoticeService;
import service.support.NoticeServiceImpl;
import util.PageInfo;

/**
 * Servlet implementation class SupportNoticeList
 */
@WebServlet("/support/notice/list")
public class SupportNoticeList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportNoticeList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		String keyword = request.getParameter("keyword");
		String type = request.getParameter("type");
		if (type == null || type.isEmpty()) type = "ALL";
		
		String sPage = request.getParameter("page");
		Integer page = 1;
		if(sPage!=null && !sPage.isEmpty()) {
			page = Integer.parseInt(sPage);
		}
		
		PageInfo pageInfo = new PageInfo(page);
		NoticeService service = new NoticeServiceImpl();
		try {
			List<Map<String,Object>> noticeList = service.noticeList(pageInfo, keyword, type);
			
			request.setAttribute("noticeList", noticeList);
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("keyword", keyword);
			request.setAttribute("type", type);
			request.getRequestDispatcher("/jsp/support/noticeList.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
