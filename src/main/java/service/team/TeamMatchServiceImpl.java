package service.team;

import java.util.List;

import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dto.TeamMatch;

public class TeamMatchServiceImpl implements TeamMatchService {
	
	TeamMatchDao teamMatchDao;
	TeamDao teamDao;
	
	public TeamMatchServiceImpl() {
		teamMatchDao = new TeamMatchDaoImpl();
		teamDao = new TeamDaoImpl();
	}

	@Override
	public List<TeamMatch> getTeamMatchList(Long teamId) throws Exception {
		if(teamDao.selectTeam(teamId) == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}
		return teamMatchDao.selectTeamMatchList(teamId);
	}
	
}
