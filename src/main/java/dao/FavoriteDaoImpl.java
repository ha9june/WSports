package dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

public class FavoriteDaoImpl implements FavoriteDao {

	@Override
	public void insertMyPageHeartMatch(Map<String, Object> param) throws Exception {
		SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			Session.insert("mapper.favorite.insertMyPageHeartMatch",param);
			Session.commit();
		}catch(Exception e) {
			e.printStackTrace();
			Session.rollback();
			throw e;
		}finally {
			Session.close();
		}
	}

	@Override
	public void deleteMyPageHeartMatch(Map<String, Object> param) throws Exception {
		SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			Session.delete("mapper.favorite.deleteMyPageHeartMatch",param);
			Session.commit();
		}catch(Exception e) {
			e.printStackTrace();
			Session.rollback();
			throw e;
		}finally {
			Session.close();
		}
	}

	@Override
	public Long selectMyPageHeartMatchExists(Map<String, Object> param) throws Exception {
		try(SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return Session.selectOne("mapper.favorite.selectMyPageHeartMatchExists",param);
		}
		
	}	

}
