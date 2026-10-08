package dao;

import java.util.List;
import java.util.Map;

import dto.TeamMatch;
import dto.TeamSearchCondition;

public interface TeamMatchDao {
	List<TeamMatch> selectTeamMatchList (Long teamId) throws Exception;
	List<TeamMatch>selectMypageTeamMatchList(Map<String,Object>param)throws Exception;
	Integer selectMypageTeamMatchCnt(Map<String,Object>param)throws Exception;
	List<String>selectMyPageTeamMatchDates(Map<String,Object>param)throws Exception;

	Long insertTeamMatch(TeamMatch teamMatch) throws Exception;
	TeamMatch selectTeamMatchUser(Long teamMatchId, Long userId) throws Exception;
	TeamMatch selectTeamMatchNotUser(Long teamMatchId) throws Exception;
	
	List<TeamMatch> selectTeamMatchListForSearch(TeamSearchCondition teamSearchCondition) throws Exception;
	int selectTeamMatchListForSearchCnt(TeamSearchCondition teamSearchCondition) throws Exception;
	int updateStatusToClosed(Long teamMatchId) throws Exception;
	

	//관리자 경기수 세기 - 팀
	Long selectMatchCntTeam() throws Exception;
	
	
	//스케줄러
	List<TeamMatch> selectExpiredRecruiting() throws Exception;
	int updateStatusToNoOpponentCancel(Long teamMatchId) throws Exception;

	
	
	
}
