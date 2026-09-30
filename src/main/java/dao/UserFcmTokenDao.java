package dao;

import dto.UserFcmToken;

public interface UserFcmTokenDao {
	void upsertFcmToken(UserFcmToken userFcmToken) throws Exception;
}
