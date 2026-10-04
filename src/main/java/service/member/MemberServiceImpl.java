package service.member;

import dao.UserDao;
import dao.UserDaoImpl;
import dto.User;

public class MemberServiceImpl implements MemberService {
	private UserDao userDao;
	
	public MemberServiceImpl() {
		userDao = new UserDaoImpl();
	}

	@Override
	public void mypageEdit(User user) throws Exception {
		userDao.updateMypage(user);
	}

}
