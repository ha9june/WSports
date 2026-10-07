package service.admin;

import java.util.HashMap;
import java.util.Map;

import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dao.PersonalPaymentDao;
import dao.PersonalPaymentDaoImpl;
import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dao.TeamPaymentDao;
import dao.TeamPaymentDaoImpl;
import dao.UserDao;
import dao.UserDaoImpl;

public class AdminSideBarServiceImpl implements AdminSideBarService {
	private UserDao userDao;
	private TeamDao teamDao;
	private PersonalMatchDao personalmatchDao;
	private TeamMatchDao teammatchDao;
	private PersonalPaymentDao personalPaymentDao;
	private TeamPaymentDao teamPaymentDao;
	
	public AdminSideBarServiceImpl() {
		this.userDao = new UserDaoImpl();
		this.teamDao = new TeamDaoImpl();
		this.personalmatchDao = new PersonalMatchDaoImpl();
		this.teammatchDao = new TeamMatchDaoImpl();
		this.personalPaymentDao = new PersonalPaymentDaoImpl();
		this.teamPaymentDao = new TeamPaymentDaoImpl();
	}
	@Override
	public Map<String, Object> getAdminStats() throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("usercnt", userDao.selectUserCnt());
		param.put("teamcnt", teamDao.selectTeamCnt());
		param.put("matchcnt", personalmatchDao.selectMatchCntPersonal() 
				+ teammatchDao.selectMatchCntTeam());
		param.put("profit", personalPaymentDao.totalProfitPersonal()
				+ teamPaymentDao.totalProfitTeam());
			
		return param;
	}

}
