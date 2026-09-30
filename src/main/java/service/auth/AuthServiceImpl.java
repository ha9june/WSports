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
	public User login(String loginId, String password) throws Exception {
		User user = userDao.selectLoginId(loginId);
		if(user==null) throw new Exception("아이디를 다시 확인해주세요.");
		if(!user.getPassword().equals(password)) throw new Exception("비밀번호를 다시 확인해주세요.");
		user.setPassword("");
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

