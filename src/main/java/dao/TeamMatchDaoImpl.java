package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.TeamMatch;

public class TeamMatchDaoImpl implements TeamMatchDao {

	@Override
	public List<TeamMatch> selectTeamMatchList(Long teamId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()){
			return sqlSession.selectList("mapper.teammatch.selectTeamMatchList", teamId);
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<TeamMatch> selectMypageTeamMatchList(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.teammatch.selectMypageTeamMatchList", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public Integer selectMypageTeamMatchCnt(Map<String, Object> param) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teammatch.selectMypageTeamMatchCnt", param);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<String> selectMyPageTeamMatchDates(Map<String, Object> param) throws Exception {
		try (SqlSession Session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return Session.selectList("mapper.teammatch.selectMyPageTeamMatchDates", param);
		}
	}
	//관리자 경기수 세기 - 팀
	@Override
	public Long selectMatchCntTeam() throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.teammatch.selectMatchCntTeam");
		} catch (Exception e) {
			throw e;
		}
	}
}
