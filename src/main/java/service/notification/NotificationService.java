package service.notification;

import dto.Notification;

public interface NotificationService {
	void sendNotification(Notification alarm) throws Exception;
}
