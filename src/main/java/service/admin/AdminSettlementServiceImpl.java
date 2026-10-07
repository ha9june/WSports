package service.admin;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.PersonalSettlementDao;
import dao.PersonalSettlementDaoImpl;
import dao.TeamSettlementDao;
import dao.TeamSettlementDaoImpl;
import dto.Notification;
import dto.TeamSettlement;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;

public class AdminSettlementServiceImpl implements AdminSettlementService {
	private PersonalSettlementDao personalsettlementDao;
	private TeamSettlementDao teamsettlementDao;
	private NotificationService notificationService;
	
	public AdminSettlementServiceImpl() {
		this.personalsettlementDao = new PersonalSettlementDaoImpl();
		this.teamsettlementDao = new TeamSettlementDaoImpl();
		this.notificationService = new NotificationServiceImpl();
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
	public List<Map<String, Object>> getPersonalSettlementDayList(LocalDate startDate, LocalDate endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("startDate", startDate.toString());
		param.put("endDate", endDate.toString());
		return personalsettlementDao.selectPersonalSettlementDayList(param);
	}

	@Override
	public Map<String, Object> getPersonalSettlementDetail(Long personalMatchId) throws Exception {
		return personalsettlementDao.selectPersonalSettlementDetail(personalMatchId);
	}
	
	@Override
	public List<Map<String, Object>> getPersonalSettlementList() throws Exception {
		return personalsettlementDao.selectPersonalSettlementList();
	}
	//개인경기 정산
	@Override
	public void updatePersonalSettlement(Long settlementId, Long adminId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("settlementId", settlementId);
		param.put("adminId", adminId);
		personalsettlementDao.updatePersonalSettlement(param);
		
		//개인경기 정산 세부정보 조회
		Map<String, Object> detail = personalsettlementDao.selectPersonalSettlementUser(settlementId);
		if (detail == null) return;
		//회원 id 꺼내기
		Long userId = ((Number) detail.get("user_id")).longValue();
		System.out.println(userId+":서비스");
								
		//알림 내용 만들기
		String title = "개인 정산";
		String content = "정산 완료 되었습니다.";
		String link = "/settlement/detail?settlementId="+settlementId;
		//알림 객체 채우기
		Notification alarm = new Notification();
		alarm.setUserId(userId);
		alarm.setTitle("개인 경기 정산 완료");
		alarm.setContent(content);
		alarm.setLink(link);
		//알림 저장, 푸시 전송
		notificationService.sendNotification(alarm);
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
	public List<Map<String, Object>> getTeamSettlementDayList(LocalDate startDate, LocalDate endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("startDate", startDate.toString());
		param.put("endDate", endDate.toString());
		return teamsettlementDao.selectTeamSettlementDayList(param);
	}

	@Override
	public Map<String, Object> getTeamSettlementDetail(Long teamMatchId) throws Exception {
		return teamsettlementDao.selectTeamSettlementDetail(teamMatchId);
	}


	@Override
	public List<Map<String, Object>> getTeamSettlementList() throws Exception {
		return teamsettlementDao.selectTeamSettlementList();
	}


	//팀 경기 정산
	@Override
	public void updateTeamSettlement(Long settlementId, Long adminId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("settlementId", settlementId);
		param.put("adminId", adminId);
		teamsettlementDao.updateTeamSettlement(param);
		
		//팀경기 정산 세부정보 조회
		Map<String, Object> detail = teamsettlementDao.selectTeamSettlementUser(settlementId);
		if (detail == null) return;
		//회원 id 꺼내기
		Long userId = ((Number) detail.get("user_id")).longValue();
		System.out.println(userId+":서비스");
								
		//알림 내용 만들기
		String title = "팀 경기 정산";
		String content = "정산 완료 되었습니다.";
		String link = "/settlement/detail?settlementId="+settlementId;
		//알림 객체 채우기
		Notification alarm = new Notification();
		alarm.setUserId(userId);
		alarm.setTitle("팀 경기 정산 완료");
		alarm.setContent(content);
		alarm.setLink(link);
		//알림 저장, 푸시 전송
		notificationService.sendNotification(alarm);
	}

}
