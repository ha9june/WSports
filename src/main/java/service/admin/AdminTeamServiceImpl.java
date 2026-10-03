package service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.TeamPenaltyDao;
import dao.TeamPenaltyDaoImpl;
import dto.PageInfo;

public class AdminTeamServiceImpl implements AdminTeamService {
	private TeamPenaltyDao teampenaltyDao;

	public AdminTeamServiceImpl() {
		this.teampenaltyDao = new TeamPenaltyDaoImpl();
	}

	@Override
	public List<Map<String, Object>> getAdminTeamList(PageInfo pageInfo, String status, String keyword)	throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("status", status);
		param.put("keyword", keyword);
		
		// 전체 게시글 수
		Integer teamCnt = teampenaltyDao.selectAdminTeamCnt(param);
		Integer allPage = (int) Math.ceil(teamCnt / 10.0); // 전체 페이지 수
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
		List<Map<String, Object>> list = teampenaltyDao.selectAdminTeamList(param);   
		for (Map<String, Object> t : list) {
			Long teamId = ((Number) t.get("team_id")).longValue();

			t.put("nickname", teampenaltyDao.selectTeamCaptain(teamId));
			t.put("membercnt", teampenaltyDao.selectTeamMemberCnt(teamId));

			Map<String, Object> penalty = teampenaltyDao.selectTeamLatestPenalty(teamId);
			t.put("score", penalty == null ? 0 : penalty.get("score"));
			t.put("reason", penalty == null ? "-" : penalty.get("reason"));

			t.put("suspension", teampenaltyDao.selectTeamSuspension(teamId) > 0 ? "정지" : "정상");
		}
		return list;
	}

	@Override
	public Integer getAdminTeamCnt(String status) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("status", status);
		param.put("keyword", "");	//빈 문자열은 참
		return teampenaltyDao.selectAdminTeamCnt(param);
	}

	@Override
	public List<Map<String, Object>> getTeamDetailList(Long teamId) throws Exception {
		return teampenaltyDao.selectTeamDetailList(teamId);
	}

}
