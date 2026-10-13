package dao;

import java.util.Map;

import dto.UserRating;

public interface UserRatingDao {
	int selectUserRatingCount(UserRating userRating) throws Exception;
	void insertUserRating(UserRating userRating) throws Exception;
 	void updateUserRating(UserRating userRating) throws Exception;
 	Map<String, Object> selectRatingSummaryByUserId(long userId) throws Exception;
}
