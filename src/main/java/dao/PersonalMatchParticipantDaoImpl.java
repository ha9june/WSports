package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.PersonalMatchParticipant;
import dto.User;

public class PersonalMatchParticipantDaoImpl implements PersonalMatchParticipantDao {

	@Override
	public void insertCreatorPersonalMatchParticipant(PersonalMatchParticipant personalMatchParticipant) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.personalmatchparticipant.insertCreatorPersonalMatchParticipant", personalMatchParticipant);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public void insertOtherPersonalMatchParticipant(PersonalMatchParticipant personalMatchParticipant)
			throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.personalmatchparticipant.insertOtherPersonalMatchParticipant", personalMatchParticipant);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Boolean selectisIsPersonalMatchParticipant(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalmatchparticipant.selectIsIsPersonalMatchParticipation", param);
		}	
	}

	@Override
	public List<User> selectPersonalMatchParticipantList(Long personalMatchId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatchparticipant.selectPersonalMatchParticipantList",personalMatchId);
		}	
	}
}
