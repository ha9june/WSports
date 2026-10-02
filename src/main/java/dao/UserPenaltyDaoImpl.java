package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

public class UserPenaltyDaoImpl implements UserPenaltyDao {

	@Override
	public List<Map<String, Object>> selectAdminMemberList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.user.selectAdminMemberList", param);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Integer selectAdminMemberCnt(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.user.selectAdminMemberCnt", param);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	//관리자 회원 상세정보
	@Override
	public List<Map<String, Object>> selectAdminMemberDetailList(Long userId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.user.selectAdminMemberDetailList", userId);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	//관리자 신고 조치
	@Override
	public void insertUserPenalty(Map<String, Object> param) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			// 현재 점수 이어받기 (기록 없으면 0)
			Integer score = sqlSession.selectOne("mapper.user.selectLatestScore", param);
			param.put("score", score == null ? 0 : score);

			sqlSession.insert("mapper.user.insertUserPenalty", param);
			sqlSession.update("mapper.user.updateUserSuspended", param);
			sqlSession.commit();
		} catch(Exception e) {
			sqlSession.rollback();
			throw e;
		}
	}

}
