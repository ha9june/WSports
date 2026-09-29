package dao;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.User;

public class UserDaoImpl implements UserDao {

	@Override
	public void insertUser(User user) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public User selectUser(String loginId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectUser", loginId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
