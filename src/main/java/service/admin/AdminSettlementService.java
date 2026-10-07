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
	Map<String, Object> getPersonalSettlementDetail(Long personalMatchId) throws Exception;
	List<Map<String, Object>> getPersonalSettlementList() throws Exception;
	void updatePersonalSettlement(Long settlementId, Long adminId) throws Exception;
	
	Integer getTeamSettlementWait() throws Exception;
	Long getTeamSettlementWaitMoney() throws Exception;
	List<Map<String, Object>> getTeamSettlementWaitList() throws Exception;
	List<Map<String, Object>> getTeamSettlementList() throws Exception;
	List<Map<String, Object>> getTeamSettlementFinishList() throws Exception;
	List<Map<String, Object>> getTeamSettlementDayList(LocalDate startDate, LocalDate endDate) throws Exception;
	Map<String, Object> getTeamSettlementDetail(Long teamMatchId) throws Exception;
	void updateTeamSettlement(Long settlementId, Long adminId) throws Exception;
	
}
