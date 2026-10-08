package dao;


import java.util.List;

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
			sqlSession.insert("mapper.review.insertReview",review);
			sqlSession.commit();
			return review.getReviewId();
		}catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		}finally {
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
	public List<Review> selectNowReviewList() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	    try {
	        return sqlSession.selectList("mapper.review.selectNowReviewList");
	    } finally {
	        sqlSession.close();
	    }
	}
}
