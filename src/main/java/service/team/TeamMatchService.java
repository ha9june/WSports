package service.team;

import java.util.List;

import javax.servlet.http.Part;

import dto.TeamMatch;
import dto.TeamSearchCondition;

public interface TeamMatchService {
	
	List<TeamMatch> getTeamMatchList(Long teamId) throws Exception;
	Long makeTeamMatch(TeamMatch teamMatch, String realPath, List<Part> files) throws Exception;
	TeamMatch getTeamMatchUser(Long teamMatchId, Long userId) throws Exception;
	TeamMatch getTeamMatchNotUser(Long teamMatchId) throws Exception;
	List<TeamMatch> getTeamMatchListSearch(TeamSearchCondition teamSearchCondition) throws Exception;
	int getTeamMatchListSearchCnt(TeamSearchCondition teamSearchCondition) throws Exception;
}
