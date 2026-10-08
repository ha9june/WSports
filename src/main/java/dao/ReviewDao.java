package dao;

import java.util.List;
import java.util.Map;

import dto.Review;

public interface ReviewDao {
	 Long insertReview (Review review)throws Exception;
	 List<Review>selectReviewablePersonal(Long userId)throws Exception;
	 List<Review>selectReviewableTeam(Long userId)throws Exception;
	 List<Review>selectReviewList(Long userId)throws Exception;
	 List<Map<String, Object>> selectMainReviewList(Map<String, Object> param) throws Exception;
	 Integer selectReviewListCnt(Map<String,Object>param)throws Exception;
	 List<Map<String, Object>> selectMypageReviewList(Map<String, Object> param)throws Exception;
	 Integer selectMypageReviewListCnt(Map<String,Object>param)throws Exception;
	 int updateMypageReview(Map<String, Object> param) throws Exception;
	 
}
