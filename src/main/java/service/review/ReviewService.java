package service.review;

import dto.Review;

import java.util.List;

import javax.servlet.http.Part;
public interface ReviewService {
	Long writeReview(Review review,long userId, String realPath, List<Part> images)throws Exception; 
	List<Review>getReviewableMatches(long userId)throws Exception;
}
