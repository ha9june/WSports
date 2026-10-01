package dao;

import java.util.List;

import dto.Notification;

public interface NotificationDao {
	void insertNotification(Notification notification) throws Exception;
	void updateNotificationConfirm(Notification notification) throws Exception;
	List<Notification> selectNotificationList(Long userId) throws Exception;
	List<Notification> selectNotificationListNotconfirm(Long userId) throws Exception;

}
