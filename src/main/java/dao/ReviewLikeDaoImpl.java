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

	@Override
	public int insertReviewLike(Long reviewId, Long userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession(true)) {
			java.util.Map<String, Object> params = new java.util.HashMap<>();
			params.put("reviewId", reviewId);
			params.put("userId", userId);
			int result = session.insert("mapper.reviewlike.insertReviewLike", params);
			session.commit();
			return result;
		}
	}

	@Override
	public int deleteReviewLike(Long reviewId, Long userId) throws Exception {
		try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) { // 💡 true 제거
		    java.util.Map<String, Object> params = new java.util.HashMap<>();
		    params.put("reviewId", reviewId);
		    params.put("userId", userId);
		    
		    int result = session.delete("mapper.reviewlike.deleteReviewLike", params);
		    
		    session.commit(); 
		    
		    return result;
		}
	}

	@Override
	public int checkReviewLike(Long reviewId, Long userId) throws Exception {
		 try (SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		        java.util.Map<String, Object> param = new java.util.HashMap<>();
		        param.put("reviewId", reviewId);
		        param.put("userId", userId);
		        return session.selectOne("mapper.reviewlike.checkReviewLike", param);
		    }
		}
}
