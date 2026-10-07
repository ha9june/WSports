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
}
