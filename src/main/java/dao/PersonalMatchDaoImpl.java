package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.PersonalMatch;

public class PersonalMatchDaoImpl implements PersonalMatchDao {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<PersonalMatch> selectPersonalMatchList() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectPersonalMatchList");
		}
	}

}
