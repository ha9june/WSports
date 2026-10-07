package dao;

import java.util.List;
import java.util.Map;

public interface PersonalSettlementDao {
	Integer selectPersonalSettlementWait() throws Exception;
	Long selectPersonalSettlementWaitMoney() throws Exception;
	List<Map<String, Object>> selectPersonalSettlementWaitList() throws Exception;
	List<Map<String, Object>> selectPersonalSettlementFinishList() throws Exception;
	List<Map<String, Object>> selectPersonalSettlementDayList(Map<String, Object> param) throws Exception;
	
	Map<String, Object> selectPersonalSettlementDetail(Long personalMatchId) throws Exception;
	List<Map<String, Object>> selectPersonalSettlementList() throws Exception;
	Integer updatePersonalSettlement(Map<String, Object> param) throws Exception;
	//정산번호로 회원/경기 정보 조회(알림용)
	Map<String, Object> selectPersonalSettlementUser(Long settlementId) throws Exception;
}