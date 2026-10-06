package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.NoticeDao;
import dao.NoticeDaoImpl;
import dto.PageInfo;

public class AdminNoticeServiceImpl implements AdminNoticeService {
	private NoticeDao noticeDao;
	public AdminNoticeServiceImpl() {
		this.noticeDao = new NoticeDaoImpl();
	}
	//공지 페이징처리 및 전체 리스트
	@Override
	public List<Map<String, Object>> getAdminNoticeList(PageInfo pageInfo, String status) throws Exception {
		// 버튼 값 → DB 상태 값
		Map<String, Object> param = new HashMap<>();
		// 모르는 값이면 전체
		param.put("status", status == null ? "ALL" : status);
		// 전체 게시글 수
		Integer noticeCnt = noticeDao.selectAdminNoticeCnt(param);
				
		Integer allPage = (int) Math.ceil(noticeCnt / 10.0); // 전체 페이지 수
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
						
		return noticeDao.selectAdminNoticeList(param);
	}
	//공지 작성
	@Override
	public void AdminNoticeWrite(String title, String content, Boolean isPinned, Long adminId, String type)
			throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("title", title);
		param.put("content", content);
		param.put("isPinned",  Boolean.TRUE.equals(isPinned) ? 1 : 0);
		param.put("adminId", adminId);
		param.put("type", type);
		System.out.println("공지 작성 param : " + param);
		noticeDao.insertAdminNotice(param);
	}
	//핀 변경
	@Override
	public void AdminNoticePin(Long noticeId) throws Exception {
		noticeDao.updateAdminNoticePin(noticeId);
	}
	
	//공지 수정
	@Override
	public void getAdminNoticeModify(Long noticeId, String title, String content, String type) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("noticeId", noticeId);
		param.put("title", title);
		param.put("content", content);
		param.put("type", type);
		noticeDao.updateAdminNotice(param);
		
	}
	//삭제
	@Override
	public void AdminNoticeDelete(Long noticeId) throws Exception {
		noticeDao.updateAdminNoticeDelete(noticeId);
		
	}
	//공지 상세정보
	@Override
	public Map<String, Object> getAdminNoticeDetailList(Long noticeId) throws Exception {
		return noticeDao.selectAdminNoticeDetail(noticeId);
	}
}
