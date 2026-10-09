package controller.review;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Comment;
import dto.Review;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewDetail
 */
@WebServlet("/review/detail")
public class ReviewDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String reviewIdParam = request.getParameter("reviewId");
			
			if (reviewIdParam == null) {
			    response.sendRedirect(request.getContextPath() + "/review/list");
			    return;
			}
			
			Long reviewId = Long.parseLong(reviewIdParam); // String -> Long 변환
			
			ReviewService service = new ReviewServiceImpl();
			
			
			Review review = service.getReviewDetail(reviewId);
			if (review == null) {
			    response.sendRedirect(request.getContextPath() + "/review/list");
			    return;
			}
			List<Comment> commentList = service.getCommentList(reviewId);
			
			request.setAttribute("review", review);
			request.setAttribute("commentList", commentList);
			
		} catch (NumberFormatException e) {
		    response.sendRedirect(request.getContextPath() + "/review/list");
		    return;
		} catch (Exception e) {
		    e.printStackTrace();
		    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		    return;
		}
		
		// 4. 미리 지정해두신 경로로 JSP 포워딩 처리
		request.getRequestDispatcher("/jsp/review/reviewDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
