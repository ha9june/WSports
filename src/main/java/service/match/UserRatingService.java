package service.match;

import dto.UserRating;

public interface UserRatingService {
	//경기 후 평가 별점주기
	void saveUserRating(UserRating userRating) throws Exception;
}
