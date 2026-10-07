package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

public class ReviewLikeDaoImpl implements ReviewLikeDao {

	@Override
	public List<Map<String, Object>> selectReviewLikeCnt() throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return session.selectList("mapper.reviewlike.selectReviewLikeCnt");
		}
	}
}
