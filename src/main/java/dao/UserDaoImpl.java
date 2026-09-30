package dao;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.User;

public class UserDaoImpl implements UserDao {

	@Override
	public User selectLoginId(String loginId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectLoginId", loginId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public User selectNickname(String nickname) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectNickname", nickname);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertUser(User user) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.user.insertUser", user);
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
