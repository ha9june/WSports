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
	List<Map<String, Object>> getPersonalSettlementDayList(LocalDate startDate, LocalDate endDate) throws Exception;
	List<Map<String, Object>> getPersonalSettlementDetail(int personalMatchId) throws Exception;
	List<Map<String, Object>> getPersonalSettlementList() throws Exception;
	int updatePersonalSettlement(long settlementId, Long adminId) throws Exception;
	
	Integer getTeamSettlementWait() throws Exception;
	Long getTeamSettlementWaitMoney() throws Exception;
	List<Map<String, Object>> getTeamSettlementWaitList() throws Exception;
	List<Map<String, Object>> getTeamSettlementList() throws Exception;
	List<Map<String, Object>> getTeamSettlementFinishList() throws Exception;
	List<Map<String, Object>> getTeamSettlementDayList(LocalDate startDate, LocalDate endDate) throws Exception;
	List<Map<String, Object>> getTeamSettlementDetail(int teamMatchId) throws Exception;
	int updateTeamSettlement(long settlementId, Long adminId) throws Exception;
	
}
