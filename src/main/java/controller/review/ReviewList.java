package controller.review;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Review;
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
		    
		    String state = "grouped".equals(request.getParameter("state")) ? "grouped" : "recent";
		    
		    
		    ReviewService service = new ReviewServiceImpl();
		    
		    try {
		    	List<Review> reviewList = service.getReviewList(userId);

				if ("grouped".equals(state)) {
					Map<Long, List<Review>> groupList = new LinkedHashMap<>();
					for (Review r : reviewList) {
						groupList.computeIfAbsent(r.getMatchId(), k -> new ArrayList<>()).add(r);
					}
					request.setAttribute("groupList", groupList);
				} else {
					request.setAttribute("reviewList", reviewList);
				}
				request.setAttribute("state", state);
			} catch (Exception e) {
				throw new ServletException(e);
			}
		
		request.getRequestDispatcher("/jsp/review/reviewList.jsp").forward(request, response);
	
	
	}

}
