package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.Team;

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
	public List<Team> select12Team() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.team.select12Team");
		}
	}

}
