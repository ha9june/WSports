package dao;

import dto.TeamMatchParticipant;

public interface TeamMatchParticipantDao {
	int selectExpectedTeamMatchCnt(Long teamId) throws Exception;
	void insertTeamMatchParticipant(TeamMatchParticipant teamMatchParticipat) throws Exception;
}
