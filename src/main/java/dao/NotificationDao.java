package dao;

import java.util.List;
import java.util.Map;

import dto.Notification;

public interface NotificationDao {
	Long insertNotification(Notification notification) throws Exception;	//새 알림 추가
	void updateNotificationIdRead(Long notificationId) throws Exception;	//알림 id로 알림 조회
	Notification selectNotification(Long notificationId) throws Exception;	//특정 알림 읽음 처리
	List<Notification> selectNotificationListNotConfirm3(Long userId) throws Exception; //아이디로 안 읽은 알림 3개 최신순 가져오기
	List<Notification> selectNotificationList(Long userId) throws Exception; //아이디로 모든 알림 가져오기
	int selectNotificationListNotConfirmCnt (Long userId) throws Exception; //안 읽은 알림 수
	
	int updateRead(Map<String, Object> param) throws Exception;
	String selectLink(Map<String, Object> param) throws Exception;
	int updateAllRead(Long userId) throws Exception;
	List<Map<String, Object>> selectMyNotificationList(Long userId) throws Exception;
	List<Map<String, Object>> selectMypageNotificationList(Long userId) throws Exception;
	int selectMypageAlarmUnreadCount(Long userId) throws Exception;
	int updateMypageNotificationRead(Map<String, Object> param) throws Exception;
	int updateMypageAllNotificationRead(Long userId) throws Exception;
}
