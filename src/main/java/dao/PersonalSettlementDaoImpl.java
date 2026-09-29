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
	public List<Map<String, Object>> selectPersonalSettlementDayList(LocalDate date) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.personalsettlement.selectPersonalSettlementDayList", date);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
