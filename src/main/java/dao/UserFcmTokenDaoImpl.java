package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.UserFcmToken;

public class UserFcmTokenDaoImpl implements UserFcmTokenDao {

	@Override
	public void upsertUserFcmToken(UserFcmToken userFcmToken) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.userfcmtoken.upsertUserFcmToken", userFcmToken);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<String> selectUserFcmToken(Long userId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.userfcmtoken.selectUserFcmToken", userId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
