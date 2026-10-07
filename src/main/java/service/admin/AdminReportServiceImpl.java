package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.InquiryDao;
import dao.ReportDao;
import dao.ReportDaoImpl;
import dto.Notification;
import dto.PageInfo;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;

public class AdminReportServiceImpl implements AdminReportService {
	private ReportDao reportDao;
	private NotificationService notificationService;
	public AdminReportServiceImpl() {
		this.reportDao = new ReportDaoImpl();
		this.notificationService = new NotificationServiceImpl();
	}
	@Override
	public List<Map<String, Object>> getAdminReportList(PageInfo pageInfo, String status)
			throws Exception {
		// 버튼 값 → DB 상태 값
		Map<String, String> statusName = new HashMap<>();
		statusName.put("WAIT", "처리대기");
		statusName.put("DONE", "처리완료");
		// 모르는 값이면 전체
		Map<String, Object> param = new HashMap<>();
		param.put("status", statusName.getOrDefault(status, "ALL"));   

		// 전체 게시글 수
		Integer reportCnt = reportDao.selectAdminReportCnt(param);
		System.out.println(reportCnt+"서비스");
		Integer allPage = (int) Math.ceil(reportCnt / 10.0); // 전체 페이지 수
		if (allPage == 0) allPage = 1; // 회원이 0명이어도 1페이지는 있도록

		// 현재 페이지 보정을 먼저 (1 ~ 마지막 페이지 사이로)
		if (pageInfo.getCurPage() == null || pageInfo.getCurPage() < 1) pageInfo.setCurPage(1);
		if (pageInfo.getCurPage() > allPage) pageInfo.setCurPage(allPage);
		
		// startPage : curPage(1~10)=>1, curPage(11~20)=>11, curPage(21~30)=>21
		Integer startPage = (pageInfo.getCurPage() - 1) / 10 * 10 + 1;
		Integer endPage = startPage + 9;
		if (endPage > allPage) endPage = allPage; // 마지막 페이지 보정, 전체 페이지 넘지 않게

		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);

		param.put("row",(pageInfo.getCurPage() - 1) * 10);
		
		return reportDao.selectAdminReportList(param);
	}
	//관리자 신고 답변
	@Override
	public void AdminReportAnswer(Long reportId, String answer, Long adminId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("reportId", reportId);
		param.put("answer", answer);
		param.put("adminId", adminId);
		reportDao.updateAdminReportAnswer(param); //답변 저장
		//신고 세부정보 조회, 작성자 번호, 신고 제목 꺼내기
		Map<String, Object> detail = reportDao.selectAdminReportDetail(reportId);
		if(detail == null) return;
		
		Long userId = ((Number) detail.get("user_id")).longValue();
		String reportTitle = (String) detail.get("title");
		
		//알림 내용 만들기
		String content = ""+reportTitle+"신고에 답변이 등록되었습니다.";
		String link = "/report/detail?reportId="+reportId;
		//알림 객체 채우기
		Notification alarm = new Notification();
		alarm.setUserId(userId);
		alarm.setTitle("신고 답변 등록");
		alarm.setContent(content);
		alarm.setLink(link);
		//알림 저장, 푸시 전송
		notificationService.sendNotification(alarm);
		
	}
	//신고 세부 정보
	@Override
	public Map<String, Object> getAdminReportDetail(Long reportId) throws Exception {
		return reportDao.selectAdminReportDetail(reportId);
	}

}
