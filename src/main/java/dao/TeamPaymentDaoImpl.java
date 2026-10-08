package dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.TeamMatch;
import dto.TeamPayment;

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
			return sqlSession.selectOne("mapper.teampayment.selectPeriodRevenueTeam", param);
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
	//결제 내역 삽입
	@Override
	public void insertTeamPaymentParticipant(TeamPayment teamPayment, Long userId, Long matchId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.teampayment.insertTeamPaymentParticipant", teamPayment);
			
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("matchId", matchId);
			param.put("paymentId", teamPayment.getPaymentId());
			sqlSession.insert("mapper.teampayment.insertPaidTeamParticipant", param);
			
			sqlSession.commit();
		} catch(Exception e) {
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}		
	}
	//결제내역 선택
	@Override
	public TeamPayment selectTeamPaymentHistory(String paymentKey) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.selectTeamPaymentHistory", paymentKey);
		}
	}
	//검증
	@Override
	public Integer selectTeamMatchTotalAmount(Integer matchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.selectTeamMatchTotalAmount", matchId);
		}
	}
	//경기정보 가져오기
	@Override
	public TeamMatch selectTeamPaymentMatch(String paymentKey) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.selectTeamPaymentMatch", paymentKey);
		}
	}
	//팀 경기 한건 조회
	@Override
	public TeamMatch selectTeamMatch(Long matchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.selectTeamMatch", matchId);
		}
	}
	//중복 참가 확인
	@Override
	public Integer selectTeamJoinCnt(Long userId, Long matchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("matchId", matchId);
			return sqlSession.selectOne("mapper.teampayment.selectTeamJoinCnt", param);
		}
	}
	

}
