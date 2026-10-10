package controller.review;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class AdminContentReviewDelete
 */
@WebServlet("/admin/content/review-delete")
public class AdminContentReviewDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminContentReviewDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain;charset=UTF-8");

		Object role = request.getSession().getAttribute("role");
		if (role == null || !"admin".equals(role.toString())) {
			response.getWriter().write("false");
			return;
		}

		String idParam = request.getParameter("reviewId");
		if (idParam == null || !idParam.matches("\\d+")) {
			response.getWriter().write("false");
			return;
		}
		ReviewService service = new ReviewServiceImpl();
		
		try {
			boolean ok = service.removeReviewByAdmin(Long.parseLong(idParam));
			response.getWriter().write(String.valueOf(ok)); // "true" / "false"
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("false");
		}
	}
}
