package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminTeamService {
	List<Map<String, Object>> getAdminTeamList(PageInfo pageInfo, String status, String keyword) throws Exception;
	//팀 개수
	Integer getAdminTeamCnt(String status) throws Exception;
	//특정 팀 상세 정보
	List<Map<String, Object>> getTeamDetailList(Long teamId) throws Exception;
}
