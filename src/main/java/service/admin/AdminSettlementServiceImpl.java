package service.admin;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.PersonalSettlementDao;
import dao.PersonalSettlementDaoImpl;
import dao.TeamSettlementDao;
import dao.TeamSettlementDaoImpl;

import dto.TeamSettlement;

public class AdminSettlementServiceImpl implements AdminSettlementService {
	private PersonalSettlementDao personalsettlementDao;
	private TeamSettlementDao teamsettlementDao;
	
	public AdminSettlementServiceImpl() {
		this.personalsettlementDao = new PersonalSettlementDaoImpl();
		this.teamsettlementDao = new TeamSettlementDaoImpl();
	}
	
	
	@Override
	public Integer getPersonalSettlementWait() throws Exception {
		return personalsettlementDao.selectPersonalSettlementWait();
	}
	
	@Override
	public Long getPersonalSettlementWaitMoney() throws Exception {
		return personalsettlementDao.selectPersonalSettlementWaitMoney();
	}
	
	@Override
	public List<Map<String, Object>> getPersonalSettlementWaitList() throws Exception {
		return personalsettlementDao.selectPersonalSettlementWaitList();
	}
	
	@Override
	public List<Map<String, Object>> getPersonalSettlementFinishList() throws Exception {
		return personalsettlementDao.selectPersonalSettlementFinishList();
	}
	
	@Override
	public List<Map<String, Object>> getPersonalSettlementDayList(LocalDate date) throws Exception {
		return personalsettlementDao.selectPersonalSettlementDayList(date);
	}

	@Override
	public List<Map<String, Object>> getPersonalSettlementDetail(int personalMatchId) throws Exception {
		return personalsettlementDao.selectPersonalSettlementDetail(personalMatchId);
	}
	
	@Override
	public List<Map<String, Object>> getPersonalSettlementList() throws Exception {
		return personalsettlementDao.selectPersonalSettlementList();
	}

	@Override
	public int updatePersonalSettlement(long settlementId, Long adminId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("settlementId", settlementId);
		param.put("adminId", adminId);
		return personalsettlementDao.updatePersonalSettlement(param);
	}

////////////////////////////////////////////////////////////////////////////////////////

	@Override
	public Integer getTeamSettlementWait() throws Exception {
		return teamsettlementDao.selectTeamSettlementWait();
	}
	
	@Override
	public Long getTeamSettlementWaitMoney() throws Exception {
		return teamsettlementDao.selectTeamSettlementWaitMoney();	
	}
	
	@Override
	public List<Map<String, Object>> getTeamSettlementWaitList() throws Exception {
		return teamsettlementDao.selectTeamSettlementWaitList();
	}

	@Override
	public List<Map<String, Object>> getTeamSettlementFinishList() throws Exception {
		return teamsettlementDao.selectTeamSettlementFinishList();
	}

	@Override
	public List<Map<String, Object>> getTeamSettlementDayList(LocalDate date) throws Exception {
		return teamsettlementDao.selectTeamSettlementDayList(date);
	}

	@Override
	public List<Map<String, Object>> getTeamSettlementDetail(int teamMatchId) throws Exception {
		return teamsettlementDao.selectTeamSettlementDetail(teamMatchId);
	}


	@Override
	public List<Map<String, Object>> getTeamSettlementList() throws Exception {
		return teamsettlementDao.selectTeamSettlementList();
	}



	@Override
	public int updateTeamSettlement(long settlementId, Long adminId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("settlementId", settlementId);
		param.put("adminId", adminId);
		return teamsettlementDao.updateTeamSettlement(param);
	}

}
