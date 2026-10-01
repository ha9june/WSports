package service.notification;

import java.util.List;

import dao.UserFcmTokenDao;
import dao.UserFcmTokenDaoImpl;
import dto.UserFcmToken;

public class UserFcmTokenServiceImpl implements UserFcmTokenService {
	
	UserFcmTokenDao userFcmTokenDao;
	
	public UserFcmTokenServiceImpl() {
		userFcmTokenDao = new UserFcmTokenDaoImpl();
	}

	@Override
	public void registerToken(UserFcmToken userFcmToken) throws Exception {
		userFcmTokenDao.upsertUserFcmToken(userFcmToken);
	}

	@Override
	public List<String> getUserFcmToken(Long userId) throws Exception {
		return userFcmTokenDao.selectUserFcmToken(userId);
	}

}
