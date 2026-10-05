package dao;

import dto.User;

public interface UserDao {

	User selectLoginId(String loginId) throws Exception;
	User selectNickname(String nickname) throws Exception;
	void insertUser (User user) throws Exception;
	void updateLastLogin(String loginId) throws Exception;
	void updateMypage(User user) throws Exception;
	void updateProfile(User user) throws Exception;
}
