package dao;

import java.util.List;

import dto.TeamMatchParticipant;

public interface TeamMatchParticipantDao {
	int selectExpectedTeamMatchCnt(Long teamId) throws Exception;
	void insertTeamMatchParticipant(TeamMatchParticipant teamMatchParticipat) throws Exception;
	List<Long> selectTeamMatchParticipantTeamIdList(Long teamMatchId) throws Exception;
	List<TeamMatchParticipant> selectTeamMatchParticipantList(Long teamMatchId) throws Exception;
	int updateAttendance(Boolean attendance, Long teamMatchId, Long teamId) throws Exception;
}
