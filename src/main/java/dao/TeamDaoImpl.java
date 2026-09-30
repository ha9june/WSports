package dao;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.Team;

public class TeamDaoImpl implements TeamDao {

	@Override
	public Integer insertTeam(Team team) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			Integer teamId = sqlSession.insert("mapper.team.insertTeam", team);
			sqlSession.commit();
			return teamId;
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

}
