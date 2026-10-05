package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.PersonalMatch;

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

	@Override
	public List<PersonalMatch> selectMyPageFavoriteList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.favorite.selectMyPageFavoriteList", param);
		}
	}

	@Override
	public Integer selectMyPageFavoriteCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.favorite.selectMyPageFavoriteCnt", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<String> selectMyPageFavoriteDates(Map<String, Object> param) throws Exception {
		   try (SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		        return Session.selectList("mapper.favorite.selectMyPageFavoriteDates", param);
		    }
		}
}