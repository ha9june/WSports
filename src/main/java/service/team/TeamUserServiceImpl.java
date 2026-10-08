package service.team;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.TeamUserDao;
import dao.TeamUserDaoImpl;
import dto.TeamUser;
import dto.User;

public class TeamUserServiceImpl implements TeamUserService {
	
	TeamUserDao teamUserDao;
	
	public TeamUserServiceImpl() {
		teamUserDao = new TeamUserDaoImpl();
	}
	@Override
	public void makeTeamUser(TeamUser teamUser) throws Exception {
		teamUserDao.insertTeamUser(teamUser);
	}

	@Override
	public List<User> getTeamUserList(Long teamId) throws Exception {
		return teamUserDao.selectTeamUserList(teamId);
	}
	@Override
	public String getRole(Long teamId, Long userId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("userId", userId);
		return teamUserDao.selectRole(param);
	}
	@Override
	public List<Long> getTeamIdListByUserId(Long userId) throws Exception {
		return teamUserDao.selectTeamIdListByUserId(userId);
	}
	
	

}
