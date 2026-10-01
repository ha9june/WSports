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
		notificationDao.insertNotification(alarm);
		
		String fcmUrl = "https://fcm.googleapis.com/v1/projects/wsports-d9450/messages:send";
		URL url = new URL(fcmUrl);
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		String accessToken = FCMConfig.getAccessToken();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "Bearer "+accessToken);
		conn.setRequestProperty("Content-Type", "application/json; UTF-8");
		conn.setDoOutput(true);
		
		List<String> userFcmTokenList = userFcmTokenDao.selectUserFcmToken(alarm.getUserId());
		
		for(int i=0; i<userFcmTokenList.size(); i++) {
			JSONObject notification = new JSONObject();
			notification.put("title", alarm.getTitle());
			notification.put("body", alarm.getContent());
			
			JSONObject data = new JSONObject();
			data.put("userId", alarm.getUserId());
			data.put("link", alarm.getLink());
			
			JSONObject message = new JSONObject();
			message.put("token", userFcmTokenList.get(i));
			message.put("notification", notification);
			message.put("data", data);
			
			JSONObject json = new JSONObject();
			json.put("message", message);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			bw.write(json.toJSONString());
			bw.flush();
			
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
			conn.disconnect();
			
//			System.out.println(sb.toString());
			if(resCode!=200) throw new Exception("FCM 전송 실패 ");
		}
		

		
	}

}
