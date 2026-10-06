package service.notification;

import java.util.List;

import dto.UserFcmToken;

public interface UserFcmTokenService {
	void registerToken(UserFcmToken userFcmToken) throws Exception;
	List<String> getUserFcmToken(Long userId) throws Exception;
	int changeActiveUserFcmToken(Long userId, String fcmToken) throws Exception;
}
