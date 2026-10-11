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
	public void insertTeamPaymentParticipant(TeamPayment teamPayment, Long userId, Long matchId, Long teamId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.teampayment.insertTeamPaymentHistory", teamPayment);
			
			Map<String, Object> param = new HashMap<>();
			param.put("userId", userId);
			param.put("matchId", matchId);
			param.put("paymentId", teamPayment.getPaymentId());
			param.put("teamId", teamId);
			sqlSession.insert("mapper.teampayment.insertTeamPaymentParticipant", param);
			
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
	//팀 경기 모집자 제목
	@Override
	public Map<String, Object> selectTeamMatchWriter(Long matchId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampayment.selectTeamMatchWriter", matchId);
		}

	}
	//환불 대상 조회 : 본인 결제만 조회
	@Override
	public Map<String, Object> selectTeamRefundTarget(String paymentKey, Long userId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("paymentKey", paymentKey);
			param.put("userId", userId);
			return sqlSession.selectOne("mapper.teampayment.selectTeamRefundTarget", param);
		}
	}
	//상대 팀 결제 수 : 모집 팀 환불 가능 여부 판단용
	@Override
	public Integer selectTeamOpponentCnt(Long matchId, Long hostTeamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			Map<String, Object> param = new HashMap<>();
			param.put("matchId", matchId);
			param.put("hostTeamId", hostTeamId);
			return sqlSession.selectOne("mapper.teampayment.selectTeamOpponentCnt", param);
		}
	}
	//환불 처리 : 결제 취소+참가취소+경기 상태 변경
	@Override
	public void updateTeamRefund(Map<String, Object> param, boolean isHost) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			try {
				//결제취소
				sqlSession.update("mapper.teampayment.updateTeamPaymentCanceled", param);
				//참가취소
				sqlSession.update("mapper.teampayment.updateTeamParticipantCanceled", param.get("paymentId"));
				//경기상태변경 : 모집 팀이면 경기 취소, 상대 팀이면 다시 모집 중
				if (isHost) {
					sqlSession.update("mapper.teampayment.updateTeamMatchCanceled", param.get("matchId"));
				} else {
					sqlSession.update("mapper.teampayment.updateTeamMatchReopen", param.get("matchId"));
				}
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				throw e;
			}
		}
		
	}
}
