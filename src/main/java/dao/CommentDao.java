package dao;

import java.util.List;
import java.util.Map;

public interface CommentDao {
	List<Map<String, Object>> selectReviewCommentCnt() throws Exception;

}
