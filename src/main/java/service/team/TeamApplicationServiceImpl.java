package service.team;

import dao.TeamApplicationDao;
import dao.TeamApplicationDaoImpl;
import dao.TeamDao;
import dao.TeamDaoImpl;
import dto.TeamApplication;

public class TeamApplicationServiceImpl implements TeamApplicationService {
	
	TeamDao teamDao;
	TeamApplicationDao teamApplicationDao;
	
	public TeamApplicationServiceImpl() {
		teamDao = new TeamDaoImpl();
		teamApplicationDao = new TeamApplicationDaoImpl();
	}

	@Override
	public void application(Long teamId, Long userId, String message) throws Exception {
		TeamApplication teamApplication = new TeamApplication();
		teamApplication.setTeamId(teamId);
		teamApplication.setUserId(userId);
		teamApplication.setMessage(message);
		if(teamDao.selectTeam(teamId) == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}
		if(teamApplicationDao.selectTeamApplicaion(teamApplication) != null) {
			throw new Exception ("이미 신청중인 팀 입니다.");
		}
		teamApplicationDao.insertTeamApplication(teamApplication);

	}

	@Override
	public TeamApplication getApplication(Long teamId, Long userId) throws Exception {
		TeamApplication teamApplication = new TeamApplication();
		teamApplication.setTeamId(teamId);
		teamApplication.setUserId(userId);
		return teamApplicationDao.selectTeamApplicaion(teamApplication);
	}

}
