package scheduler;

import java.util.List;

import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dto.Notification;
import dto.TeamMatch;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;

public class TeamMatchJob {
    private TeamMatchDao teamMatchDao = new TeamMatchDaoImpl();
    private NotificationService alarmService = new NotificationServiceImpl();

    public void run() { // MatchScheduler가 부르는 유일한 공개 메서드
        try {
            cancelNoOpponent();
        } catch (Exception e) {
            System.err.println("[TeamMatchJob] cancelNoOpponent 실패");
            e.printStackTrace();
        }
        try {
            finishMatches();
        } catch (Exception e) {
            System.err.println("[TeamMatchJob] finishMatches 실패");
            e.printStackTrace();
        }
    }

    private void cancelNoOpponent() throws Exception { // 마감 지남 + 상대 없음 → 경기취소
        List<TeamMatch> expiredTeamMatchList = teamMatchDao.selectExpiredRecruiting();
        for (TeamMatch t : expiredTeamMatchList) {
            try {
                int updated = teamMatchDao.updateStatusToNoOpponentCancel(t.getTeamMatchId());
                if (updated > 0) {
                    notifyUser(t.getUserId(),
                        "인원 미달 경기 취소 안내",
                        "'" + t.getTitle() + "' 경기가 모집 마감 시간이 지나 인원 미달로 취소되었습니다.",
                        "/team-match/detail/view?teamMatchId=" + t.getTeamMatchId());
                }
            } catch (Exception e) {
                System.err.println("[TeamMatchJob] 경기 취소 처리 실패 teamMatchId=" + t.getTeamMatchId());
                e.printStackTrace();
            }
        }
    }

    private void finishMatches() throws Exception {} // 경기 끝 시각 지남 → 경기종료

    private void notifyUser(Long userId, String title, String content, String link) {
        try {
            Notification alarm = new Notification();
            alarm.setTitle(title);
            alarm.setContent(content);
            alarm.setUserId(userId);
            alarm.setLink(link);
            alarmService.sendNotification(alarm);
        } catch (Exception e) {
            System.err.println("[TeamMatchJob] 알림 전송 실패 userId=" + userId + ", link=" + link);
            e.printStackTrace();
        }
    }
}