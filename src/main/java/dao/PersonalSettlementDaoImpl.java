package dao;

import java.time.LocalDate;
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
	public List<Map<String, Object>> selectPersonalSettlementDetail(int personalMatchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalsettlement.selectPersonalSettlementDetail", personalMatchId);
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

}
