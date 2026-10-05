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
}
