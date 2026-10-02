package service.auth;


import dao.UserDao;
import dao.UserDaoImpl;
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

	@Override
	public User loginCheck(String loginId, String password) throws Exception {
		User user = userDao.selectLoginId(loginId);
	    if (user == null) {
	        return null;               // 아이디 없음
	    }
	    if (user.getPassword() == null || !user.getPassword().equals(password)) {
	        return null;               // 비밀번호 불일치
	    }
	    return user;                   // 로그인 성공
	}
	
	@Override
	public void updateLastLogin(String loginId) throws Exception {
		userDao.updateLastLogin(loginId);		
	}
}

