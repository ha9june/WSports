package dao;

import java.util.List;

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

}
