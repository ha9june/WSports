package dao;

import java.util.List;
import java.util.Map;

import dto.TeamApplication;

public interface TeamApplicationDao {
	void insertTeamApplication(TeamApplication teamApplication) throws Exception;
	TeamApplication selectTeamApplication(Long teamId, Long userId) throws Exception;
	TeamApplication selectTeamApplicationByApplicationId(Long applicationId) throws Exception;
	List<TeamApplication> selectTeamApplicationList(Long teamId) throws Exception;
	int updateTeamApplicationApprove(Long teamId, Long applicationId) throws Exception;
	int updateTeamApplicationReject(Long teamId, Long applicationId, String reason) throws Exception;
	
	int updateMypageMyTeam(Long userId,Long applicationId,String status)throws Exception;
	List<Map<String, Object>> selectMypageJoinedTeamList(Map<String, Object> param) throws Exception;
	Integer selectMypageJoinedTeamCnt(Map<String, Object> param) throws Exception;
	List<Map<String, Object>> selectMypageMyTeamList(Map<String, Object> param) throws Exception;
	Integer selectMypageMyTeamCnt(Map<String,Object>param)throws Exception;
	int updateMypageJoinTeam(Long userId,Long teamId)throws Exception;
}
