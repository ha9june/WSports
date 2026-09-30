package service.notification;

import dto.Notification;

public interface NotificationService {
	void sendNotification(Notification notification) throws Exception;
}
