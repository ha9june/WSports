package service.notification;

import java.util.List;

import dto.Notification;

public interface NotificationService {
	void sendNotification(Notification alarm) throws Exception;
	void confirmNotification(Long notificationId) throws Exception;
	List<Notification> getNotificationList(Long userId) throws Exception;
	List<Notification> getNotificationListNotConfirm3(Long userId) throws Exception;
	int getNotificationListNotConfirmCnt(Long userId) throws Exception;
}
