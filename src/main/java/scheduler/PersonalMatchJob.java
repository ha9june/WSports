package scheduler;

import java.util.List;

import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dto.PersonalMatch;
import service.payment.PaymentService;
import service.payment.PaymentServiceImpl;
import util.TossKey;

public class PersonalMatchJob {
	private PersonalMatchDao personalMatchDao = new PersonalMatchDaoImpl();
	private PaymentService paymentService = new PaymentServiceImpl();

	public void run() { // MatchScheduler가 부르는 공개 메서드
		try {
			cancelUnderMin();
		} catch (Exception e) {
			System.err.println("[PersonalMatchJob] cancelUnderMin 실패");
			e.printStackTrace();
		}
	}

	// 마감 지남 + 최소 인원 미달 → 전원 환불 → 경기 취소
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
}