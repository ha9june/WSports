package dao;

import java.util.List;
import java.util.Map;

import dto.Team;
import dto.TeamSearchCondition;

public interface TeamDao {
	Long insertTeam(Team team) throws Exception;
	List<Team> selectTeamList(TeamSearchCondition condition) throws Exception;
	int selectTeamlistCnt(TeamSearchCondition condition) throws Exception;
	Team selectTeam (Long teamId) throws Exception;
	Long selectTeamCaptainUserId(Long teamId) throws Exception;
	int updateTeam(Team team) throws Exception;

	List<Team> selectTeamInfoByUserManager(Long userId) throws Exception;
	List<Team> selectTeamInfoByUserManagerSport(Long userId, String sport) throws Exception;

	//관리자 팀수 세기
	Long selectTeamCnt() throws Exception;
	
	//메인 경기 추천 팀
	List<Team> selectNowTeamList(TeamSearchCondition condition) throws Exception;

}
