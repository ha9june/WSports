package dao;

import java.util.List;
import java.util.Map;

import dto.Comment;

public interface CommentDao {
	List<Map<String, Object>> selectReviewCommentCnt() throws Exception;
	List<Comment> selectReviewComments(Long reviewId);
	int insertComment(Map<String, Object> param) throws Exception;
	int deleteComment(Map<String, Object> param) throws Exception;
}
