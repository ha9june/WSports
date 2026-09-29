package dao;

import dto.User;

public interface UserDao {
	void insertUser (User user) throws Exception;
	User selectUser(String loginId) throws Exception;
}
