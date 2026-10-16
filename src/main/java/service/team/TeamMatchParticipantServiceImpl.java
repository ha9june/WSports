package service.team;

import java.util.List;

import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamMatchParticipantDao;
import dao.TeamMatchParticipantDaoImpl;
import dto.TeamMatchParticipant;

public class TeamMatchParticipantServiceImpl implements TeamMatchParticipantService {
	
	TeamMatchParticipantDao teamMatchParticipantDao;
	TeamDao teamDao;
	
	public TeamMatchParticipantServiceImpl() {
		teamMatchParticipantDao = new TeamMatchParticipantDaoImpl();
		teamDao = new TeamDaoImpl();
	}

	@Override
	public int getExpectedTeamMatchCnt(Long teamId) throws Exception {
		if(teamDao.selectTeam(teamId) == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}
		return teamMatchParticipantDao.selectExpectedTeamMatchCnt(teamId);
	}

	@Override
	public void maekTeamMatchParticipant(TeamMatchParticipant teamMatchParticipant) throws Exception {
		teamMatchParticipantDao.insertTeamMatchParticipant(teamMatchParticipant);	
	}

	@Override
	public List<Long> getTeamMatchParticipantIdList(Long teamMatchId) throws Exception {
		return teamMatchParticipantDao.selectTeamMatchParticipantTeamIdList(teamMatchId);
	}

	@Override
	public List<TeamMatchParticipant> getTeamMatchParticipantList(Long teamMatchId) throws Exception {
		return teamMatchParticipantDao.selectTeamMatchParticipantList(teamMatchId);
	}

	@Override
	public int modifyAttendance(Boolean attendance, Long teamMatchId, Long teamId) throws Exception {
		return teamMatchParticipantDao.updateAttendance(attendance, teamMatchId, teamId);
	}

	@Override
	public int modifyTeamMatchParticipantToCancel(String cancelReason, Long teamMatchId, Long userId) throws Exception {
		return teamMatchParticipantDao.updateTeamParticipantToCancel(cancelReason, teamMatchId, userId);
	}

}
