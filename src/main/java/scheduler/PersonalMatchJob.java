package scheduler;

import java.util.List;

import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dao.PersonalMatchParticipantDao;
import dao.PersonalMatchParticipantDaoImpl;
import dto.Notification;
import dto.PersonalMatch;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;

public class PersonalMatchJob {
	private PersonalMatchDao personalMatchDao = new PersonalMatchDaoImpl();
    private NotificationService alarmService = new NotificationServiceImpl();
    private PersonalMatchParticipantDao personalMatchParticipantDao = new PersonalMatchParticipantDaoImpl();
    
    public void run() { // MatchScheduler가 부르는 유일한 공개 메서드
        try {
            cancelNoOpponent();
        } catch (Exception e) {
            System.err.println("[PersonalMatchJob] cancelNoOpponent 실패");
            e.printStackTrace();
        }
        try {
            finishMatches();
        } catch (Exception e) {
            System.err.println("[PersonalMatchJob] finishMatches 실패");
            e.printStackTrace();
        }
    }
    
    private void cancelNoOpponent() throws Exception { // 마감 지남 + 상대 없음 → 경기취소
    	List<PersonalMatch> list = personalMatchDao.selectExpiredRecruiting();
    	for (PersonalMatch p : list) {
            try {
                int updated = personalMatchDao.updateStatusToNoOpponentCancel(p.getPersonalMatchId());
                if (updated > 0) {
                    notifyUser(p.getUserId(),
                        "인원 미달 경기 취소 안내",
                        "'" + p.getTitle() + "' 경기가 모집 마감 시간이 지나 인원 미달로 취소되었습니다.",
                        "/match/detail/view?personalMatchId=" + p.getPersonalMatchId());
                }
            } catch (Exception e) {
                System.err.println("[PersonalMatchJob] 경기 취소 처리 실패 personalMatchIdMatchId=" + p.getPersonalMatchId());
                e.printStackTrace();
            }
        }
    }
    private void finishMatches() throws Exception {
    	List<PersonalMatch> list = personalMatchDao.selectExpiredRecruiting();
    	for (PersonalMatch p : list) {
            try {
                int updated = personalMatchDao.updateStatusToFinished(p.getPersonalMatchId());
                if (updated > 0) {
                	String title = "'" + p.getTitle() + "' 경기가 종료되었습니다.";
    				String content = "출석체크 확인 및 경기 매너 평가를 부탁드립니다.";
    				String link = "/match/detail/view?personalMatchId=" + p.getPersonalMatchId();
    				
    				for (Long uid : personalMatchParticipantDao.selectParticipantUserIds(p.getPersonalMatchId())) {
    					notifyUser(uid, title, content, link);
    				}
                }
            } catch (Exception e) {
                System.err.println("[PersonalMatchJob] 경기 취소 처리 실패 personalMatchIdMatchId=" + p.getPersonalMatchId());
                e.printStackTrace();
            }
        }

    }
    private void notifyUser(Long userId, String title, String content, String link) {
        try {
            Notification alarm = new Notification();
            alarm.setTitle(title);
            alarm.setContent(content);
            alarm.setUserId(userId);
            alarm.setLink(link);
            alarmService.sendNotification(alarm);
        } catch (Exception e) {
            System.err.println("[PersonalMatchJob] 알림 전송 실패 userId=" + userId + ", link=" + link);
            e.printStackTrace();
        }
    }

}
