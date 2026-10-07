package service.team;

import java.util.List;

import javax.servlet.http.Part;

import dto.TeamMatch;

public interface TeamMatchService {
	
	List<TeamMatch> getTeamMatchList(Long teamId) throws Exception;
	Long makeTeamMatch(TeamMatch teamMatch, String realPath, List<Part> files) throws Exception;
	TeamMatch getTeamMatch(Long teamMatchId, Long userId) throws Exception;
	String getTeamMatchState(TeamMatch teamMatch) throws Exception;

}
