package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.PersonalMatch;

public class PersonalMatchDaoImpl implements PersonalMatchDao {
	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();

	@Override
	public List<PersonalMatch> selectPersonalMatchList() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectPersonalMatchList");
		}
	}
	
	@Override
	public List<PersonalMatch> selectNormalPersonalMatchList(Integer startIndex) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectNormalPersonalMatchList",startIndex);
		}
	}
	
	@Override
	public List<PersonalMatch> selectMapPersonalMatchList(Map<String,Object> latlong) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectMapPersonalMatchList",latlong);
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
	public List<PersonalMatch> selectMyPagePersonalMatchsportList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectMyPagePersonalMatchsportList", param);
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
	public Map<String,Object> selectPersonalMatch(Integer personaMatchId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalmatch.selectPersonalMatch", personaMatchId);
		} catch (Exception e) {
			throw e;
		}

	}


}
