package service.notification;

import dto.UserFcmToken;

public interface UserFcmTokenService {
	void registerToken(UserFcmToken userFcmToken) throws Exception;
}
