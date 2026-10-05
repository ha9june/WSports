package service.team;

import java.util.List;

import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dto.TeamMatch;

public class TeamMatchServiceImpl implements TeamMatchService {
	
	TeamMatchDao teamMatchDao;
	
	public TeamMatchServiceImpl() {
		teamMatchDao = new TeamMatchDaoImpl();
	}

	@Override
	public List<TeamMatch> getTeamMatchList(Long teamId) throws Exception {
		return teamMatchDao.selectTeamMatchList(teamId);
	}
	
}
