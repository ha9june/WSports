package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.InquiryDao;
import dao.InquiryDaoImpl;
import dto.PageInfo;

public class AdminInquiryServiceImpl implements AdminInquiryService {
	private InquiryDao inquiryDao;
	public AdminInquiryServiceImpl() {
		this.inquiryDao = new InquiryDaoImpl();
	}
	//문의 페이징 처리 및 전체 문의 리스트
	@Override
	public List<Map<String, Object>> getAdminInquiryList(PageInfo pageInfo, String status) throws Exception {
		// 버튼 값 → DB 상태 값
		Map<String, String> statusName = new HashMap<>();
		statusName.put("WAIT", "답변대기");
		statusName.put("DONE", "답변완료");
		// 모르는 값이면 전체
		Map<String, Object> param = new HashMap<>();
		param.put("status", statusName.getOrDefault(status, "ALL"));   

		// 전체 게시글 수
		Integer inquiryCnt = inquiryDao.selectAdminInquiryCnt(param);
				
		Integer allPage = (int) Math.ceil(inquiryCnt / 10.0); // 전체 페이지 수
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
				
		return inquiryDao.selectAdminInquiryList(param);
	}
	//문의 답변
	@Override
	public void AdminInquiryAnswer(Long inquiryId, String answer, Long adminId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("inquiryId", inquiryId);
		param.put("answer", answer);
		param.put("adminId", adminId);
		inquiryDao.updateAdminInquiryAnswer(param);
	}
	//문의 세부정보
	@Override
	public Map<String, Object> getAdminInquiryDetail(Long inquiryId) throws Exception {
		return inquiryDao.selectAdminInquiryDetail(inquiryId);
	}

}
