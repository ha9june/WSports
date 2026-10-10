package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.MybatisSqlSessionFactory;

public class NoticeDaoImpl implements NoticeDao {
	//관리자 공지관리 개수 / 핀 기준 필터
	@Override
	public Integer selectAdminNoticeCnt(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notice.selectAdminNoticeCnt", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	// 관리자 공지 관리 리스트 10개씩
	@Override
	public List<Map<String, Object>> selectAdminNoticeList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notice.selectAdminNoticeList", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//공지 상세정보
	@Override
	public Map<String, Object> selectAdminNoticeDetail(Long noticeId) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notice.selectAdminNoticeDetail", noticeId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//공지 수정
	@Override
	public Integer updateAdminNotice(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notice.updateAdminNotice", param);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//핀변경
	@Override
	public Integer updateAdminNoticePin(Long noticeId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notice.updateAdminNoticePin", noticeId);
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//공지 작성
	@Override
	public Integer insertAdminNotice(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			int result = sqlSession.insert("mapper.notice.insertAdminNotice", param);
			sqlSession.commit();   // ← 이게 있어야 실제로 저장됨
			return result;
		}
	}
	
	@Override
	public Integer updateAdminNoticeDelete(Long noticeId) throws Exception {
		try (SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notice.updateAdminNoticeDelete", noticeId);
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
	}
	
	@Override
	public List<Map<String, Object>> selectPinnedNoticeList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notice.selectPinnedNoticeList",param);
		} catch(Exception e) {
			throw e;
		}
	}
	
	@Override
	public List<Map<String, Object>> selectNotPinnedNoticeList(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectList("mapper.notice.selectNotPinnedNoticeList",param);
		} catch(Exception e) {
			throw e;
		}
	}
	
	@Override
	public Integer selectNoticeCnt(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notice.selectNoticeCnt",param);
		} catch(Exception e) {
			throw e;
		}
	}
	
	@Override
	public Map<String, Object> selectDetailNotice(Map<String, Object> param) throws Exception {
		try(SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession()) {
			return sqlSession.selectOne("mapper.notice.selectDetailNotice", param);
		} catch(Exception e) {
			throw e;
		}
	}
}
