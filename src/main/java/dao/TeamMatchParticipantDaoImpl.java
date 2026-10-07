package dao;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.TeamMatchParticipant;

public class TeamMatchParticipantDaoImpl implements TeamMatchParticipantDao {

	@Override
	public int selectExpectedTeamMatchCnt(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.teammatchparticipant.selectExpectedTeamMatchCnt", teamId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertTeamMatchParticipant(TeamMatchParticipant teamMatchParticipat) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try{
			sqlSession.insert("mapper.teammatchparticipant.insertTeamMatchParticipant", teamMatchParticipat);
			sqlSession.commit();
		}catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		}finally {
			sqlSession.close();
		}
		
	}

}
