package service.team;

public interface TeamRatingService {
	Double getMyTeamRating(Long matchId, Long targetTeamId, Long userId) throws Exception;
	int modifyTeamRating(Double score, Long matchId, Long targetTeamId, Long userId) throws Exception;
	void makeTeamRating(Long targetTeamId, Long userId, Double score, Long matchId) throws Exception;
}
