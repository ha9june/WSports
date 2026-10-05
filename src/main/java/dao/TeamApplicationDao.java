package dao;

import dto.TeamApplication;

public interface TeamApplicationDao {
	void insertTeamApplication(TeamApplication teamApplication) throws Exception;
	TeamApplication selectTeamApplicaion(TeamApplication teamApplication) throws Exception;
}
