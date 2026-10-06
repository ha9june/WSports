package dao;

import java.util.List;
import java.util.Map;

public interface NoticeDao {
	//관리자 공지관리 개수 / 핀 기준 필터
	Integer selectAdminNoticeCnt(Map<String, Object> param) throws Exception;
	// 관리자 공지 관리 리스트 10개씩
	List<Map<String, Object>> selectAdminNoticeList(Map<String, Object> param) throws Exception;
	//공지 상세정보
	Map<String, Object> selectAdminNoticeDetail(Long noticeId) throws Exception;
	//공지 수정
	Integer updateAdminNotice(Map<String, Object> param) throws Exception;
	//핀 변경
	Integer updateAdminNoticePin(Long noticeId) throws Exception;
	//공지 작성
	Integer insertAdminNotice(Map<String, Object> param) throws Exception;
	//공지 삭제
	Integer updateAdminNoticeDelete(Long noticeId) throws Exception;
}
