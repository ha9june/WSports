package dao;

import java.util.List;

import dto.Notification;

public interface NotificationDao {
	Long insertNotification(Notification notification) throws Exception;
	void updateNotificationIdRead(Long notificationId) throws Exception;
	Notification selectNotification(Long notificationId) throws Exception;
	List<Notification> selectNotificationListNotConfirm3(Long userId) throws Exception; //아이디로 안 읽은 알림 3개 최신순 가져오기
	List<Notification> selectNotificationList(Long userId) throws Exception; //아이디로 모든 알림 가져오기
	int selectNotificationListNotConfirmCnt (Long userId) throws Exception; //안 읽은 알림 수

}
