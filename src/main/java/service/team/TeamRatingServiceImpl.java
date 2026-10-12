package service.team;

import dao.TeamRatingDao;
import dao.TeamRatingDaoImpl;

public class TeamRatingServiceImpl implements TeamRatingService {
	
	TeamRatingDao teamRatingDao;
	
	public TeamRatingServiceImpl() {
		teamRatingDao = new TeamRatingDaoImpl();
	}

	@Override
	public Double getMyTeamRating(Long matchId, Long targetTeamId, Long userId) throws Exception {
		return teamRatingDao.selectMyTeamRating(matchId, targetTeamId, userId);
	}

	@Override
	public int modifyTeamRating(Double score, Long matchId, Long targetTeamId, Long userId) throws Exception {
		return teamRatingDao.updateTeamRating(score, matchId, targetTeamId, userId);
	}

	@Override
	public void makeTeamRating(Long targetTeamId, Long userId, Double score, Long matchId) throws Exception {
		teamRatingDao.insertTeamRating(targetTeamId, userId, score, matchId);
	}

}
