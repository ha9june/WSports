package dao;

import java.util.List;

import dto.Team;
import dto.TeamSearchCondition;

public interface TeamDao {
	Long insertTeam(Team team) throws Exception;
	List<Team> selectTeamList(TeamSearchCondition condition) throws Exception;
	int selectTeamlistCnt(TeamSearchCondition condition) throws Exception;
	Team selectTeam (Long teamId) throws Exception;
	Long selectTeamCaptainUserId(Long teamId) throws Exception;
	int updateTeam(Team team) throws Exception;
	
}
