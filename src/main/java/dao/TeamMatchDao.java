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
	int updateTeamMatch(TeamMatch teamMatch) throws Exception;
	List<Long> selectParticipantUserIds(Long teamMatchId) throws Exception;
	List<TeamMatch> selectTeamPostList(Long teamId, int offset, int size) throws Exception;
	int selectTeamPostCnt (Long teamId) throws Exception;
	int countActiveByTeam(Long teamId) throws Exception;
	int updateToDeleted(Long teamMatchId) throws Exception;
	
	//관리자 경기수 세기 - 팀
	Long selectMatchCntTeam() throws Exception;
	
	
	//스케줄러
	List<TeamMatch> selectExpiredRecruiting() throws Exception;
	int updateStatusToCancel(Long teamMatchId) throws Exception;
	List<TeamMatch> selectFinishedMatches() throws Exception;
	int updateStatusToFinished(Long teamMatchId) throws Exception;
	List<TeamMatch> selectFinishedWithoutSettlement() throws Exception;
	
	
	
}
