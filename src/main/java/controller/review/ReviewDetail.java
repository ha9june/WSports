package controller.review;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ReviewService service = new ReviewServiceImpl();
		boolean isFavorite = false;

		try {
			String reviewIdParam = request.getParameter("reviewId");

			if (reviewIdParam == null) {
				response.sendRedirect(request.getContextPath() + "/review/list");
				return;
			}

			Long reviewId = Long.parseLong(reviewIdParam); // String -> Long 변환

			// 후기 상세 내용 조회
			Review review = service.getReviewDetail(reviewId);
			if (review == null) {
				response.sendRedirect(request.getContextPath() + "/review/list");
				return;
			}

			List<Comment> commentList = service.getCommentList(reviewId);

			dto.User loginUser = (dto.User) request.getSession().getAttribute("user");
			if (loginUser != null) {
				isFavorite = service.checkReviewLike(reviewId, loginUser.getUserId());
			}
			// 좋아요 개수 조회
			long likeCount = 0;
			List<Map<String, Object>> likeCntList = service.getReviewLikeCnt();
			if (likeCntList != null) {
				for (Map<String, Object> map : likeCntList) {
					Object rIdObj = map.get("reviewId");
					if (rIdObj != null && Long.parseLong(rIdObj.toString()) == reviewId) {
						likeCount = Long.parseLong(map.get("cnt").toString());
						break;
					}
				}
			}
			
			request.setAttribute("review", review);
			request.setAttribute("commentList", commentList);
			request.setAttribute("content", commentList);   
			request.setAttribute("isFavorite", isFavorite);
			request.setAttribute("likeCount", likeCount);

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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/plain;charset=UTF-8");
		ReviewService service = new ReviewServiceImpl();
		dto.User user = (dto.User) request.getSession().getAttribute("user");
		if (user == null) {
			response.getWriter().write("login"); // 로그인 안 되어 있으면 'login' 반환
			return;
		}

		try {
			String reviewIdParam = request.getParameter("reviewId");
			String heartParam = request.getParameter("heart"); // "true" 또는 "false" 문자열로 옴

			if (reviewIdParam == null || heartParam == null) {
				response.getWriter().write("fail");
				return;
			}

			Long reviewId = Long.parseLong(reviewIdParam);
			Long userId = user.getUserId();
			boolean isHeart = Boolean.parseBoolean(heartParam);

			List<Map<String, Object>> likeCntList = service.getReviewLikeCnt();
			long likeCount = 0;
			if (likeCntList != null) {
				for (Map<String, Object> map : likeCntList) {
					Object rIdObj = map.get("reviewId");
					if (rIdObj != null) {
						long rId = Long.parseLong(rIdObj.toString());
						if (rId == reviewId) {
							likeCount = Long.parseLong(map.get("cnt").toString());
							break;
						}
					}
				}
			}
			request.setAttribute("likeCount", likeCount);
			if (isHeart) {
				boolean isSuccess = service.addReviewLike(reviewId, userId);
				if (isSuccess) {
					response.getWriter().write("insert");
				} else {
					response.getWriter().write("fail");
				}
			} else {
				boolean isSuccess = service.removeReviewLike(reviewId, userId);
				if (isSuccess) {
					response.getWriter().write("delete");
				} else {
					response.getWriter().write("fail");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("fail");
		}
	}
}
