package controller.notification;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dto.Notification;
import dto.User;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;

/**
 * Servlet implementation class NotificationList
 */
@WebServlet("/notification/list")
public class NotificationList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NotificationList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    private String formatNotificationDate(LocalDateTime createdAt) {

        LocalDate today = LocalDate.now();
        LocalDate date = createdAt.toLocalDate();

        // 오늘
        if (date.equals(today)) {
            return createdAt.format(
                DateTimeFormatter.ofPattern("HH:mm")
            );
        }

        // 어제
        if (date.equals(today.minusDays(1))) {
            return "어제";
        }

        // 올해
        if (date.getYear() == today.getYear()) {
            return createdAt.format(
                DateTimeFormatter.ofPattern("M/d")
            );
        }

        // 작년 이전
        return createdAt.format(
            DateTimeFormatter.ofPattern("yy.MM.dd")
        );
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
		    return;
		}

		User user = (User) session.getAttribute("user");
		
		NotificationService notificationService = new NotificationServiceImpl();
		try {
			List<Notification> notificationList = notificationService.getNotificationListNotConfirm3(user.getUserId());
			int notConfirmCnt = notificationService.getNotificationListNotConfirmCnt(user.getUserId());
			JSONArray jsonArray = new JSONArray();
			for(Notification notification : notificationList) {
				JSONObject json = new JSONObject();
	            json.put("notificationId", notification.getNotificationId());
	            json.put("title", notification.getTitle());
	            json.put("content", notification.getContent());
	            json.put("link", notification.getLink());
	            json.put("isRead", notification.getIsRead());
	            json.put("createdAt", notification.getCreatedAt().toString());
	            json.put("displayDate", formatNotificationDate(notification.getCreatedAt()));
	            jsonArray.add(json);
			}
			
		    JSONObject result = new JSONObject();

		    result.put("notificationList", jsonArray);
		    result.put("notConfirmCnt", notConfirmCnt);
		    response.setContentType("application/json; charset=UTF-8");
			response.getWriter().write(result.toJSONString());
			
		} catch(Exception e) {
			e.printStackTrace();
			response.getWriter().write("알림 리스트 가져오기 오류");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
