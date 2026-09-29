package service.admin;

import java.util.List;

import dto.PersonalSettlement;

public interface AdminSettlementService {
	List<PersonalSettlement> getPersonalSettlement() throws Exception;
}
