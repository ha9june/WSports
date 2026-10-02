package service.notification;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import org.json.simple.JSONObject;

import config.FCMConfig;
import dao.NotificationDao;
import dao.NotificationDaoImpl;
import dao.UserFcmTokenDao;
import dao.UserFcmTokenDaoImpl;
import dto.Notification;


public class NotificationServiceImpl implements NotificationService {
	
	NotificationDao notificationDao;
	UserFcmTokenDao userFcmTokenDao;
	
	public NotificationServiceImpl() {
		notificationDao = new NotificationDaoImpl();
		userFcmTokenDao = new UserFcmTokenDaoImpl();
	}

	@Override
	public void sendNotification(Notification alarm) throws Exception {
		Long alarmId = notificationDao.insertNotification(alarm);
		System.out.println(alarmId);
		Notification alarmFromDb = notificationDao.selectNotification(alarmId);
		System.out.println(alarmFromDb);
		
		String fcmUrl = "https://fcm.googleapis.com/v1/projects/wsports-d9450/messages:send";
		URL url = new URL(fcmUrl);
		
		String accessToken = FCMConfig.getAccessToken();
		
		List<String> userFcmTokenList = userFcmTokenDao.selectUserFcmToken(alarm.getUserId());
		
		for(String userFcmToken : userFcmTokenList) {
			
			HttpURLConnection conn = null;
			try {
				conn = (HttpURLConnection)url.openConnection();
				
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Authorization", "Bearer "+accessToken);
				conn.setRequestProperty("Content-Type", "application/json; UTF-8");
				conn.setDoOutput(true);
				
				JSONObject notification = new JSONObject();
				notification.put("title", alarm.getTitle());
				notification.put("body", alarm.getContent());
				
				JSONObject data = new JSONObject();
				data.put("userId", alarm.getUserId()+"");
				data.put("link", alarm.getLink());
				data.put("createdAt",alarmFromDb.getCreatedAt().toString());
				data.put("notificationId", String.valueOf(alarmId));
				
				JSONObject message = new JSONObject();
				userFcmToken = userFcmToken.trim();
				message.put("token", userFcmToken);
				message.put("notification", notification);
				message.put("data", data);
				
				JSONObject json = new JSONObject();
				json.put("message", message);
				
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				bw.write(json.toJSONString());
				bw.flush();
				bw.close();
				
				int resCode = conn.getResponseCode();
				BufferedReader br;
				if(resCode == 200) {
					br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				} else {
					br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
				}
				
				StringBuilder sb = new StringBuilder();
				String line;
				while((line=br.readLine())!=null) {
					sb.append(line);
				}
				br.close();
				if(resCode!=200) throw new Exception("FCM 전송 실패 "+sb.toString());
			} catch(Exception e) {
				e.printStackTrace();
			} finally {	
				if(conn != null) conn.disconnect();
			}

		}
		
		
	}

	@Override
	public void confirmNotification(Long notificationId) throws Exception {
		notificationDao.updateNotificationIdRead(notificationId);
	}

	@Override
	public List<Notification> getNotificationList(Long userId) throws Exception {
		return notificationDao.selectNotificationList(userId);
	}
	
	public List<Notification> getNotificationListNotConfirm3(Long userId) throws Exception {
		return notificationDao.selectNotificationListNotConfirm3(userId);
	}
	
	@Override
	public int getNotificationListNotConfirmCnt(Long userId) throws Exception {
		return notificationDao.selectNotificationListNotConfirmCnt(userId);
	}

}
