package dao;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

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

}
