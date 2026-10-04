package dao;

import java.util.List;

import dto.TeamMatch;

public interface TeamMatchDao {
	List<TeamMatch> selectTeamMatchList (Long teamId) throws Exception;
	
}
