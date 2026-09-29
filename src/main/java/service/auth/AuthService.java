package service.auth;

import dto.User;

public interface AuthService {
	User login(String loginId, String password) throws Exception;
}
