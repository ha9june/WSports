package dao;

import java.util.List;
import java.util.Map;

import dto.User;

public interface UserDao {

	User selectLoginId(String loginId) throws Exception;
	User selectNickname(String nickname) throws Exception;
	void insertUser (User user) throws Exception;
	void updateLastLogin(String loginId) throws Exception;
	void updateMypage(User user) throws Exception;
	void updateProfile(User user) throws Exception;
	// 공개프로필
	Map<String, Object> publicProfile(Map<String, Object> param) throws Exception;
	// 공개프로필 팀
	List<Map<String, Object>> publicProfileTeams(Map<String, Object> param) throws Exception;
	
	//관리자 인원수 세기
	Long selectUserCnt() throws Exception;
}
