package service.admin;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import dto.TeamSettlement;

public interface AdminSettlementService {
	Integer getPersonalSettlementWait() throws Exception;
	Long getPersonalSettlementWaitMoney() throws Exception;
	List<Map<String, Object>> getPersonalSettlementWaitList() throws Exception;
	List<Map<String, Object>> getPersonalSettlementFinishList() throws Exception;
	List<Map<String, Object>> getPersonalSettlementDayList(LocalDate date) throws Exception;
	
	Integer getTeamSettlementWait() throws Exception;
	Long getTeamSettlementWaitMoney() throws Exception;
	List<Map<String, Object>> getTeamSettlementWaitList() throws Exception;
	List<Map<String, Object>> getTeamSettlementFinishList() throws Exception;
	List<Map<String, Object>> getTeamSettlementDayList(LocalDate date) throws Exception;
	
}
