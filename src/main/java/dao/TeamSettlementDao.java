package dao;

import java.util.List;
import java.util.Map;

public interface TeamSettlementDao {
	Integer selectTeamSettlementWait() throws Exception;
	Long selectTeamSettlementWaitMoney() throws Exception;
	List<Map<String, Object>> selectTeamSettlementWaitList() throws Exception;
	List<Map<String, Object>> selectTeamSettlementFinishList() throws Exception;
	List<Map<String, Object>> selectTeamSettlementDayList(Map<String, Object> param) throws Exception;
	
	Map<String, Object> selectTeamSettlementDetail(Long teamMatchId) throws Exception;
	List<Map<String, Object>> selectTeamSettlementList() throws Exception;
	Integer updateTeamSettlement(Map<String, Object> param) throws Exception;
	//정산 번호로 회원/경기 정보 조회
	Map<String, Object> selectTeamSettlementUser(Long settlementId) throws Exception;
	
	// 마이페이지 팀 경기 정산 리스트
	List<Map<String, Object>> selectMypageTeamSettlementList(Map<String, Object> param) throws Exception;
	// 마이페이지 팀 경기 정산 리스트 페이징
	Integer selectMyPageTeamSettlementCnt(Map<String, Object> param) throws Exception;
	// 마이페이지 팀 경기 정산 리스트 총내역 조회
	Map<String, Object> selectMyPageTeamSettlementSummary(Long userId) throws Exception;
	// 마이페이지 팀 경기 정산 리스트 탭별 건수 조회
	Map<String, Object> selectMyPageTeamSettlementTabCnt(Map<String, Object> param) throws Exception;	
	// 마이페이지 팀 경기 정산 리스트 팀선택 조회
	List<Map<String, Object>> selectMyPageTeamList(Long userId) throws Exception;
}
