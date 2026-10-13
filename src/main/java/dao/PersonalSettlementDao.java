package dao;

import java.util.List;
import java.util.Map;

import dto.PersonalSettlement;

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
	
	Long insertPersonalSettlement(PersonalSettlement ps) throws Exception;


	// 마이페이지 개인 경기 정산 리스트
	List<Map<String, Object>> selectMypagePersonalSettlementList(Map<String, Object> param) throws Exception;
	// 마이페이지 개인 경기 정산 리스트 페이징
	Integer selectMyPagePersonalSettlementCnt(Map<String, Object> param) throws Exception;
	// 마이페이지 개인 경기 정산 리스트 총내역 조회
	Map<String, Object> selectMyPagePersonalSettlementSummary(Long userId) throws Exception;
	// 마이페이지 개인 경기 정산 리스트 탭별 건수 조회
	Map<String, Object> selectMyPagePersonalSettlementTabCnt(Map<String, Object> param) throws Exception;
}
