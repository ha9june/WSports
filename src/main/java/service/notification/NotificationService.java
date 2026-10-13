package service.notification;

import java.util.List;
import java.util.Map;

import dto.Notification;

public interface NotificationService {
	void sendNotification(Notification alarm) throws Exception;
	void confirmNotification(Long notificationId) throws Exception;
	List<Notification> getNotificationList(Long userId) throws Exception;
	List<Notification> getNotificationListNotConfirm3(Long userId) throws Exception;
	int getNotificationListNotConfirmCnt(Long userId) throws Exception;
	String readAndGetLink(Long notificationId, Long userId) throws Exception;
	int readAll(Long userId) throws Exception;
	List<Map<String, Object>> getMyNotificationList(Long userId) throws Exception;
}
