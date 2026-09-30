package service.auth;

import javax.servlet.http.Part;

import dto.User;

public interface AuthService {
	User login(String loginId, String password) throws Exception;
	void join(User user) throws Exception;
	boolean checkUserId(String loginId) throws Exception;
	boolean checkUserNickname(String nickname) throws Exception;
}
