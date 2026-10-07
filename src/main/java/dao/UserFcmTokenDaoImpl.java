package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public int updateUserFcmToken(Long userId, String fcmToken) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("fcmToken", fcmToken);
		try {
			int cnt = sqlSession.insert("mapper.userfcmtoken.updateUserFcmToken", param);
			sqlSession.commit();
			return cnt;
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

}
