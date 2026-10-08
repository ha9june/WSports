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
import util.PageInfo;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("user");
		Long userId = (user == null) ? null : user.getUserId();
		ReviewService service = new ReviewServiceImpl();
		
		
		String state = "grouped".equals(request.getParameter("state")) ? "grouped" : "recent";
        request.setAttribute("state", state);
		
        try {
            if ("grouped".equals(state)) {
                List<Review> reviewList = service.getReviewList(userId);
                Map<Long, List<Review>> groupList = new LinkedHashMap<>();
                for (Review r : reviewList) {
                    groupList.computeIfAbsent(r.getMatchId(), k -> new ArrayList<>()).add(r);
                }
                request.setAttribute("groupList", groupList);
            } else {
                String pageParam = request.getParameter("page");
                Integer page = (pageParam == null || !pageParam.matches("\\d+"))
                        ? 1 : Integer.parseInt(pageParam);

                String status = request.getParameter("status");
                if (status == null || status.isEmpty()) status = "ALL";

                PageInfo pageInfo = new PageInfo(page);
                List<Map<String, Object>> list = service.selectMainReviewList(pageInfo, status);
                request.setAttribute("reviewList", list);
                request.setAttribute("pageInfo", pageInfo);
            }
            
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "후기 목록 조회 오류");
		}

		request.getRequestDispatcher("/jsp/review/reviewList.jsp").forward(request, response);

	}

}
