package service.notification;

import java.net.HttpURLConnection;
import java.net.URL;

import config.FCMConfig;
import dao.NotificationDao;
import dao.NotificationDaoImpl;
import dto.Notification;

public class NotificationServiceImpl implements NotificationService {
	
	NotificationDao notificationDao;
	
	public NotificationServiceImpl() {
		notificationDao = new NotificationDaoImpl();
	}

	@Override
	public void sendNotification(Notification notification) throws Exception {
		notificationDao.insertNotification(notification);
		
		String fcmUrl = "https://fcm.googleapis.com/v1/projects/wsports-d9450/messages:send";
		URL url = new URL(fcmUrl);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		String accessToken = FCMConfig.getAccessToken();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "Bearer "+accessToken);
		conn.setRequestProperty("Content-Type", "application/json; UTF-8");
		conn.setDoOutput(true);
		
		
	}

}
