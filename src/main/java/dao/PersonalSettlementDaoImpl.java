package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.PersonalSettlement;

public class PersonalSettlementDaoImpl implements PersonalSettlementDao {
	@Override
	public Integer selectPersonalSettlementWait() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try{
			return sqlSession.selectOne("mapper.personalsettlement.selectPersonalSettlementWait");
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
		
	}

	@Override
	public Long selectPersonalSettlementWaitMoney() throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try{
			return sqlSession.selectOne("mapper.personalsettlement.selectPersonalSettlementWaitMoney");
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}finally {
			sqlSession.close();
		}
	}
	
	@Override
	public List<Map<String, Object>> selectPersonalSettlementWaitList() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalsettlement.selectPersonalSettlementWaitList");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public List<Map<String, Object>> selectPersonalSettlementFinishList() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalsettlement.selectPersonalSettlementFinishList");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectPersonalSettlementDayList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalsettlement.selectPersonalSettlementDayList", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Map<String, Object> selectPersonalSettlementDetail(Long personalMatchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalsettlement.selectPersonalSettlementDetail", personalMatchId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectPersonalSettlementList() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalsettlement.selectPersonalSettlementList");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Integer updatePersonalSettlement(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Integer result = sqlSession.update("mapper.personalsettlement.updatePersonalSettlement", param);
			sqlSession.commit();
			return result;
		} 
	}

	@Override
	public Map<String, Object> selectPersonalSettlementUser(Long settlementId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalsettlement.selectPersonalSettlementUser", settlementId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Long insertPersonalSettlement(PersonalSettlement ps) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.personalsettlement.insertPersonalSettlement", ps);
			sqlSession.commit();
			return ps.getSettlementId();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
		
	}

	// 마이페이지 개인 경기 정산 리스트
	@Override
	public List<Map<String, Object>> selectMypagePersonalSettlementList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalsettlement.selectMyPagePersonalSettlementList", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;	
		}
	}

	// 마이페이지 개인 경기 정산 리스트 페이징
	@Override
	public Integer selectMyPagePersonalSettlementCnt(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalsettlement.selectMyPagePersonalSettlementCnt", param);
		} catch(Exception e) {
			throw e;
		}
	}

	// 마이페이지 개인 경기 정산 리스트 총내역 조회
	@Override
	public Map<String, Object> selectMyPagePersonalSettlementSummary(Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		     return sqlSession.selectOne("mapper.personalsettlement.selectMyPagePersonalSettlementSummary", userId);
		}
	}

	// 마이페이지 개인 경기 정산 리스트 탭별 건수 조회
	@Override
	public Map<String, Object> selectMyPagePersonalSettlementTabCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
		     return sqlSession.selectOne("mapper.personalsettlement.selectMyPagePersonalSettlementTabCnt", param);
		}
	}
}
