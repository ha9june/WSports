package dao;

import java.util.List;
import java.util.Map;

public interface UserPenaltyDao {
	Integer selectAdminMemberCnt(Map<String, Object> param) throws Exception;
	List<Map<String, Object>> selectAdminMemberList(Map<String, Object> param) throws Exception;
	Map<String, Object> selectUserSuspension(Long userId) throws Exception;
	
	//관리자 회원 상세정보
	List<Map<String, Object>> selectAdminMemberDetailList(Long userId) throws Exception;
	
	//관리자 신고 조치
	void insertUserPenalty(Map<String, Object> param) throws Exception;
	
	//관리자 영구 정지
	void insertUserPermanentPenalty(Map<String, Object> param) throws Exception;
	//관리자 페널티 점수 부여
	void insertChangeUserPenalty(Map<String, Object> param) throws Exception;
	//스케줄러 : 자동 정지 대상 회원
	List<Map<String, Object>> selectAutoSuspendTargets() throws Exception;
	//스케줄러 : 자동 정지 부여 (기록 + 정지 상태, 한 트랜잭션)
	void insertAutoSuspend(Map<String, Object> param) throws Exception;
	//스케줄러 : 영구정지 검토 알림 대상 회원 (100점 이상)
	List<Map<String, Object>> selectReviewTargets() throws Exception;
	//스케줄러 : 관리자 회원 id 목록 (알림 받을 사람)
	List<Long> selectAdminUserIds() throws Exception;
}
