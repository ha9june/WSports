package service.review;

import dto.Review;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Part;

import dao.ReviewLikeDao;
public interface ReviewService {
	Long writeReview(Review review,long userId, String realPath, List<Part> images)throws Exception; 
	List<Review>getReviewableMatches(long userId)throws Exception;
	List<Review>getReviewList(Long userId)throws Exception;
	
	List<Review> getNowReviewList() throws Exception;
}
