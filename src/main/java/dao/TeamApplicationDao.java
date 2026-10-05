package dao;

import java.util.List;

import dto.TeamApplication;

public interface TeamApplicationDao {
	void insertTeamApplication(TeamApplication teamApplication) throws Exception;
	TeamApplication selectTeamApplication(TeamApplication teamApplication) throws Exception;
	List<TeamApplication> selectTeamApplicationList(Long teamId) throws Exception;
}
