package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.Review;

public class ReviewDaoImpl implements ReviewDao {

	public ReviewDaoImpl() {

	}

	@Override
	public Long insertReview(Review review) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.review.insertReview", review);
			sqlSession.commit();
			return review.getReviewId();
		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Review> selectReviewablePersonal(Long userId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		return sqlSession.selectList("mapper.review.selectReviewablePersonal", userId);
	}

	@Override
	public List<Review> selectReviewableTeam(Long userId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		return sqlSession.selectList("mapper.review.selectReviewableTeam", userId);
	}

	@Override
	public List<Review> selectReviewList(Long userId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.review.selectReviewList", userId);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Map<String, Object>> selectMainReviewList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.review.selectMainReviewList", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Integer selectReviewListCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.review.selectReviewListCnt", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectMypageReviewList(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			return sqlSession.selectList("mapper.review.selectMypageReviewList", param);
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Integer selectMypageReviewListCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.review.selectMypageReviewListCnt", param);
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}

	@Override
	public int updateMypageReview(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	    try {
	        int cnt = sqlSession.update("mapper.review.updateMypageReview", param);
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
	public Map<String, Object> selectMyReview(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.review.selectMyReview", param);
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
	}
	public List<Review> selectNowReviewList() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	    try {
	        return sqlSession.selectList("mapper.review.selectNowReviewList");
	    } finally {
	        sqlSession.close();
	    }
	}
}
