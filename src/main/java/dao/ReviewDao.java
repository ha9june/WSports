package dao;

import dto.Review;

public interface ReviewDao {
	Long insertReview (Review review)throws Exception;
	
}
