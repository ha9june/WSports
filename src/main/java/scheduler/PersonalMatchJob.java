package scheduler;

import java.util.List;

import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dao.PersonalMatchParticipantDao;
import dao.PersonalMatchParticipantDaoImpl;
import dao.UserDao;
import dao.UserDaoImpl;
import dto.Notification;
import dto.PersonalMatch;
import dto.PersonalSettlement;
import dto.User;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;
import util.TossKey;

public class PersonalMatchJob {
	private PersonalMatchDao personalMatchDao = new PersonalMatchDaoImpl();
    private NotificationService alarmService = new NotificationServiceImpl();
    private PersonalMatchParticipantDao personalMatchParticipantDao = new PersonalMatchParticipantDaoImpl();
	private PaymentService paymentService = new PaymentServiceImpl();
	private UserDao userDao = new UserDaoImpl();
    
    public void run() { // MatchScheduler가 부르는 유일한 공개 메서드

    	 try {
         	cancelUnderMin();
         	changeExpired();
         } catch (Exception e) {
         	System.err.println("[PersonalMatchJob] finishMatches 실패");
         	e.printStackTrace();
         }
    	
        try {
        	changeTofinished();
        } catch (Exception e) {
            System.err.println("[PersonalMatchJob] finishMatches 실패");
            e.printStackTrace();
        }    
    }
    


    //마감시간이 지났는데 최소 인원 미달이라서 전원 환불 & 경기 취소 => 경기상태 바꾸고, 참가자들도 바꿔
	// 모집중릴때 마감 지남 + 최소 인원 미달 → 전원 환불 → 경기 취소
	private void cancelUnderMin() throws Exception {
		List<PersonalMatch> list = personalMatchDao.selectExpiredUnderMin();
		for (PersonalMatch m : list) {
			try {
				// 참가자 전원 자동 환불 + 환불 알림
				boolean allRefunded = paymentService.autoRefundPersonalMatch(
						m.getPersonalMatchId(), m.getTitle(), TossKey.SECRET_KEY);

				// 한 명이라도 실패하면 상태를 바꾸지 않음 → 다음 실행 때 재시도
				if (!allRefunded) {
					System.err.println("[PersonalMatchJob] 일부 환불 실패, 다음 실행 때 재시도 personalMatchId=" + m.getPersonalMatchId());
					continue;
				}
				personalMatchDao.updateStatusToUnderMinCancel(m.getPersonalMatchId());
			} catch (Exception e) {
				System.err.println("[PersonalMatchJob] 경기 취소 처리 실패 personalMatchId=" + m.getPersonalMatchId());
				e.printStackTrace(); // 한 경기 실패가 나머지를 막지 않게
			}
		}
	}
	
	private void changeExpired() throws Exception{
		List<PersonalMatch> list = personalMatchDao.selectExpiredSuccess();
		
		for (PersonalMatch p : list) {
            try {
                int updated = personalMatchDao.updateStatusToExpired(p.getPersonalMatchId());
                if (updated > 0) {
                	String title = "'" + p.getTitle() + "' 모집이 마감되었습니다.";
    				String content = "경기 시작시간 10분 전 까지 도착하여 주십시오.";
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
	
    private void changeTofinished() throws Exception {	//마감상태 + 경기 시간 지남 + -> 경기 종료
    	List<PersonalMatch> list = personalMatchDao.selectFinishedSuccess();
    	for (PersonalMatch p : list) {
            try {
                int updated = personalMatchDao.updateStatusToFinished(p.getPersonalMatchId());
                if (updated > 0) {
                	String title = "'" + p.getTitle() + "' 경기가 종료되었습니다.";
    				String content = "출석체크 확인 및 경기 매너 평가를 부탁드립니다.";
    				String link = "/match/detail/view?personalMatchId=" + p.getPersonalMatchId();
    				
    				int userCnt=0;
    				for (Long uid : personalMatchParticipantDao.selectParticipantUserIds(p.getPersonalMatchId())) {
    					userCnt++;
    					notifyUser(uid, title, content, link);
    				}
    				
                    PersonalSettlement ps = new PersonalSettlement();
                    ps.setUserId(p.getUserId());
                    ps.setPersonalMatchId(p.getPersonalMatchId());
                    	User user = userDao.selectUserAccountInfo(p.getUserId());
                    ps.setAccountNumber(user.getAccountNumber());
                    ps.setBankName(user.getBankName());
                    
                    int amount = (p.getParticipationFee() - p.getFee())*userCnt;
                    ps.setAmount(amount);
                    ps.setSettlementStatus("정산대기");
                    paymentService.putPersonalSettlement(ps);
                    
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
            System.err.println("[TeamMatchJob] 알림 전송 실패 userId=" + userId + ", link=" + link);
            e.printStackTrace();
        }
    }
	
}

