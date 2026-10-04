package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.TeamMatch;

public class TeamMatchDaoImpl implements TeamMatchDao {

	@Override
	public List<TeamMatch> selectTeamMatchList(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teammatch.selectTeamMatchList", teamId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
