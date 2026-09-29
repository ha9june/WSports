package service.admin;

import java.util.List;

import dao.PersonalSettlementDao;
import dao.PersonalSettlementDaoImpl;
import dto.PersonalSettlement;

public class AdminSettlementServiceImpl implements AdminSettlementService {
	private PersonalSettlementDao personalsettlementDao;
	
	public AdminSettlementServiceImpl() {
		this.personalsettlementDao = new PersonalSettlementDaoImpl();
	}
	
	@Override
	public List<PersonalSettlement> getPersonalSettlement() throws Exception {
		return personalsettlementDao.selectPersonalSettlementMatchList();
	}
	
}
