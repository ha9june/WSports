package dao;

import java.util.HashMap;
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
	public void updateStatusCancel(PersonalMatchParticipant personalMatchParticipant)
			throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.personalmatchparticipant.updateStatusCancel", personalMatchParticipant);
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
	public void updateAttendance(PersonalMatchParticipant personalMatchParticipant) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.personalmatchparticipant.updateAttendance", personalMatchParticipant);
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
	public PersonalMatchParticipant selectPersonalMatchParticipation(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalmatchparticipant.selectIsPersonalMatchParticipation", param);
		}	
	}

	@Override
	public List<User> selectPersonalMatchParticipantList(Long personalMatchId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatchparticipant.selectPersonalMatchParticipantList",personalMatchId);
		}	
	}

	@Override
	public List<Long> selectParticipantUserIds(Long personalMatchId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatchparticipant.selectParticipantUserIds", personalMatchId);
		}
	}

	@Override
	public User selectMyPersonalMatchParticipant(Long personalMatchId, Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("personalMatchId", personalMatchId);
			param.put("userId", userId);
			return sqlSession.selectOne("mapper.personalmatchparticipant.selectMyPersonalMatchParticipant", param);
		}catch(Exception e) {
			throw e;
		}
	}

	@Override
	public List<User> selectOtherPersonalMatchParticipantList(Long personalMatchId, Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("personalMatchId", personalMatchId);
			param.put("userId", userId);
			return sqlSession.selectList("mapper.personalmatchparticipant.selectOtherPersonalMatchParticipantList", param);
		}catch(Exception e) {
			throw e;
		}
	}



}
