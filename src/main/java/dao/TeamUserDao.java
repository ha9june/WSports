package dao;

import java.util.List;
import java.util.Map;

import dto.TeamUser;
import dto.User;

public interface TeamUserDao {
	void insertTeamUser(TeamUser teamUser) throws Exception;
	List<User> selectTeamUserList(Long teamId) throws Exception;
	String selectRole(Map<String, Object> param) throws Exception;
}
