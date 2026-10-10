package service.support;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.NoticeDao;
import dao.NoticeDaoImpl;
import util.PageInfo;

public class NoticeServiceImpl implements NoticeService {
	private NoticeDao noticeDao;
	
	public NoticeServiceImpl() {
		noticeDao = new NoticeDaoImpl();
	}
	
	@Override
	public List<Map<String, Object>> noticeList(PageInfo pageInfo, String keyword, String type)
			throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("keyword", keyword);
		
		if("NOTICE".equals(type)) param.put("type", "공지");
		if("POLICY".equals(type)) param.put("type", "정책");
		if("CHECK".equals(type)) param.put("type", "점검");
		if("EVENT".equals(type)) param.put("type", "이벤트");
		if("UPDATE".equals(type)) param.put("type", "업데이트");
		
		List<Map<String, Object>> selectPinnedNoticeList = noticeDao.selectPinnedNoticeList(param);
		int pinnedNoticeList = selectPinnedNoticeList.size();
		int limit = 10 - pinnedNoticeList;
		param.put("limit", limit);
		
		Integer noticeCnt = noticeDao.selectNoticeCnt(param);
		pageInfo.setTotalCnt(selectPinnedNoticeList.size()+noticeCnt);
		Integer allPage = (int)Math.ceil(noticeCnt/(double)limit);
		if (allPage == 0) allPage = 1;
		
		if (pageInfo.getCurPage() == null || pageInfo.getCurPage() < 1) pageInfo.setCurPage(1);
		if (pageInfo.getCurPage() > allPage) pageInfo.setCurPage(allPage);
		
		Integer startPage = (pageInfo.getCurPage()-1)/10*10+1;
		Integer endPage = startPage+9;
		if (endPage > allPage) endPage = allPage;
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (pageInfo.getCurPage()-1)*limit;
		param.put("row", row);
		
		List<Map<String, Object>> selectNoticeList = new ArrayList<>(selectPinnedNoticeList);
		selectNoticeList.addAll(noticeDao.selectNotPinnedNoticeList(param));
		return selectNoticeList;
	}

	@Override
	public Map<String, Object> detailNotice(Long noticeId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("noticeId", noticeId);
		return noticeDao.selectDetailNotice(param);
	}
}
