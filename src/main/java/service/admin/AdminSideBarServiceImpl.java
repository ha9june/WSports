package service.admin;

import java.util.HashMap;
import java.util.Map;

import dao.InquiryDao;
import dao.InquiryDaoImpl;
import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dao.PersonalPaymentDao;
import dao.PersonalPaymentDaoImpl;
import dao.PersonalSettlementDao;
import dao.PersonalSettlementDaoImpl;
import dao.ReportDao;
import dao.ReportDaoImpl;
import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dao.TeamPaymentDao;
import dao.TeamPaymentDaoImpl;
import dao.TeamSettlementDao;
import dao.TeamSettlementDaoImpl;
import dao.UserDao;
import dao.UserDaoImpl;

public class AdminSideBarServiceImpl implements AdminSideBarService {
	private UserDao userDao;
	private TeamDao teamDao;
	private PersonalMatchDao personalmatchDao;
	private TeamMatchDao teammatchDao;
	private PersonalPaymentDao personalPaymentDao;
	private TeamPaymentDao teamPaymentDao;
	private PersonalSettlementDao personalSettlementDao;
	private TeamSettlementDao teamSettlementDao;
	private ReportDao reportDao;
	private InquiryDao inquiryDao;
	
	public AdminSideBarServiceImpl() {
		this.userDao = new UserDaoImpl();
		this.teamDao = new TeamDaoImpl();
		this.personalmatchDao = new PersonalMatchDaoImpl();
		this.teammatchDao = new TeamMatchDaoImpl();
		this.personalPaymentDao = new PersonalPaymentDaoImpl();
		this.teamPaymentDao = new TeamPaymentDaoImpl();
		this.personalSettlementDao = new PersonalSettlementDaoImpl();
		this.teamSettlementDao = new TeamSettlementDaoImpl();
		this.reportDao = new ReportDaoImpl();
		this.inquiryDao = new InquiryDaoImpl();
	}
	@Override
	public Map<String, Object> getAdminStats() throws Exception {
		Map<String, Object> param = new HashMap<>();
		//회원수
		param.put("usercnt", userDao.selectUserCnt());
		//팀수
		param.put("teamcnt", teamDao.selectTeamCnt());
		//모집중인 경기로 변경
		param.put("matchcnt", personalmatchDao.selectMatchCntPersonal() 
				+ teammatchDao.selectMatchCntTeam());
		//전체 신고 개수로 변경
		param.put("reportcnt", reportDao.selectTotalReportCnt());
		return param;
	}
	@Override
	public Integer getSettlementWaitCnt() throws Exception {
		return personalSettlementDao.selectPersonalSettlementWait() + teamSettlementDao.selectTeamSettlementWait();
	}
	@Override
	public Integer getReportWaitCnt() throws Exception {
		return reportDao.selectAdminReportWaitCnt();
	}
	@Override
	public Integer getInquiryWaitCnt() throws Exception {
		return inquiryDao.selectAdminInquiryWaitCnt();
	}

}
