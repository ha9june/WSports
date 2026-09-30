package dao;


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
			
		}catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		}finally {
			sqlSession.close();
		}
			return review.getUserId();
	}

}
