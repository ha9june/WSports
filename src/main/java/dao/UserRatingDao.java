package dao;

import dto.UserRating;

public interface UserRatingDao {
	int selectUserRatingCount(UserRating userRating) throws Exception;
	void insertUserRating(UserRating userRating) throws Exception;
 	void updateUserRating(UserRating userRating) throws Exception;
}
