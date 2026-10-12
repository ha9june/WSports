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


	public PersonalMatch selectPersonalMatch(PersonalMatch personalMatch) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalmatch.selectPersonalMatch", personalMatch);
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
	public Long updatePersonalMatchStatue(PersonalMatch personalMatch) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.personalmatch.updatePersonalMatchStatus", personalMatch);
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

	
	//관리자 경기수 세기 - 개인
	@Override
	public Long selectMatchCntPersonal() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalmatch.selectMatchCntPersonal");
		} catch (Exception e) {
			throw e;
		}
	}
	// 스케줄러 : 마감 지난 최소 인원 미달 경기
	@Override
	public List<PersonalMatch> selectExpiredUnderMin() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalmatch.selectExpiredUnderMin");
		}
	}
	// 스케줄러 : 최소 인원 미달 경기 취소
	@Override
	public int updateStatusToUnderMinCancel(Long matchId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.personalmatch.updateStatusToUnderMinCancel", matchId);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}
/*
	@Override
	public List<PersonalMatch> selectExpiredRecruiting() throws Exception {
		try (SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return Session.selectList("mapper.personalmatch.selectExpiredRecruiting");
		}
	}

	@Override
	public List<PersonalMatch> selectFinishedMatches() throws Exception {
		try (SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return Session.selectList("mapper.personalmatch.selectFinishedMatches");
		}
	}

	@Override
	public int updateStatusToNoOpponentCancel(Long personalMatchId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.personalmatch.updateStatusToNoOpponentCancel", personalMatchId);
			sqlSession.commit();
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
	}

	@Override
	public int updateStatusToFinished(Long personalMatchId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.personalmatch.updateStatusToFinished", personalMatchId);
			sqlSession.commit();
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
	}

*/

}
