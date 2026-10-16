package scheduler;

import java.util.List;

import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dao.TeamSettlementDao;
import dao.TeamSettlementDaoImpl;
import dao.UserDao;
import dao.UserDaoImpl;
import dto.Notification;
import dto.TeamMatch;
import dto.TeamSettlement;
import dto.User;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;
import util.TossKey;

public class TeamMatchJob {
    private TeamMatchDao teamMatchDao = new TeamMatchDaoImpl();
    private NotificationService alarmService = new NotificationServiceImpl();
    private PaymentService paymentService = new PaymentServiceImpl();
    private TeamSettlementDao teamSettlementDao = new TeamSettlementDaoImpl();
    private UserDao userDao = new UserDaoImpl();
    
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
    	try {
    		fillMissingSettlements();
    	} catch (Exception e) {
    		System.err.println("[TeamMatchJob] fillMissingSettlements 실패");
    		e.printStackTrace();
    	}
    }

    private void cancelNoOpponent() throws Exception { // 마감 지남 + 상대 없음 → 경기취소
        List<TeamMatch> expiredTeamMatchList = teamMatchDao.selectExpiredRecruiting();
        for (TeamMatch t : expiredTeamMatchList) {
            try {
            	//모집 팀 결제 자동 환불 + 환불 알림 -> 환불 필요없음 ㅋ
//            	paymentService.autoRefundHostTeamPayment(t.getTeamMatchId(), TossKey.SECRET_KEY);
                int updated = teamMatchDao.updateStatusToCancel(t.getTeamMatchId());
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

    private void finishMatches() throws Exception {
    	List<TeamMatch> list = teamMatchDao.selectFinishedMatches();   // selectFinishedMatches
    	for (TeamMatch t : list) {
    		try {
    			int updated = teamMatchDao.updateStatusToFinished(t.getTeamMatchId());   // updateStatusToFinished
    			if (updated == 1) {
    				createHostSettlement(t);
    				
    				String title = "'" + t.getTitle() + "' 경기가 종료되었습니다.";
    				String content = "출석체크 확인 및 경기 매너 평가를 부탁드립니다.";
    				String link = "/team-match/detail/view?teamMatchId=" + t.getTeamMatchId();

    				for (Long uid : teamMatchDao.selectParticipantUserIds(t.getTeamMatchId())) {
    					notifyUser(uid, title, content, link);
    				}
    			}
    		} catch (Exception e) {
    			System.err.println("[TeamMatchJob] 경기 종료 처리 실패 teamMatchId=" + t.getTeamMatchId());
    			e.printStackTrace();   // 한 경기 실패가 나머지를 막지 않게
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
            System.err.println("[TeamMatchJob] 알림 전송 실패 userId=" + userId + ", link=" + link);
            e.printStackTrace();
        }
    }
    
    private void createHostSettlement(TeamMatch t) {
    	try {
    		User host = userDao.selectUserByUserId(t.getUserId());  // 교체: 호스트 조회
    		TeamSettlement s = new TeamSettlement();
    		s.setUserId(t.getUserId());                          // 교체: 호스트 getter
    		s.setTeamMatchId(t.getTeamMatchId());
    		s.setAccountNumber(host.getAccountNumber());         // 교체: 계좌 getter, 없으면 null
    		s.setBankName(host.getBankName());
    		s.setAmount(t.getParticipationFee()-t.getFee());     //참가비 - 수수료 여기서 호스트 수수료 걷음
    		teamSettlementDao.insertTeamSettlement(s);
    	} catch (Exception e) {
    		System.err.println("[TeamMatchJob] 정산 생성 실패 teamMatchId=" + t.getTeamMatchId());
    		e.printStackTrace();   // 정산이 실패해도 알림 발송은 계속
    	}
    }
    
    private void fillMissingSettlements() throws Exception {
    	for (TeamMatch t : teamMatchDao.selectFinishedWithoutSettlement()) {
    		createHostSettlement(t);
    	}
    }
}