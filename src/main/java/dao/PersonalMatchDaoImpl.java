package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.PersonalMatch;
import util.MatchSearchInfo;

public class PersonalMatchDaoImpl implements PersonalMatchDao {

	@Override
	public List<PersonalMatch> selectNowPersonalMatchList(MatchSearchInfo searchInfo) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectNowPersonalMatchList", searchInfo);
		}
	}

	@Override
	public List<PersonalMatch> selectNormalPersonalMatchList(MatchSearchInfo searchInfo) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectNormalPersonalMatchList", searchInfo);
		}
	}

	@Override
	public List<PersonalMatch> selectMapPersonalMatchList(MatchSearchInfo searchInfo) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectMapPersonalMatchList", searchInfo);
		}
	}

	@Override
	public List<PersonalMatch> selectMyPagePersonalMatchList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectMyPagePersonalMatchList", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public Integer selectMyPagePersonalMatchCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalmatch.selectMyPagePersonalMatchCnt", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<PersonalMatch> selectMyPageCreatedPersonalMatchList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectMyPageCreatedPersonalMatchList", param);
		}
	}

	@Override
	public Integer selectMyPageCreatedPersonalMatchCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalmatch.selectMyPageCreatedPersonalMatchCnt", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<PersonalMatch> selectMyPageCreatedPersonalMatchsportList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			System.out.println("dao"+sqlSession.selectList("mapper.personalmatch.selectMyPageCreatedPersonalMatchsportList", param).toString());
			return sqlSession.selectList("mapper.personalmatch.selectMyPageCreatedPersonalMatchsportList", param);
			
		} catch (Exception e) {
			throw e;
		}
		
	
	}
	public PersonalMatch selectPersonalMatch(Long personaMatchId) throws Exception {

		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalmatch.selectPersonalMatch", personaMatchId);
		} catch (Exception e) {
			throw e;
		}

	}
	
	@Override
	public Long insertPersonalMatch(PersonalMatch personalMatch) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.personalmatch.insertPersonalMatch", personalMatch);
			sqlSession.commit();
			return personalMatch.getPersonalMatchId();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}
	
	@Override
	public Long updatePersonalMatch(PersonalMatch personalMatch) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.personalmatch.updatePersonalMatch", personalMatch);
			sqlSession.commit();
			return personalMatch.getPersonalMatchId();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}
	@Override
	public void deletePersonalMatch(Long personaMatchId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.personalmatch.deletePersonalMatch", personaMatchId);
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
	public List<String> selectMyPagePersonalMatchDates(Map<String, Object> param) throws Exception {
		try (SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return Session.selectList("mapper.personalmatch.selectMyPagePersonalMatchDates", param);
		}
	}

	@Override
	public List<String> selectMyPageCreatedPersonalMatchDates(Map<String, Object> param) throws Exception {
		try (SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return Session.selectList("mapper.personalmatch.selectMyPageCreatedPersonalMatchDates", param);
		}
	}

	
}
