package dao;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface TeamSettlementDao {
	Integer selectTeamSettlementWait() throws Exception;
	Long selectTeamSettlementWaitMoney() throws Exception;
	List<Map<String, Object>> selectTeamSettlementWaitList() throws Exception;
	List<Map<String, Object>> selectTeamSettlementFinishList() throws Exception;
	List<Map<String, Object>> selectTeamSettlementDayList(LocalDate date) throws Exception;
	List<Map<String, Object>> selectTeamSettlementDetail(int teamMatchId) throws Exception;
	List<Map<String, Object>> selectTeamSettlementList() throws Exception;
	Integer updateTeamSettlement(Map<String, Object> param) throws Exception;
}
