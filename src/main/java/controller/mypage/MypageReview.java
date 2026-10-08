package controller.mypage;

import java.io.IOException;
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
				// 로그인 체크
				HttpSession session = request.getSession(false);
				User user = (session == null) ? null : (User) session.getAttribute("user");
				if (user == null) {
					response.sendRedirect(request.getContextPath() + "/login");
					return;// 로그인 경로 수정
				}
				long userId = user.getUserId();

				// 페이지 번호 (기본 1)
				int page = 1;
				String sPage = request.getParameter("page");
				if (sPage != null && !sPage.isEmpty()) {
					try {
						page = Integer.parseInt(sPage);
					} catch (NumberFormatException e) {
						page = 1;
					}
				}
				String state = request.getParameter("state");
				if (state == null || state.isEmpty())
					state = "joined";
				PageInfo pageInfo = new PageInfo(page);
				ReviewService service = new ReviewServiceImpl();

				try {
					List<Map<String, Object>> list = service.getMypageReviewList(pageInfo, userId);
					request.setAttribute("Review", list);
					request.setAttribute("pageInfo", pageInfo);
					System.out.println(list);
					request.getRequestDispatcher("/jsp/mypage/myPageReview.jsp").forward(request, response);
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("err", "개인 경기 목록 조회 오류");
				}
	}
}
