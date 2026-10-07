package dao;

import java.util.List;

import dto.UserFcmToken;

public interface UserFcmTokenDao {
	void upsertUserFcmToken(UserFcmToken userFcmToken) throws Exception;
	List<String> selectUserFcmToken(Long userId) throws Exception;
	int updateUserFcmToken(Long userId, String fcmToken) throws Exception;
}
