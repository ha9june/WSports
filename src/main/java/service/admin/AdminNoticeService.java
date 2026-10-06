package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminNoticeService {
	//관리자 공지 리스트
	List<Map<String, Object>> getAdminNoticeList(PageInfo pageInfo, String status) throws Exception;
	//공지 상세정보
	Map<String, Object> getAdminNoticeDetailList(Long noticeId) throws Exception;
	//관리자 공지 작성
	void AdminNoticeWrite(String title, String content, Boolean isPinned, Long adminId, String type) throws Exception;
	//핀 변경
	void AdminNoticePin(Long noticeId) throws Exception;
	//삭제
	void AdminNoticeDelete(Long noticeId) throws Exception;
	//관리자 공지 수정
	void getAdminNoticeModify(Long noticeId, String title, String content, String type) throws Exception;
}
