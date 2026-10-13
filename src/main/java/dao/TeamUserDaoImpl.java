package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.TeamUser;
import dto.User;

public class TeamUserDaoImpl implements TeamUserDao {

	@Override
	public void insertTeamUser(TeamUser teamUser) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.teamuser.insertTeamUser", teamUser);
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
	public List<User> selectTeamUserList(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teamuser.selectTeamUserList", teamId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public String selectRole(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectOne("mapper.teamuser.selectRole", param);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Long> selectTeamIdListByUserId(Long userId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teamuser.selectTeamIdListByUserId", userId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int updateTeamUserRole(Long teamId, Long userId, String role) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("userId", userId);
		param.put("role", role);
		try {
			int cnt = sqlSession.update("mapper.teamuser.updateTeamUserRole", param);
			sqlSession.commit();
			return cnt;
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}
	}

}
