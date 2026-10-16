package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.TeamMatch;
import dto.TeamSearchCondition;

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

	@Override
	public List<TeamMatch> selectMypageTeamMatchList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teammatch.selectMypageTeamMatchList", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public Integer selectMypageTeamMatchCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teammatch.selectMypageTeamMatchCnt", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<String> selectMyPageTeamMatchDates(Map<String, Object> param) throws Exception {
		try (SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return Session.selectList("mapper.teammatch.selectMyPageTeamMatchDates", param);
		}
	}


	@Override
	public Long insertTeamMatch(TeamMatch teamMatch) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			Long tmId = (long) sqlSession.insert("mapper.teammatch.insertTeamMatch", teamMatch);
			sqlSession.commit();
			return tmId;
		}catch(Exception e){
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		} 
	}

	//관리자 경기수 세기 - 팀
	@Override
	public Long selectMatchCntTeam() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teammatch.selectMatchCntTeam");
		} catch (Exception e) {
			throw e;

		}
	}

	@Override
	public TeamMatch selectTeamMatchUser(Long teamMatchId, Long userId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("teamMatchId", teamMatchId);
		param.put("userId", userId);
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.teammatch.selectTeamMatchUser", param);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public TeamMatch selectTeamMatchNotUser(Long teamMatchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.teammatch.selectTeamMatchNotUser", teamMatchId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	
	//스케줄러
	@Override
	public List<TeamMatch> selectExpiredRecruiting() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teammatch.selectExpiredRecruiting");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} 
	}

	@Override
	public int updateStatusToCancel(Long teamMatchId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.teammatch.updateStatusToCancel", teamMatchId);
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
	public List<TeamMatch> selectTeamMatchListForSearch(TeamSearchCondition teamSearchCondition) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teammatch.selectTeamMatchListForSearch", teamSearchCondition);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} 
	}

	@Override
	public int selectTeamMatchListForSearchCnt(TeamSearchCondition teamSearchCondition) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.teammatch.selectTeamMatchListForSearchCnt", teamSearchCondition);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} 
	}

	@Override
	public int updateStatusToClosed(Long teamMatchId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.teammatch.updateStatusToClosed", teamMatchId);
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
	public int updateTeamMatch(TeamMatch teamMatch) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.teammatch.updateTeamMatch", teamMatch);
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
	public List<TeamMatch> selectFinishedMatches() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teammatch.selectFinishedMatches");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} 
	}

	@Override
	public int updateStatusToFinished(Long teamMatchId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.teammatch.updateStatusToFinished", teamMatchId);
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
	public List<Long> selectParticipantUserIds(Long teamMatchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teammatch.selectParticipantUserIds", teamMatchId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} 
	}

	@Override
	public List<TeamMatch> selectTeamPostList(Long teamId, int offset, int size) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("offset", offset);
		param.put("size", size);
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teammatch.selectTeamPostList", param);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} 
	}

	@Override
	public int selectTeamPostCnt(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.teammatch.selectTeamPostCnt", teamId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		} 
	}

	@Override
	public List<TeamMatch> selectFinishedWithoutSettlement() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teammatch.selectFinishedWithoutSettlement");
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int countActiveByTeam(Long teamId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teammatch.countActiveByTeam", teamId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int updateToDeleted(Long teamMatchId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.teammatch.updateToDeleted", teamMatchId);
			sqlSession.commit();
			return cnt;
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
	}
}

