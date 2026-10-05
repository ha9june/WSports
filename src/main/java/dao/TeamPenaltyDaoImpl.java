package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

public class TeamPenaltyDaoImpl implements TeamPenaltyDao {
	//팀 정보 검색과 필터링에 맞는 팀수 세기 / 페이지 번호 보여주기
	@Override
	public Integer selectAdminTeamCnt(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampenalty.selectAdminTeamCnt", param);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//한 페이지 팀 목록 / 팀 번호, 팀명
	@Override
	public List<Map<String, Object>> selectAdminTeamList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teampenalty.selectAdminTeamList", param);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//팀 주장 닉네임
	@Override
	public String selectTeamCaptain(Long teamId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampenalty.selectTeamCaptain", teamId);
		}
	}

	//팀원 수
	@Override
	public Integer selectTeamMemberCnt(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampenalty.selectTeamMemberCnt", teamId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//현재 패널티 점수와 최근 사유
	@Override
	public Map<String, Object> selectTeamLatestPenalty(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampenalty.selectTeamLatestPenalty", teamId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//지금 정지중인 기록 수 / 1 이상이면 정지
	@Override
	public Integer selectTeamSuspension(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampenalty.selectTeamSuspension", teamId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//팀 기본 정보
	@Override
	public Map<String, Object> selectTeamInfo(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampenalty.selectTeamInfo", teamId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//팀 페널티 리스트
	@Override
	public List<Map<String, Object>> selectTeamPenaltyList(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teampenalty.selectTeamPenaltyList", teamId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//관리자 벌점 조치
	@Override
	public void insertTeamPenalty(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			// 현재 점수 이어받기 (기록 없으면 0)
			Integer score = sqlSession.selectOne("mapper.teampenalty.selectTeamLatestPenalty", param);
			param.put("score", score == null ? 0 : score);

			sqlSession.insert("mapper.teampenalty.insertTeamPenalty", param);

			sqlSession.commit();
		} catch(Exception e) {
			sqlSession.rollback();
			throw e;
		}
		
	}
	//관리자 영구정지
	@Override
	public void insertTeamPermanentPenalty(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			try {
				// 현재 점수 그대로 이어받기 (기록이나 점수가 없으면 0)
				Map<String, Object> latest = sqlSession.selectOne("mapper.teampenalty.selectTeamLatestPenalty", param.get("teamId"));
				int score = (latest == null || latest.get("score") == null) ? 0 : ((Number) latest.get("score")).intValue();
				param.put("score", score);

				// 영구정지 기록 추가
				sqlSession.insert("mapper.teampenalty.insertTeamPermanentPenalty", param);

				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				throw e;
			}
		}
		
	}
	//관리자 페널티 조정
	@Override
	public void insertTeamChangePenalty(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			try {
				// 현재 점수 (기록 없으면 0) - 기존 쿼리 재사용
				Map<String, Object> latest = sqlSession.selectOne("mapper.teampenalty.selectTeamLatestPenalty", param.get("teamId"));
				int current = latest == null ? 0 : ((Number) latest.get("score")).intValue();

				// 조정 후 점수 (0 아래로는 안 내려가게)
				int change = (int) param.get("change");
				param.put("score", Math.max(0, current + change));

				sqlSession.insert("mapper.teampenalty.insertChangeTeamPenalty", param);
				sqlSession.commit();
			} catch (Exception e) {
				sqlSession.rollback();
				throw e;
			}
		}
	}
}
