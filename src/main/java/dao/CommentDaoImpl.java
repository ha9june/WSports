package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

public class CommentDaoImpl implements CommentDao {

	@Override
	public List<Map<String, Object>> selectReviewCommentCnt() throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectList("mapper.comment.selectReviewCommentCnt");
		}
	}
}
