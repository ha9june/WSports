package dao;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public interface PersonalSettlementDao {
	Integer selectPersonalSettlementWait() throws Exception;
	Long selectPersonalSettlementWaitMoney() throws Exception;
	List<Map<String, Object>> selectPersonalSettlementWaitList() throws Exception;
	List<Map<String, Object>> selectPersonalSettlementFinishList() throws Exception;
	List<Map<String, Object>> selectPersonalSettlementDayList(LocalDate date) throws Exception;
	List<Map<String, Object>> selectPersonalSettlementDetail(int personalMatchId) throws Exception;
	List<Map<String, Object>> selectPersonalSettlementList() throws Exception;
	Integer updatePersonalSettlement(Map<String, Object> param) throws Exception;
	
	
}