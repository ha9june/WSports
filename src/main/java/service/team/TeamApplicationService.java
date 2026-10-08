package service.team;

import java.util.List;
import java.util.Map;

import dto.PersonalMatch;
import dto.TeamApplication;
import dto.User;
import util.PageInfo;

public interface TeamApplicationService {
	void application(Long teamId, User user, String message) throws Exception;
	TeamApplication getApplication(Long teamId, Long userId) throws Exception;
	TeamApplication getApplicationByApplicationId(Long applicationId) throws Exception;
	List<TeamApplication> getApplicationList(Long teamId) throws Exception;
	void approve(Long teamId, Long applicationId) throws Exception;
	void reject(Long teamId, Long applicationId, String reason) throws Exception;
	
	void MypageMyTeamCancelApplication(Long userId,Long applicationId)throws Exception;
	List<Map<String, Object>> MypageMyTeamList(PageInfo pageInfo, Long userId, String status, String sport) throws Exception;
	List<Map<String, Object>> MypageJoinedTeamList(PageInfo pageInfo, Long userId, String status, String sport) throws Exception;
	int MypageMyTeamJoinCancelApplication(Long userId,Long teamId)throws Exception;
}
