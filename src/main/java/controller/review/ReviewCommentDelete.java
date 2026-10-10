package controller.review;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReviewDao;
import dao.ReviewDaoImpl;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewCommentDelete
 */
@WebServlet("/review/comment/delete")
public class ReviewCommentDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewCommentDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain;charset=UTF-8");
		dto.User user = (dto.User) request.getSession().getAttribute("user");
		if (user == null) { response.getWriter().write("login"); return; }

		String idParam = request.getParameter("commentId");
		if (idParam == null || !idParam.matches("\\d+")) {
			response.getWriter().write("fail"); return;
		}
		ReviewService service = new ReviewServiceImpl();
		try {
			boolean ok = service.removeComment(Long.parseLong(idParam), user.getUserId());
			response.getWriter().write(ok ? "ok" : "fail");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("fail");
		}
	}
}
