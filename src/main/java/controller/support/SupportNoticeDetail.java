package controller.support;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.support.NoticeService;
import service.support.NoticeServiceImpl;

/**
 * Servlet implementation class SupportNoticeDetail
 */
@WebServlet("/support/notice/detail")
public class SupportNoticeDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SupportNoticeDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Long noticeId = Long.parseLong(request.getParameter("noticeId"));
		NoticeService service = new NoticeServiceImpl();
		try {
			request.setAttribute("notice", service.detailNotice(noticeId));
			request.getRequestDispatcher("/jsp/support/noticeDetail.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
