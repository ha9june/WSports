package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminMemberService {
	//리스트 뽑아오기,  pageInfo: 페이지 정보 / keyword : 회원 검색
	List<Map<String, Object>> getAdminMemberList(PageInfo pageInfo, String status, String keyword) throws Exception;
	
	//특정 회원 상세 정보
	List<Map<String, Object>> getAdminMemberDetailList(Long userId) throws Exception;
	
	//특정회원 신고 조치
	Map<String, Object> getUserPenalty() throws Exception;
}
