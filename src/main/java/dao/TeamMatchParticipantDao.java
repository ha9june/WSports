package dao;

public interface TeamMatchParticipantDao {
	int selectExpectedTeamMatchCnt(Long teamId) throws Exception;
}
