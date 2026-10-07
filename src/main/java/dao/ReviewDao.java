package dao;

import java.util.List;

import dto.Review;

public interface ReviewDao {
	 Long insertReview (Review review)throws Exception;
	 List<Review>selectReviewablePersonal(Long userId)throws Exception;
	 List<Review>selectReviewableTeam(Long userId)throws Exception;
	
}
