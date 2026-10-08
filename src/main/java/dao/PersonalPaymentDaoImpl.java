package dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.PersonalMatch;
import dto.PersonalPayment;

public class PersonalPaymentDaoImpl implements PersonalPaymentDao {
	//총 매출
	@Override
	public Long totalRevenuePersonal() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.totalRevenuePersonal");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//총 수익
	@Override
	public Long totalProfitPersonal() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.totalProfitPersonal");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//이번달 월간 매출
	@Override
	public Long monthlyRevenuePersonal() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.monthlyRevenuePersonal");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//이번달 월간 수익
	@Override
	public Long monthlyProfitPersonal() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.monthlyProfitPersonal");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//이번달을 포함한 최근 6개월간의 월간 매출
	@Override
	public Long sixMonthlyRevenuePersonal(int n) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.sixMonthlyRevenuePersonal", n);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//이번달을 포함한 최근 6개월간의 월간 수익
	@Override
	public Long sixMonthlyProfitPersonal(int n) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.sixMonthlyProfitPersonal", n);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//기간 내 결제 건수
	@Override
	public Long selectPeriodPaymentCntPersonal(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.selectPeriodPaymentCntPersonal", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//기간 내 총 매출
	@Override
	public Long selectPeriodRevenuePersonal(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.selectPeriodRevenuePersonal", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//기간 내 총 수익
	@Override
	public Long selectPeriodProfitPersonal(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.selectPeriodProfitPersonal", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//결제내역 선택
	@Override
	public PersonalPayment selectPersonalPaymentHistory(String paymentKey) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.selectPersonalPaymentHistory", paymentKey);
		}
	}
	//검증
	@Override
	public Integer selectPersonalMatchTotalAmount(Integer matchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.selectPersonalMatchTotalAmount", matchId);
		}
	}
	//결제 내역 + 참가자 등록
	@Override
	public void insertPersonalPaymentParticipant(PersonalPayment personalPayment, Long userId, Long matchId) throws Exception {
		System.out.println("[결제저장] 호출됨 userId=" + userId + ", matchId=" + matchId);
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.personalpayment.insertPersonalPaymentHistory", personalPayment);
			System.out.println("[결제저장] 생성된 paymentId=" + personalPayment.getPaymentId());
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("matchId", matchId);
			param.put("paymentId", personalPayment.getPaymentId());
			sqlSession.insert("mapper.personalpayment.insertPaidParticipant", param);

			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
		
	}
	//경기정보 가져오기
	@Override
	public PersonalMatch selectPersonalPaymentMatch(String paymentKey) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.personalpayment.selectPersonalPaymentMatch", paymentKey);
		}
	}
	//중복 참가 확인
	@Override
	public Integer selectPersonalJoinCnt(Long userId, Long matchId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("matchId", matchId);
			return sqlSession.selectOne("mapper.personalpayment.selectJoinedCnt", param);
		}
	}

}
