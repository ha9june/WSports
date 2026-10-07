package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;
import dto.Inquiry;

public class InquiryDaoImpl implements InquiryDao {
	//관리자 문의관리 개수
	@Override
	public Integer selectAdminInquiryCnt(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.inquiry.selectAdminInquiryCnt", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//관리자 문의관리 리스트
	@Override
	public List<Map<String, Object>> selectAdminInquiryList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.inquiry.selectAdminInquiryList", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//관리자 문의 답변
	@Override
	public Integer updateAdminInquiryAnswer(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.inquiry.updateAdminInquiryAnswer", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//관리자 특정 문의 상세
	@Override
	public Map<String, Object> selectAdminInquiryDetail(Long inquiryId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.inquiry.selectAdminInquiryDetail", inquiryId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	@Override
	public void insertInquiry(Inquiry inquiry) throws Exception {
		SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
			sqlSession.insert("mapper.inquiry.insertInquiry", inquiry);
			sqlSession.commit();
		} catch(Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
			throw e;
		} finally {
			sqlSession.close();
		}		
	}

}
