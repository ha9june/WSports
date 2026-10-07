package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.UserPenaltyDao;
import dao.UserPenaltyDaoImpl;
import dto.Notification;
import dto.PageInfo;
import service.notification.NotificationService;
import service.notification.NotificationServiceImpl;

public class AdminMemberServiceImpl implements AdminMemberService {

	private UserPenaltyDao userpenaltyDao;
	private NotificationService notificationService;
	public AdminMemberServiceImpl() {
		this.userpenaltyDao = new UserPenaltyDaoImpl();
		this.notificationService = new NotificationServiceImpl();
	}
	//리스트 뽑아오기,  pageInfo: 페이지 정보 / keyword : 회원 검색
	@Override
	public List<Map<String, Object>> getAdminMemberList(PageInfo pageInfo, String status, String keyword) throws Exception {
		
		Map<String, Object> param = new HashMap<>();
		param.put("status", status);
		param.put("keyword", keyword);
		
		// 전체 게시글 수
		Integer memberCnt = userpenaltyDao.selectAdminMemberCnt(param);
		Integer allPage = (int) Math.ceil(memberCnt / 10.0); // 전체 페이지 수
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
		return userpenaltyDao.selectAdminMemberList(param);
	}
	//특정 회원 상세 정보
	@Override
	public List<Map<String, Object>> getAdminMemberDetailList(Long userId) throws Exception {
		return userpenaltyDao.selectAdminMemberDetailList(userId);
	}
	//회원 신고 조치 - 정지
	@Override
	public void AdminUserPenalty(Long userId, int days, String reason) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("days", days);
		param.put("reason", reason);
		userpenaltyDao.insertUserPenalty(param);
		
		//회원 페널티 세부정보 조회
		List<Map<String, Object>> detail = userpenaltyDao.selectAdminMemberDetailList(userId);
		if (detail == null) return;
		//회원 id 꺼내기
		System.out.println(userId+":서비스");
						
		//알림 내용 만들기
		String title = "개인 정지";
		String content = "관리자 권한으로 회원은 "+days+"일 정지되었습니다.";
		String link = "/user/detail?userId="+userId;
		//알림 객체 채우기
		Notification alarm = new Notification();
		alarm.setUserId(userId);
		alarm.setTitle("개인 페널티 등록");
		alarm.setContent(content);
		alarm.setLink(link);
		//알림 저장, 푸시 전송
		notificationService.sendNotification(alarm);

	}
	//회원 영구정지
	@Override
	public void AdminUserPermanentPenalty(Long userId, String reason) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("reason", reason);
		userpenaltyDao.insertUserPermanentPenalty(param);
		
		//회원 페널티 세부정보 조회
		List<Map<String, Object>> detail = userpenaltyDao.selectAdminMemberDetailList(userId);
		if (detail == null) return;
		//회원 id 꺼내기
		System.out.println(userId+":서비스");
						
		//알림 내용 만들기
		String title = "개인 영구정지";
		String content = "회원께서는 영구정지 되었습니다.";
		String link = "/user/detail?userId="+userId;
		//알림 객체 채우기
		Notification alarm = new Notification();
		alarm.setUserId(userId);
		alarm.setTitle("개인 페널티 등록");
		alarm.setContent(content);
		alarm.setLink(link);
		//알림 저장, 푸시 전송
		notificationService.sendNotification(alarm);
		
	}
	//회원 벌점 조정
	@Override
	public void AdminChangeUserPenalty(Long userId, int change, String reason) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("change", change);
		param.put("reason", reason);
		userpenaltyDao.insertChangeUserPenalty(param);
		
		//회원 페널티 세부정보 조회
		List<Map<String, Object>> detail = userpenaltyDao.selectAdminMemberDetailList(userId);
		if (detail == null) return;
		//회원 id 꺼내기
		System.out.println(userId+":서비스");
						
		//알림 내용 만들기
		String title = "개인 패널티 점수 조정";
		String content = "개인 페널티 점수가 "+change+"점 조정되었습니다.";
		String link = "/user/detail?userId="+userId;
		//알림 객체 채우기
		Notification alarm = new Notification();
		alarm.setUserId(userId);
		alarm.setTitle("개인 페널티 등록");
		alarm.setContent(content);
		alarm.setLink(link);
		//알림 저장, 푸시 전송
		notificationService.sendNotification(alarm);
	}

}
