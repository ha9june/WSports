package service.team;

import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamPenaltyDao;
import dao.TeamPenaltyDaoImpl;

public class TeamPenaltyServiceImpl implements TeamPenaltyService {

	TeamDao teamDao;
	TeamPenaltyDao teamPenaltyDao;
	
	public TeamPenaltyServiceImpl() {
		teamPenaltyDao = new TeamPenaltyDaoImpl();
		teamDao = new TeamDaoImpl();
	}

	@Override
	public int getTeamPenaltyScore(Long teamId) throws Exception {
		if(teamDao.selectTeam(teamId) == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}
		return teamPenaltyDao.selectsTeamPenaltyScore(teamId);
	}

}
