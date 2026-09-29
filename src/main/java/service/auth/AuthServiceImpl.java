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
	public User login(String loginId, String password) throws Exception {
		User user = userDao.selectUser(loginId);
		if(user==null) throw new Exception("아이디를 다시 확인해주세요.");
		if(!user.getPassword().equals(password)) throw new Exception("비밀번호를 다시 확인해주세요.");
		user.setPassword("");
		return user;
	}

}
