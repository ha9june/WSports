package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.User;

public class UserDaoImpl implements UserDao {

	@Override
	public User selectLoginId(String loginId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectLoginId", loginId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public User selectLoginUser(String loginId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectLoginUser", loginId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public User selectNickname(String nickname) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectNickname", nickname);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertUser(User user) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.user.insertUser", user);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}		
	}
	
	@Override
	public void updateLastLogin(String loginId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.user.updateLastLogin", loginId);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}	
	}

	@Override
	public void updateMypage(User user) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.user.updateMypage", user);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

	@Override
	public void updateProfile(User user) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.update("mapper.user.updateProfile", user);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}
	
	@Override
	public boolean withdraw(Long userId) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.user.withdraw", userId);
			sqlSession.commit();
			return cnt > 0;
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}
	
	@Override
	public boolean passwordChange(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			int cnt = sqlSession.update("mapper.user.passwordChange", param);
			sqlSession.commit();
			return cnt > 0;
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}
	
	// 공개프로필
	@Override
	public Map<String, Object> publicProfile(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.publicProfile", param);
		} catch(Exception e) {
			throw e;
		}
	}
	
	// 공개프로필 팀
	@Override
	public List<Map<String, Object>> publicProfileTeams(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.user.publicProfileTeams", param);
		} catch(Exception e) {
			throw e;
		}
	}
	
	//관리자 인원수 세기
	@Override
	public Long selectUserCnt() throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectUserCnt");
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public User selectUserAccountInfo(Long userId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectUserAccountInfo", userId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	// 마이페이지 결제 내역 페이징
	@Override
	public Long selectHistoryCount(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectHistoryCount", param);
		}
	}
	
	// 마이페이지 결제 내역 리스트
	@Override
	public List<Map<String, Object>> selectHistoryList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.user.selectHistoryList", param);
		}
	}
	
	// 마이페이지 결제 내역 탭수
	@Override
	public Map<String, Object> selectHistorySummary(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectHistorySummary", param);
		}
	}
			
	@Override
	public User selectUserByUserId(Long userId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectUserByUserId", userId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;

		}
	}

	@Override
	public void insertChangeUserPenalty(Map<String, Object> param) throws Exception {
		try (SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            s.insert("mapper.userpenalty.insertChangeUserPenalty", param);
            s.commit();
        }
    }

	@Override
	public int selectActivePenaltySum(Long userId) throws Exception {
		try (SqlSession s = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
            return s.selectOne("mapper.userpenalty.selectActivePenaltySum", userId);
        }
    }
}
