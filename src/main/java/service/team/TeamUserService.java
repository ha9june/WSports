package service.team;

import java.util.List;

import dto.TeamUser;
import dto.User;

public interface TeamUserService {
	void makeTeamUser(TeamUser teamUser) throws Exception;
	List<User> getTeamUserList(Long teamId) throws Exception;
	String getRole(Long teamId, Long userId) throws Exception;
}	
