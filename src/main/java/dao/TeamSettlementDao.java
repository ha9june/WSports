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
}
