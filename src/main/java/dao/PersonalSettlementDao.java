package dao;

import java.util.List;

import dto.PersonalSettlement;

public interface PersonalSettlementDao {
	List<PersonalSettlement> selectPersonalSettlementMatchList() throws Exception;
	
//	PersonalSettlement selectPersonalsettlementcount(String amount, String personalSettlement, String personalMatch,
//													 String personalMatchId, String matchDate, String settlementStatus
//													 ) throws Exception;
}
