package service.auth;


import dao.ReviewDao;
import dao.UserDao;
import dao.UserDaoImpl;
import dto.Review;
import dto.User;

public class AuthServiceImpl implements AuthService {
	private UserDao userDao;
	
	public AuthServiceImpl() {
		userDao = new UserDaoImpl();
	}

	@Override
	public User login(String loginId) throws Exception {
		User user = userDao.selectLoginId(loginId);
		return user;
	}

	@Override
	public void join(User user) throws Exception {
		userDao.insertUser(user);
		
	}

	@Override
	public boolean checkUserId(String loginId) throws Exception {
		return userDao.selectLoginId(loginId) != null;
	}

	@Override
	public boolean checkUserNickname(String nickname) throws Exception {
		return userDao.selectNickname(nickname) != null;
	}
}

