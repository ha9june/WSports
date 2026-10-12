package scheduler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.TeamPenaltyDao;
import dao.TeamPenaltyDaoImpl;
import dao.UserPenaltyDao;
import dao.UserPenaltyDaoImpl;
import dto.Notification;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;

public class PenaltyJob {
	private UserPenaltyDao userPenaltyDao = new UserPenaltyDaoImpl();
	private TeamPenaltyDao teamPenaltyDao = new TeamPenaltyDaoImpl();
	private NotificationService alarmService = new NotificationServiceImpl();
	
	public void run() { //MatchScheduler가 부르는 공개 메서드
		try {
			autoSuspendUsers();
		}catch (Exception e) {
			System.err.println("[PenaltyJob] autoSuspendUsers 실패");
			e.printStackTrace();
		}
		
		try {
			notifyReviewUsers();
		} catch (Exception e) {
			System.err.println("[PenaltyJob] notifyReviewUsers 실패");
			e.printStackTrace();
		}
		
		try {
			autoSuspendTeams();
		}catch (Exception e) {
			System.err.println("[PenaltyJob] autoSuspenTeams 실패");
			e.printStackTrace();
		}
		
		try {
			notifyReviewTeams();
		} catch (Exception e) {
			System.err.println("[PenaltyJob] notifyReviewTeams 실패");
			e.printStackTrace();
		}
	}
	
	//벌점 30/60점 도달 -> 30/60일 자동 정지
	private void autoSuspendUsers() throws Exception {
		List<Map<String, Object>> targets = userPenaltyDao.selectAutoSuspendTargets();
		for(Map<String, Object> t : targets) {
			Long userId = ((Number) t.get("user_id")).longValue();
			int score = ((Number) t.get("score")).intValue();
			int days = (score >= 60) ? 60 : 30;
			try {
				Map<String, Object> param = new HashMap<>();
				param.put("userId", userId);
				param.put("score", score); //점수는 그대로 유지 (정지 기록만 추가)
				param.put("reason", "벌점" + (days == 60 ? 60 : 30) +"점 도달 자동 정지되었습니다.");
				param.put("days", days);
				userPenaltyDao.insertAutoSuspend(param);
				
				notifyUser(userId, "이용 정지 안내", 
						"누적 벌점 "+ score + "점으로 "+days+"일간 이용이 정지되었습니다.","/mypage");
			}catch(Exception e) {
				System.err.println("[PenaltyJob] 자동 정지 실패 userId=" + userId);
				e.printStackTrace(); //한명 실패가 나머지를 막지 않게
			}
		}
	}
	
	// 벌점 100점 도달 → 관리자에게 영구정지 검토 알림 (+ 당사자 안내)
	private void notifyReviewUsers() throws Exception {
		List<Map<String, Object>> targets = userPenaltyDao.selectReviewTargets();
		if (targets.isEmpty()) return;
		List<Long> adminIds = userPenaltyDao.selectAdminUserIds();

		for (Map<String, Object> t : targets) {
			Long userId = ((Number) t.get("user_id")).longValue();
			String nickname = (String) t.get("nickname");
			int score = ((Number) t.get("score")).intValue();
			String link = "/admin/member/detail?userId=" + userId;

			for (Long adminId : adminIds) {
				notifyUser(adminId, "영구정지 검토 필요",
						nickname + " 회원의 누적 벌점이 " + score + "점에 도달했습니다.", link);
			}
			// 당사자 안내 (원하지 않으면 삭제)
			notifyUser(userId, "영구정지 검토 안내",
					"누적 벌점 " + score + "점으로 영구정지 검토 대상이 되었습니다.", "/mypage");
		}
	}
	//팀 벌점 30/60점 도달 -> 30/60일 자동 정지 (정지 기간이 들어간 패널티 행 추가)
	private void autoSuspendTeams() throws Exception {
		List<Map<String, Object>> targets = teamPenaltyDao.selectAutoTeamSuspendTargets();
		for(Map<String, Object> t : targets) {
			Long teamId = ((Number) t.get("team_id")).longValue();
			int score = ((Number) t.get("score")).intValue();
			int days = (score >= 60) ? 60 : 30;
			try {
				Map<String, Object> param = new HashMap<>();
				param.put("teamId", teamId);
				param.put("score", score); //점수는 그대로 유지 (정지 기록만 추가)
				param.put("reason", "벌점 " + days +"점 도달 자동 정지되었습니다.");
				param.put("days", days);
				teamPenaltyDao.insertAutoTeamSuspend(param);
				
			}catch(Exception e) {
				System.err.println("[PenaltyJob] 팀 자동 정지 실패 teamId=" + teamId);
				e.printStackTrace(); //한명 실패가 나머지를 막지 않게
			}
		}
	}
	// 팀 벌점 100점 도달 → 관리자에게 영구정지 검토 알림
	private void notifyReviewTeams() throws Exception {
		List<Map<String, Object>> targets = teamPenaltyDao.selectTeamReviewTargets();
		if (targets.isEmpty()) return;
		List<Long> adminIds = userPenaltyDao.selectAdminUserIds();   // 회원 쪽에서 만든 것 재사용

		for (Map<String, Object> t : targets) {
			Long teamId = ((Number) t.get("team_id")).longValue();
			String teamName = (String) t.get("team_name");
			int score = ((Number) t.get("score")).intValue();
			String link = "/admin/team/detail?teamId=" + teamId;

			for (Long adminId : adminIds) {
				notifyUser(adminId, "팀 영구정지 검토 필요",
						teamName + " 팀의 누적 벌점이 " + score + "점에 도달했습니다.", link);
			}
		}
	}
	//알람
	private void notifyUser(Long userId, String title, String content, String link) {
		try {
			Notification alarm = new Notification();
			alarm.setUserId(userId);
			alarm.setTitle(title);
			alarm.setContent(content);
			alarm.setLink(link);
			alarmService.sendNotification(alarm);
		} catch (Exception e) {
			System.err.println("[PenaltyJob] 알림 전송 실패 userId="+ userId);
			e.printStackTrace();
		}
	}
}
