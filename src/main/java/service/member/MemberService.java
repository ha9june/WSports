package service.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Part;

import dto.User;

public interface MemberService {
	User mypageEdit (User user) throws Exception;
	User profileEdit (User user, String uploadPath, Part profileImage, boolean deleteImg) throws Exception;
	boolean withdraw (Long userId) throws Exception;
	boolean passwordChange (Long userId, String oldPassword, String newPassword) throws Exception;
	
	// 정지 중이면 안내 문구, 아니면 null
	String getSuspensionMessage(Long userId) throws Exception;	
	
	// 공개프로필
	Map<String, Object> publicProfile(Long userId) throws Exception;
	// 공개프로필 팀
	List<Map<String, Object>> publicProfileTeams(Long userId) throws Exception;
}
