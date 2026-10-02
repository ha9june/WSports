package controller.Review;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import javax.servlet.http.Part;
import dto.Review;
import dto.User;
import service.review.ReviewService;
import service.review.ReviewServiceImpl;

/**
 * Servlet implementation class ReviewWrite
 */
@WebServlet("/review/create")
@MultipartConfig(
		maxFileSize = 1024*1024*10, //개별 파일 최대 크기(10MB)
		maxRequestSize = 1024*1024*10*5, //전체 요청 최대 크기(50MB)
		fileSizeThreshold =  1024*1024*1 //1MB 초과시 임시 디스크 경로 사용
)
public class ReviewWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewWrite() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession Session = request.getSession();
		User loginUser = (User) Session.getAttribute("user");
		
		if(loginUser==null) {
			response.sendRedirect(request.getContextPath()+"auth/login");
			return; //즉시종료 (DB 호출 차단)
		}
		
		// Long타입 캐스팅해서 불러옴
//		Long matchId = (Long.parseLong(request.getParameter("matchId"))); 
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String image = request.getParameter("image");
		Long userId = loginUser.getUserId();
		
		Review review = new Review(title,content,image);
		
		Part ifile = request.getPart("ifile");
		Part dfile = request.getPart("ifile");
		
		String uploadPath = (String) request.getServletContext().getAttribute("uploadPath");
		String realPath = request.getServletContext().getRealPath(uploadPath);
		
		ReviewService service = new ReviewServiceImpl();
		try {
			Long matchId = service.wirteReview(review, realPath, ifile, dfile);
			response.sendRedirect(request.getContextPath()+"review/reviewWrite?matchId="+matchId);
		}catch(Exception e) {
			e.printStackTrace();
			
		}
	}
}
