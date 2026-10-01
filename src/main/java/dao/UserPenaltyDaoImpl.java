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

}
