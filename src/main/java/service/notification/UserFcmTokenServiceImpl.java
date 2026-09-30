package service.notification;

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
		userFcmTokenDao.upsertFcmToken(userFcmToken);
	}

}
