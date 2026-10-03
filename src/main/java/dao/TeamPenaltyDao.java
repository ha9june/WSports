package dao;

import java.util.List;
import java.util.Map;

public interface TeamPenaltyDao {
	//팀 정보 검색과 필터링에 맞는 팀수 세기 / 페이지 번호 보여주기
	Integer selectAdminTeamCnt(Map<String, Object> param) throws Exception;
	//한 페이지 팀 목록 / 팀 번호, 팀명
	List<Map<String, Object>> selectAdminTeamList(Map<String, Object> param) throws Exception;
	//팀 주장 닉네임
	String selectTeamCaptain(Long teamId) throws Exception;
	//팀원 수
	Integer selectTeamMemberCnt(Long teamId) throws Exception;
	//현재 패널티 점수와 최근 사유
	Map<String, Object> selectTeamLatestPenalty(Long teamId) throws Exception;
	//지금 정지중인 기록 수 / 1 이상이면 정지
	Integer selectTeamSuspension(Long teamId) throws Exception;
	//관리자 회원 상세정보
	List<Map<String, Object>> selectTeamDetailList(Long teamId) throws Exception;
}
