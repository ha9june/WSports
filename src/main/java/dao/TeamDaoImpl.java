package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.Team;
import dto.TeamSearchCondition;

public class TeamDaoImpl implements TeamDao {

	@Override
	public Long insertTeam(Team team) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.team.insertTeam", team);
			sqlSession.commit();
			return team.getTeamId();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public List<Team> selectTeamList(TeamSearchCondition condition) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.team.selectTeamList", condition);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int selectTeamlistCnt(TeamSearchCondition condition) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.team.selectTeamListCnt", condition);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Team selectTeam(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.team.selectTeam", teamId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Long selectTeamCaptainUserId(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.team.selectTeamCaptainUserId", teamId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int updateTeam(Team team) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int number = sqlSession.update("mapper.team.updateTeam", team);
			sqlSession.commit();
			return number;
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}
	//관리자 팀 수 세기
	@Override
	public Long selectTeamCnt() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.team.selectTeamCnt");
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Team> selectTeamInfoByUserManager(Long userId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.team.selectTeamInfoByUserManager", userId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Team> selectNowTeamList(TeamSearchCondition condition) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.team.selectNowTeamList");
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Team> selectTeamInfoByUserManagerSport(Long userId, String sport) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("sport", sport);
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.team.selectTeamInfoByUserManagerSport", param);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
