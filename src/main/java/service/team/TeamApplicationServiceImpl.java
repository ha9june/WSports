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
import dto.TeamUser;
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
		if(teamApplicationDao.selectTeamApplication(teamId, user.getUserId()) != null) {
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
		if(teamDao.selectTeam(teamId) == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}

		return teamApplicationDao.selectTeamApplication(teamId, userId);
	}
	
	@Override
	public TeamApplication getApplicationByApplicationId(Long applicationId) throws Exception {
		return teamApplicationDao.selectTeamApplicationByApplicationId(applicationId);
	}

	@Override
	public List<TeamApplication> getApplicationList(Long teamId) throws Exception {
		if(teamDao.selectTeam(teamId) == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}
		return teamApplicationDao.selectTeamApplicationList(teamId);
	}

	@Override
	public void approve(Long teamId, Long applicationId) throws Exception {
		TeamApplication teamApplication = getApplicationByApplicationId(applicationId);
		//팀 유저 인서트
		TeamUser teamUser = new TeamUser();
		teamUser.setTeamId(teamId);
		teamUser.setUserId(teamApplication.getUserId());
		teamUser.setTeamRole("MEMBER");
		teamUserDao.insertTeamUser(teamUser);
		//지원디비 업데이트
		teamApplicationDao.updateTeamApplicationApprove(teamId, applicationId);
		
		Team team = teamDao.selectTeam(teamId);
		try {
			Notification alarm = new Notification();
			alarm.setUserId(teamApplication.getUserId());
			alarm.setTitle("가입 신청 승인");
			alarm.setContent("'"+team.getTeamName()+"'에 가입 신청이 승인되었어요.");
			alarm.setLink("/team/detail/view?teamId=" + teamId); //마이페이지 팀 부분으로?
			notificationService.sendNotification(alarm);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void reject(Long teamId, Long applicationId, String reason) throws Exception {
		TeamApplication teamApplication = getApplicationByApplicationId(applicationId);

		//지원디비 업데이트
		teamApplicationDao.updateTeamApplicationReject(teamId, applicationId, reason);
		
		Team team = teamDao.selectTeam(teamId);
		try {
			Notification alarm = new Notification();
			alarm.setUserId(teamApplication.getUserId());
			alarm.setTitle("'"+team.getTeamName()+"' 가입 신청 거절");
			alarm.setContent("거절 사유 : " + reason);
			alarm.setLink("/team/detail/view?teamId=" + teamId); //나중에 마이페이지 팀 부분으로?
			notificationService.sendNotification(alarm);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
