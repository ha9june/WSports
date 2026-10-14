package controller.review;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Comment;
import dto.Notification;
import dto.Review;
import dto.User;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewComment
 */
@WebServlet("/review/comment")
public class ReviewComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewComment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/auth/login");
			return;
		}

		String reviewIdParam = request.getParameter("reviewId");
		String content = request.getParameter("content");

		if (reviewIdParam == null || !reviewIdParam.matches("\\d+")) {
			response.sendRedirect(request.getContextPath() + "/review/list");
			return;
		}
		Long reviewId = Long.parseLong(reviewIdParam);

		try {
			ReviewService service = new ReviewServiceImpl();
			NotificationService notiService = new NotificationServiceImpl();
			Notification alarm = new Notification();
			
			service.writeComment(reviewId, user.getUserId(), content);
			Comment comment = new Comment();
			Review review = service.getReviewDetail(reviewId);
			alarm.setTitle("'"+review.getTitle()+"'"+" 후기에 댓글이 달렸습니다.");
			alarm.setContent("'"+user.getNickname()+"'"+"님이 후기 댓글을 남겼습니다.");
			alarm.setUserId(review.getUserId());
			alarm.setLink("/review/detail?reviewId="+ reviewId);
			
			notiService.sendNotification(alarm);
		} catch (Exception e) {
			e.printStackTrace();
		}

		response.sendRedirect(request.getContextPath() + "/review/detail?reviewId=" + reviewId);
	}
}
