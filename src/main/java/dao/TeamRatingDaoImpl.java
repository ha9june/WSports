package dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

public class TeamRatingDaoImpl implements TeamRatingDao {

	@Override
	public Double selectMyTeamRating(Long matchId, Long targetTeamId, Long userId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("matchId", matchId);
		param.put("targetTeamId", targetTeamId);
		param.put("userId", userId);
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.teamrating.selectMyTeamRating", param);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int updateTeamRating(Double score, Long matchId, Long targetTeamId, Long userId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("score", score);
		param.put("matchId", matchId);
		param.put("targetTeamId", targetTeamId);
		param.put("userId", userId);
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.teamrating.updateTeamRating", param);
			sqlSession.commit();
			return cnt;
		}catch(Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
	}

	@Override
	public void insertTeamRating(Long targetTeamId, Long userId, Double score, Long matchId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("targetTeamId", targetTeamId);
		param.put("userId", userId);
		param.put("score", score);
		param.put("matchId", matchId);
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.teamrating.insertTeamRating", param);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
	}

}
