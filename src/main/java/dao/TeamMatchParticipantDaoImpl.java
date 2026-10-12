package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public List<Long> selectTeamMatchParticipantTeamIdList(Long teamMatchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teammatchparticipant.selectTeamMatchParticipantTeamIdList", teamMatchId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<TeamMatchParticipant> selectTeamMatchParticipantList(Long teamMatchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teammatchparticipant.selectTeamMatchParticipantList", teamMatchId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int updateAttendance(Boolean attendance, Long teamMatchId, Long teamId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Map<String, Object> param = new HashMap<>();
		param.put("attendance", attendance);
		param.put("teamMatchId", teamMatchId);
		param.put("teamId", teamId);
		try{
			int cnt = sqlSession.update("mapper.teammatchparticipant.updateAttendance", param);
			sqlSession.commit();
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		}finally {
			sqlSession.close();
		}
	}

}
