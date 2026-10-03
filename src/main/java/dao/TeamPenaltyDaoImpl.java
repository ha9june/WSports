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
	
	//관리자 회원 상세정보
	@Override
	public List<Map<String, Object>> selectTeamDetailList(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teampenalty.selectTeamDetailList", teamId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
