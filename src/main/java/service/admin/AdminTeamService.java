package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminTeamService {
	List<Map<String, Object>> getAdminTeamList(PageInfo pageInfo, String status, String keyword) throws Exception;
	//주장 닉네임
	Map<String, Object> getTeamCaptain(Long teamId) throws Exception;
	//팀원 수
	Integer getTeamMemberCnt(Long teamId) throws Exception;
	//팀 개수
	Integer getAdminTeamCnt(String status) throws Exception;
	//지금 정지중인가?
	Integer getTeamSuspention(Long teamId) throws Exception;
	Map<String, Object> getTeamInfo(Long teamId) throws Exception;
	//팀 페널티 리스트
	List<Map<String, Object>> getTeamPenaltyList(Long teamId) throws Exception;
	
	//회원 신고 조치 - 정지
	void AdminTeamPenalty(Long teamId, int days, String reason) throws Exception;
	//팀 페널티 점수 조정
	void AdminChangeTeamPenalty(Long teamId, int change, String reason) throws Exception;
	//영구정지
	void AdminTeamPermanentPenalty(Long teamId, String reason) throws Exception;
}
