package service.team;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.TeamApplicationDao;
import dao.TeamApplicationDaoImpl;
import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamUserDao;
import dao.TeamUserDaoImpl;
import dto.Notification;
import dto.Team;
import dto.TeamApplication;
import dto.User;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;

public class TeamApplicationServiceImpl implements TeamApplicationService {
	
	TeamDao teamDao;
	TeamApplicationDao teamApplicationDao;
	NotificationService notificationService;
	TeamUserDao teamUserDao;
	
	public TeamApplicationServiceImpl() {
		teamDao = new TeamDaoImpl();
		teamApplicationDao = new TeamApplicationDaoImpl();
		notificationService = new NotificationServiceImpl();
		teamUserDao = new TeamUserDaoImpl();
	}

	@Override
	public void application(Long teamId, User user, String message) throws Exception {
		TeamApplication teamApplication = new TeamApplication();
		
		teamApplication.setTeamId(teamId);
		teamApplication.setUserId(user.getUserId());
		teamApplication.setMessage(message);
		Team team = teamDao.selectTeam(teamId);
		if(team == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("userId", user.getUserId());
		if (teamUserDao.selectRole(param) != null) {
		    throw new Exception("이미 가입된 팀 입니다.");
		}
		if(teamApplicationDao.selectTeamApplication(teamApplication) != null) {
			throw new Exception ("이미 신청중인 팀 입니다.");
		}

		teamApplicationDao.insertTeamApplication(teamApplication);
		
		try {
			//알림 보내기
			//1. 알림 객체에 받은 유저 인덱스(userId), 제목, 내용, 누르면 이동 할 링크 담기
			//2. NotificationService에서 send함수로 보내기
			Notification alarm = new Notification();
			alarm.setUserId(teamDao.selectTeamCaptainUserId(teamId));
			alarm.setTitle(user.getNickname()+"님이 '"+team.getTeamName()+"'에 가입 신청했어요.");
			alarm.setContent(message);
			alarm.setLink("/team/manage/applications?teamId=" + teamId);
			notificationService.sendNotification(alarm);
			
		}catch(Exception e) {
			e.printStackTrace();
		}

	}
 
	@Override
	public TeamApplication getApplication(Long teamId, Long userId) throws Exception {
		TeamApplication teamApplication = new TeamApplication();
		teamApplication.setTeamId(teamId);
		teamApplication.setUserId(userId);
		return teamApplicationDao.selectTeamApplication(teamApplication);
	}

	@Override
	public List<TeamApplication> getApplicationList(Long teamId) throws Exception {
		if(teamDao.selectTeam(teamId) == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}
		return teamApplicationDao.selectTeamApplicationList(teamId);
	}

}
