package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.TeamSettlement;

public class TeamSettlementDaoImpl implements TeamSettlementDao {

	@Override
	public Integer selectTeamSettlementWait() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try{
			return sqlSession.selectOne("mapper.teamsettlement.selectTeamSettlementWait");
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Long selectTeamSettlementWaitMoney() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try{
			return sqlSession.selectOne("mapper.teamsettlement.selectTeamSettlementWaitMoney");
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectTeamSettlementWaitList() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teamsettlement.selectTeamSettlementWaitList");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectTeamSettlementFinishList() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teamsettlement.selectTeamSettlementFinishList");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectTeamSettlementDayList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teamsettlement.selectTeamSettlementDayList", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Map<String, Object> selectTeamSettlementDetail(Long teamMatchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teamsettlement.selectTeamSettlementDetail", teamMatchId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectTeamSettlementList() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teamsettlement.selectTeamSettlementList");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Integer updateTeamSettlement(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Integer result = sqlSession.update("mapper.teamsettlement.updateTeamSettlement", param);
			sqlSession.commit();
			return result;
		} 
	}

	@Override
	public Map<String, Object> selectTeamSettlementUser(Long settlementId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teamsettlement.selectTeamSettlementUser", settlementId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	// 마이페이지 개인 경기 정산 리스트
	@Override
	public List<Map<String, Object>> selectMypageTeamSettlementList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teamsettlement.selectMyPageTeamSettlementList", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;	
		}
	}

	// 마이페이지 개인 경기 정산 리스트 페이징
	@Override
	public Integer selectMyPageTeamSettlementCnt(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teamsettlement.selectMyPageTeamSettlementCnt", param);
		} catch(Exception e) {
			throw e;
		}
	}

	// 마이페이지 개인 경기 정산 리스트 총내역 조회
	@Override
	public Map<String, Object> selectMyPageTeamSettlementSummary(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.teamsettlement.selectMyPageTeamSettlementSummary", userId);
	    }
	}

	// 마이페이지 개인 경기 정산 리스트 탭별 건수 조회
	@Override
	public Map<String, Object> selectMyPageTeamSettlementTabCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.teamsettlement.selectMyPageTeamSettlementTabCnt", param);
	    }
	}

	// 마이페이지 팀 경기 정산 리스트 팀선택 조회
	@Override
	public List<Map<String, Object>> selectMyPageTeamList(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectList("mapper.teamsettlement.selectMyPageTeamList", userId);
	    }
	}

	@Override
	public int insertTeamSettlement(TeamSettlement teamsettlement) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.insert("mapper.teamsettlement.insertHostSettlement", teamsettlement);
			sqlSession.commit();
			return cnt;
		}catch(Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
	}

}

