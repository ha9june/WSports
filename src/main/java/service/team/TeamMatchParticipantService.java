package service.team;

import java.util.List;

import dto.TeamMatchParticipant;

public interface TeamMatchParticipantService {
	int getExpectedTeamMatchCnt(Long teamId) throws Exception;
	void maekTeamMatchParticipant(TeamMatchParticipant teamMatchParticipant) throws Exception;
	List<Long> getTeamMatchParticipantIdList(Long teamMatchId) throws Exception;
}
