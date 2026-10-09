package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.Comment;

public class CommentDaoImpl implements CommentDao {

	@Override
	public List<Map<String, Object>> selectReviewCommentCnt() throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectList("mapper.comment.selectReviewCommentCnt");
		}
	}

	@Override
	public List<Comment> selectReviewComments(Long reviewId) {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectList("mapper.comment.selectReviewComments",reviewId);
		}
	}
}
