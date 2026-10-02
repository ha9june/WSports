package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.UserPenaltyDao;
import dao.UserPenaltyDaoImpl;
import dto.PageInfo;

public class AdminMemberServiceImpl implements AdminMemberService {

	private UserPenaltyDao userpenaltyDao;

	public AdminMemberServiceImpl() {
		this.userpenaltyDao = new UserPenaltyDaoImpl();
	}

	@Override
	public List<Map<String, Object>> getAdminMemberList(PageInfo pageInfo, String status, String keyword) throws Exception {
		
		Map<String, Object> param = new HashMap<>();
		param.put("status", status);
		
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
		param.put("keyword", keyword);

		return userpenaltyDao.selectAdminMemberList(param);
	}

	@Override
	public List<Map<String, Object>> getAdminMemberDetailList(Long userId) throws Exception {
		return userpenaltyDao.selectAdminMemberDetailList(userId);
	}

	@Override
	public Map<String, Object> getUserPenalty() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
