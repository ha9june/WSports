package dao;

public interface TeamRatingDao {
	Double selectMyTeamRating(Long matchId, Long targetTeamId, Long userId) throws Exception;
	int updateTeamRating(Double score, Long matchId, Long targetTeamId, Long userId) throws Exception;
	void insertTeamRating(Long targetTeamId, Long userId, Double score, Long matchId) throws Exception;
}
