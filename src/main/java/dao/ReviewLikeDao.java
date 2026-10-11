package dao;

import java.util.List;
import java.util.Map;

public interface ReviewLikeDao {
	List<Map<String,Object>> selectReviewLikeCnt()throws Exception;
	int insertReviewLike(Long reviewId, Long userId) throws Exception;
	int deleteReviewLike(Long reviewId, Long userId) throws Exception;
	int checkReviewLike(Long reviewId, Long userId)throws Exception;
}
