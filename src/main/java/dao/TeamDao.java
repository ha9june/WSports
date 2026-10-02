package dao;

import java.util.List;
import java.util.Map;

import dto.Team;

public interface TeamDao {
	Long insertTeam(Team team) throws Exception;
	List<Team> select12Team() throws Exception;
}
