package controller.review;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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

import dto.Review;
import dto.User;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewWrite
 */
@MultipartConfig(
		maxFileSize = 1024*1024*10, //개별 파일 최대 크기(10MB)
		maxRequestSize = 1024*1024*10*5, //전체 요청 최대 크기(50MB)
		fileSizeThreshold =  1024*1024*1 //1MB 초과시 임시 디스크 경로 사용
)
@WebServlet("/review/create")
public class ReviewWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int MAX_PHOTOS = 5;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewWrite() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        ReviewService service = new ReviewServiceImpl();
        try {
            List<Review> myMatches = service.getReviewableMatches(user.getUserId());
            request.setAttribute("myMatches", myMatches);
            System.out.println(myMatches);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/review/create?error=fail");
        }

        request.getRequestDispatcher("/jsp/review/reviewWrite.jsp").forward(request, response);
    }
    
    
    
    
    
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		User user =(User) session.getAttribute("user");
	
		if(user == null) {
			response.sendRedirect(request.getContextPath()+"/auth/login");
			return;
		}
		long userId = user.getUserId();
		
		String uploadPath = (String) request.getServletContext().getAttribute("uploadPath");
		String realPath = request.getServletContext().getRealPath(uploadPath);
		
		
		String matchNo = request.getParameter("matchNo");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		  String[] parts = matchNo.split(":");
		    String matchType = parts[0];
		    Long matchId;
		    try {
		        matchId = Long.parseLong(parts[1].trim());
		    } catch (NumberFormatException e) {
		        response.sendRedirect(request.getContextPath() + "/review/write?error=invalid");
		        return;
		    }
		
		
		 // 사진 수집 (최대 5장, jpg/png만)
        List<Part> image = new ArrayList<>();
        for (Part part : request.getParts()) {
            if (!"photos".equals(part.getName()) || part.getSize() == 0) continue;
            String type = part.getContentType();
            if (!"image/jpeg".equals(type) && !"image/png".equals(type)) continue;
            if (image.size() >= MAX_PHOTOS) break;
            image.add(part);
        }
        
		ReviewService service = new ReviewServiceImpl();
		
		try{
			 boolean allowed = false;
		        for (Review r : service.getReviewableMatches(userId)) {
		            if (r.getMatchType().equals(matchType) && r.getMatchId().equals(matchId)) {
		                allowed = true;
		                break;
		            }
		        }
		        if (!allowed) {
		            response.sendRedirect(request.getContextPath() + "/review/write?error=notAllowed");
		            return;
		        }

		        Review review = new Review();
		        review.setMatchType(matchType);
		        review.setMatchId(matchId);
		        review.setTitle(title.trim());
		        review.setContent(content.trim());

		        Long reviewId = service.writeReview(review, userId, realPath, image);
		        response.sendRedirect(request.getContextPath()
		                + "/jsp/review/reviewDetail.jsp?reviewId=" + reviewId + "&state=mine");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
