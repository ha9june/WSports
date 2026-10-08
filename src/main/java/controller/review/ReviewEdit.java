package controller.review;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dto.User;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewEdit
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 10, // 개별 파일 최대 크기(10MB)
		maxRequestSize = 1024 * 1024 * 10 * 5, // 전체 요청 최대 크기(50MB)
		fileSizeThreshold = 1024 * 1024 * 1 // 1MB 초과시 임시 디스크 경로 사용
)
@WebServlet("/review/edit")
public class ReviewEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReviewEdit() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 로그인 체크
		HttpSession session = request.getSession(false);
		User user = (session == null) ? null : (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;// 로그인 경로 수정
		}

		String idParam = request.getParameter("reviewId");
		if (idParam == null || !idParam.matches("\\d+")) {
			response.sendError(400);
			return;
		}

		try {
			ReviewService service = new ReviewServiceImpl();
			Map<String, Object> review = service.selectMyReview(user.getUserId(), Long.parseLong(idParam));
			if (review == null) {
				response.sendError(404);
				return;
			}
			request.setAttribute("review", review);
			request.getRequestDispatcher("/jsp/review/reviewModify.jsp").forward(request, response);
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User user = (session == null) ? null : (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		String idParam = request.getParameter("reviewId");
		if (idParam == null || !idParam.matches("\\d+")) {
			response.sendError(400);
			return;
		}
		long reviewId = Long.parseLong(idParam);
		String title = request.getParameter("title");
		String content = request.getParameter("content");

		// 작성 서블릿과 같은 업로드 폴더여야 사진이 보입니다
		String uploadPath = getServletContext().getRealPath("/uploads");
		List<String> savedNew = new ArrayList<>();
		ReviewServiceImpl service = new ReviewServiceImpl();

		try {
			Map<String, Object> origin = service.selectMyReview(user.getUserId(), reviewId);
			if (origin == null) {
				response.sendError(403);
				return;
			}
			String originImage = (origin.get("image") == null) ? "" : String.valueOf(origin.get("image"));
			List<String> originList = Arrays.asList(originImage.split(","));

			// 남긴 기존 사진 (원래 후기의 사진만 인정)
			List<String> names = new ArrayList<>();
			String[] keep = request.getParameterValues("keepImages");
			if (keep != null) {
				for (String k : keep) {
					if (originList.contains(k))
						names.add(k);
				}
			}

			// 새로 추가한 사진 저장
			for (Part part : request.getParts()) {
				if ("photos".equals(part.getName()) && part.getSize() > 0 && part.getSubmittedFileName() != null
						&& !part.getSubmittedFileName().isEmpty()) {
					String saved = service.fileUpload(uploadPath, part);
					savedNew.add(saved);
					names.add(saved);
				}
			}

			if (names.size() > 5) {
				for (String n : savedNew)
					new File(uploadPath, n).delete();
				response.sendError(400);
				return;
			}

			int cnt = service.modifyMypageReview(user.getUserId(), reviewId, title, content, String.join(",", names)); // 전부
			if (cnt == 0) {
				for (String n : savedNew)
					new File(uploadPath, n).delete();
				response.sendError(403);
				return;
			}
			response.sendRedirect(request.getContextPath() + "/mypage/reviews");
		} catch (Exception e) {
			e.printStackTrace();
			for (String n : savedNew)
				new File(uploadPath, n).delete();
			response.sendRedirect(request.getContextPath() + "/review/edit?reviewId=" + reviewId + "&error=fail");
		}
	}
}
