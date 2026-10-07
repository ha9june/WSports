package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminMemberService {
	//리스트 뽑아오기,  pageInfo: 페이지 정보 / keyword : 회원 검색
	List<Map<String, Object>> getAdminMemberList(PageInfo pageInfo, String status, String keyword) throws Exception;
	
	//특정 회원 상세 정보
	List<Map<String, Object>> getAdminMemberDetailList(Long userId) throws Exception;
	
	//회원 신고 조치 - 정지
	void AdminUserPenalty(Long userId, int days, String reason) throws Exception;
	
	//영구정지
	void AdminUserPermanentPenalty(Long userId, String reason) throws Exception;
	
	//회원 페널티 점수 조정
	void AdminChangeUserPenalty(Long userId, int change, String reason) throws Exception;
}
