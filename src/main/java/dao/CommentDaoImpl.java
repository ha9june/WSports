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

	@Override
	public int insertComment(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.insert("mapper.comment.insertComment", param);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int deleteComment(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.comment.deleteComment", param);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}
}
