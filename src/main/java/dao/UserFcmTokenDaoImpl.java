package dao;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.UserFcmToken;

public class UserFcmTokenDaoImpl implements UserFcmTokenDao {

	@Override
	public void upsertFcmToken(UserFcmToken userFcmToken) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.userfcmtoken.upsertFcmToken", userFcmToken);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

}
