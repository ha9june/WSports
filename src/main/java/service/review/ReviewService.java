package service.review;

import dto.Comment;
import dto.Review;
import util.PageInfo;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Part;

import dao.ReviewLikeDao;
public interface ReviewService {
	Long writeReview(Review review,long userId, String realPath, List<Part> images)throws Exception; 
	List<Review>getReviewableMatches(long userId)throws Exception;
	List<Review>getReviewList(Long userId)throws Exception;
	
	Review getReviewDetail(Long reviewId)throws Exception;
	List<Comment> getCommentList(Long reviewId)throws Exception;
	List<Review> getNowReviewList() throws Exception;
	List<Map<String, Object>> selectMainReviewList(PageInfo pageInfo, String status, String keyword) throws Exception;
	List<Map<String, Object>> getMypageReviewList(PageInfo pageInfo, Long userId)throws Exception;
	int modifyMypageReview(Long userId, Long reviewId, String title, String content, String image) throws Exception;
	int deleteMypageReview(Long userId, Long reviewId) throws Exception; 
	String fileUpload(String uploadPath, Part file) throws Exception;
	Map<String,Object>selectMyReview(Long userId,Long reviewId)throws Exception;
	boolean addReviewLike(Long reviewId, Long userId) throws Exception;
	boolean removeReviewLike(Long reviewId, Long userId) throws Exception;
	List<Map<String, Object>> getReviewLikeCnt() throws Exception;
	boolean checkReviewLike(Long reviewId, Long userId) throws Exception;
	boolean writeComment(Long reviewId, Long userId, String content) throws Exception;
	boolean removeComment(Long commentId, Long userId) throws Exception;
	boolean removeReviewByAdmin(Long reviewId) throws Exception;
}
