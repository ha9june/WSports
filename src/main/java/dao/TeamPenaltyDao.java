package dao;

import java.util.List;
import java.util.Map;

public interface TeamPenaltyDao {
	//팀 정보 검색과 필터링에 맞는 팀수 세기 / 페이지 번호 보여주기
	Integer selectAdminTeamCnt(Map<String, Object> param) throws Exception;
	//한 페이지 팀 목록 / 팀 번호, 팀명
	List<Map<String, Object>> selectAdminTeamList(Map<String, Object> param) throws Exception;
	//팀 주장 닉네임
	Map<String, Object> selectTeamCaptain(Long teamId) throws Exception;
	//팀원 수
	Integer selectTeamMemberCnt(Long teamId) throws Exception;
	//현재 패널티 점수와 최근 사유
	Map<String, Object> selectTeamLatestPenalty(Long teamId) throws Exception;
	//지금 정지중인 기록 수 / 1 이상이면 정지
	Integer selectTeamSuspension(Long teamId) throws Exception;
	//팀 기본 정보
	Map<String, Object> selectTeamInfo(Long teamId) throws Exception;
	//팀 페널티 리스트
	List<Map<String, Object>> selectTeamPenaltyList(Long teamId) throws Exception;
	//관리자 정지 조치
	void insertTeamPenalty(Map<String, Object> param) throws Exception;
	//관리자 페널티 점수 부여
	void insertTeamChangePenalty(Map<String, Object> param) throws Exception;
	//관리자 영구 정지
	void insertTeamPermanentPenalty(Map<String, Object> param) throws Exception;
	//팀 패널티 점수 구하기
	int selectsTeamPenaltyScore(Long teamId) throws Exception;
	//스케줄러 : 자동 정지 대상 회원
	List<Map<String, Object>> selectAutoTeamSuspendTargets() throws Exception;
	//스케줄러 : 자동 정지 부여 (기록 + 정지 상태, 한 트랜잭션)
	void insertAutoTeamSuspend(Map<String, Object> param) throws Exception;
	//스케줄러 : 영구정지 검토 알림 대상 팀 (100점 이상)
	List<Map<String, Object>> selectTeamReviewTargets() throws Exception;
}
