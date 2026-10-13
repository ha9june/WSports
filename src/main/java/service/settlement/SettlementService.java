package service.settlement;

import java.util.List;
import java.util.Map;

import util.PageInfo;

public interface SettlementService {
	// 마이페이지 개인경기 정산 리스트
	List<Map<String,Object>> MypagePersonalSettlementList(PageInfo pageInfo, String keyword, Long userId, String settlementStatus, String period) throws Exception;
	public Map<String, Object> MypagePersonalSettlementSummary(String keyword, Long userId, String period) throws Exception;

	// 마이페이지 팀경기 정산 리스트
	List<Map<String,Object>> MypageTeamSettlementList(PageInfo pageInfo, String keyword, Long userId, String settlementStatus, String period, Long teamId) throws Exception;
	Map<String, Object> MypageTeamSettlementSummary(String keyword, Long userId, String period, Long teamId) throws Exception;
}
