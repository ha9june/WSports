package dao;

import java.util.List;
import java.util.Map;

public interface UserPenaltyDao {
	Integer selectAdminMemberCnt(Map<String, Object> param) throws Exception;
	List<Map<String, Object>> selectAdminMemberList(Map<String, Object> param) throws Exception;
	
	//관리자 회원 상세정보
	List<Map<String, Object>> selectAdminMemberDetailList(Long userId) throws Exception;
	
	//관리자 신고 조치
	void insertUserPenalty(Map<String, Object> param) throws Exception;
	
	//관리자 영구 정지
	void insertUserPermanentPenalty(Map<String, Object> param) throws Exception;
	//관리자 페널티 점수 부여
	void insertChangeUserPenalty(Map<String, Object> param) throws Exception;
}
