package dao;

import java.util.List;
import java.util.Map;

public interface ReviewLikeDao {
	List<Map<String,Object>> selectReviewLikeCnt()throws Exception;
}
