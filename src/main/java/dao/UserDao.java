package dao;

import java.util.List;
import java.util.Map;

import dto.User;

public interface UserDao {

	User selectLoginId(String loginId) throws Exception;
	User selectLoginUser(String loginId) throws Exception;
	User selectNickname(String nickname) throws Exception;
	void insertUser (User user) throws Exception;
	void updateLastLogin(String loginId) throws Exception;
	void updateMypage(User user) throws Exception;
	void updateProfile(User user) throws Exception;
	boolean withdraw(Long userId) throws Exception;
	boolean passwordChange(Map<String, Object> param) throws Exception;
	// 공개프로필
	Map<String, Object> publicProfile(Map<String, Object> param) throws Exception;
	// 공개프로필 팀
	List<Map<String, Object>> publicProfileTeams(Map<String, Object> param) throws Exception;
	
	//관리자 인원수 세기
	Long selectUserCnt() throws Exception;
	
	// 마이페이지 결제 내역
	Long selectHistoryCount(Map<String, Object> param) throws Exception;
	// 마이페이지 결제 내역 리스트
	List<Map<String, Object>> selectHistoryList(Map<String, Object> param) throws Exception;
	// 마이페이지 결제 내역 탭수
	Map<String, Object> selectHistorySummary(Map<String, Object> param) throws Exception;

	User selectUserByUserId(Long userId) throws Exception;

}
