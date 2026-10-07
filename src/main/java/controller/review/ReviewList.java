package controller.review;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewList
 */
@WebServlet("/review/list")
public class ReviewList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 User user = (User) request.getSession().getAttribute("user");
		    Long userId = (user == null) ? null : user.getUserId();
		    
		    ReviewService service = new ReviewServiceImpl();
		    
		    try {
		        request.setAttribute("reviews", service.getReviewList(userId));
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		
		request.getRequestDispatcher("/jsp/review/reviewList.jsp").forward(request, response);
	
	
	}

}
