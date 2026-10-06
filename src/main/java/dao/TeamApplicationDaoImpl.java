package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.TeamApplication;

public class TeamApplicationDaoImpl implements TeamApplicationDao {

	@Override
	public void insertTeamApplication(TeamApplication teamApplication) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.teamapplication.insertTeamApplication", teamApplication);
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public TeamApplication selectTeamApplication(Long teamId, Long userId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("userId", userId);
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teamapplication.selectTeamApplication", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public TeamApplication selectTeamApplicationByApplicationId(Long applicationId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teamapplication.selectTeamApplicationByApplicationId", applicationId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<dto.TeamApplication> selectTeamApplicationList(Long teamId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teamapplication.selectTeamApplicationList", teamId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int updateTeamApplicationApprove(Long teamId, Long applicationId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("applicationId", applicationId);
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.teamapplication.updateTeamApplicationApprove", param);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public int updateTeamApplicationReject(Long teamId, Long applicationId, String reason) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("applicationId", applicationId);
		param.put("reason", reason);
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.teamapplication.updateTeamApplicationReject", param);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public Integer selectMypageMyTeamCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teamapplication.selectMypageMyTeamCnt", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectMypageMyTeamList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teamapplication.selectMypageMyTeamList", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectMypageJoinedTeamList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teamapplication.selectMypageJoinedTeamList", param);
		} catch (Exception e) {
			throw e;
		}
}

	@Override
	public Integer selectMypageJoinedTeamCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
	        return sqlSession.selectOne("mapper.teamapplication.selectMypageJoinedTeamCnt", param);
	    }
	}

	@Override
	public int updateMypageMyTeam(Long userId, Long applicationId, String status) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("applicationId", applicationId);
		param.put("status", status);
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.teamapplication.updateMypageMyTeam", param);
			sqlSession.commit();
			return cnt;
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
			throw e;
		} finally {
			sqlSession.close();
		}
	}
}
