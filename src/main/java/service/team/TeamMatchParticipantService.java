package service.team;

import dto.TeamMatchParticipant;

public interface TeamMatchParticipantService {
	int getExpectedTeamMatchCnt(Long teamId) throws Exception;
	void maekTeamMatchParticipant(TeamMatchParticipant teamMatchParticipant) throws Exception;
}
