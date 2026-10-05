package dao;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.TeamApplication;

public class TeamApplicationDaoImpl implements TeamApplicationDao {

	@Override
	public void insertTeamApplication(TeamApplication teamApplication) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.teamapplication.insertTeamApplication", teamApplication);
			sqlSession.commit();
		}catch(Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public TeamApplication selectTeamApplicaion(TeamApplication teamApplication) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.teamapplication.selectTeamApplicaion", teamApplication);
		}
	}

}
