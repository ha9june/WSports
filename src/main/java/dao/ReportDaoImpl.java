package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

public class ReportDaoImpl implements ReportDao {
	//관리자 신고관리 리스트
	@Override
	public List<Map<String, Object>> selectAdminReportList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.report.selectAdminReportList", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//관리자 신고관리 개수
	@Override
	public Integer selectAdminReportCnt(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.report.selectAdminReportCnt", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//관리자 신고 답변
	@Override
	public Integer updateAdminReportAnswer(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.report.updateAdminReportAnswer", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//특정 신고 상세
	@Override
	public Map<String, Object> selectAdminReportDetail(Long reportId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.report.selectAdminReportDetail", reportId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
