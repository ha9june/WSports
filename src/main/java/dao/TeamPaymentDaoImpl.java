package dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

public class TeamPaymentDaoImpl implements TeamPaymentDao {
	//총 매출
	@Override
	public Long totalRevenueTeam() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.totalRevenueTeam");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//총 수익
	@Override
	public Long totalProfitTeam() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.totalProfitTeam");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//이번달 월간 매출
	@Override
	public Long monthlyRevenueTeam() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.monthlyRevenueTeam");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//이번달 월간 수익
	@Override
	public Long monthlyProfitTeam() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.monthlyProfitTeam");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//이번달을 포함한 최근 6개월간의 월간 매출
	@Override
	public Long sixMonthlyRevenueTeam(int n) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.sixMonthlyRevenueTeam",n);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//이번달을 포함한 최근 6개월간의 월간 수익
	@Override
	public Long sixMonthlyProfitTeam(int n) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.sixMonthlyProfitTeam",n);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//기간 내 결제 건수
	@Override
	public Long selectPeriodPaymentCntTeam(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.selectPeriodPaymentCntTeam", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//기간 내 총 매출
	@Override
	public Long selectPeriodRevenueTeam(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.totalRevenueTeam", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//기간 내 총 수익
	@Override
	public Long selectPeriodProfitTeam(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.selectPeriodProfitTeam", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	

}
