package service.team;

import java.util.List;

import dto.TeamMatch;

public interface TeamMatchService {
	List<TeamMatch> getTeamMatchList(Long teamId) throws Exception;
}
