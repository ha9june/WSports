package dao;

import java.time.LocalDate;
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
	public List<Map<String, Object>> selectTeamSettlementDayList(LocalDate date) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teamsettlement.selectTeamSettlementDayList", date);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
