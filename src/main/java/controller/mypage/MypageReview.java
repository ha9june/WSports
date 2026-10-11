package controller.mypage;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.User;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;
import util.PageInfo;

/**
 * Servlet implementation class MypageReview
 */
@WebServlet("/mypage/reviews")
public class MypageReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MypageReview() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
	    User user = (session == null) ? null : (User) session.getAttribute("user");
	    if (user == null) {
	        response.sendRedirect(request.getContextPath() + "/login");
	        return;
	    }

	    int page = 1;
	    String sPage = request.getParameter("page");
	    if (sPage != null && sPage.matches("\\d+")) page = Integer.parseInt(sPage);

	    PageInfo pageInfo = new PageInfo(page);
	    ReviewService service = new ReviewServiceImpl();
	    try {
	        List<Map<String, Object>> list = service.getMypageReviewList(pageInfo, user.getUserId());
	        request.setAttribute("Review", list);
	        request.setAttribute("pageInfo", pageInfo);
	        request.getRequestDispatcher("/jsp/mypage/myPageReview.jsp").forward(request, response);
	    } catch (Exception e) {
	        throw new ServletException(e);
	    }
	}

				
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    response.setContentType("text/plain; charset=UTF-8");
	    PrintWriter out = response.getWriter();

	    HttpSession session = request.getSession(false);
	    User user = (session == null) ? null : (User) session.getAttribute("user");
	    if (user == null) {
	        out.print("login");
	        return;
	    }

	    String action = request.getParameter("action");
	    String idParam = request.getParameter("reviewId");

	    try {
	        if ("delete".equals(action) && idParam != null && idParam.matches("\\d+")) {
	            ReviewService service = new ReviewServiceImpl();
	            int cnt = service.deleteMypageReview(user.getUserId(), Long.parseLong(idParam));
	            out.print(cnt > 0 ? "ok" : "fail");
	            System.out.println("delete userId=" + user.getUserId() + ", reviewId=" + idParam);
	        } else {
	            out.print("fail");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        out.print("fail");
	    }
	}
}
