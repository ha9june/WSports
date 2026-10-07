package dao;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.PersonalMatchParticipant;

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
}
