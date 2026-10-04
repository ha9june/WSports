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
	//팀 정보
	@Override
	public Map<String, Object> getTeamInfo(Long teamId) throws Exception {
		return teampenaltyDao.selectTeamInfo(teamId);
	}
	//팀 페널티 리스트
	@Override
	public List<Map<String, Object>> getTeamPenaltyList(Long teamId) throws Exception {
		return teampenaltyDao.selectTeamPenaltyList(teamId);
	}
	
	//주장 닉네임
	@Override
	public String getTeamCaptain(Long teamId) throws Exception {
		return teampenaltyDao.selectTeamCaptain(teamId);
	}
	
	//팀원 수
	@Override
	public Integer getTeamMemberCnt(Long teamId) throws Exception {
		return teampenaltyDao.selectTeamMemberCnt(teamId);
	}
	
	//지금 정지중인가
	@Override
	public Integer getTeamSuspention(Long teamId) throws Exception {
		return teampenaltyDao.selectTeamSuspension(teamId);
	}
	//팀 제제기간
	@Override
	public void AdminTeamPenalty(Long teamId, int days, String reason) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("days", days);
		param.put("reason", reason);
		teampenaltyDao.insertTeamPenalty(param);
		
	}
	//팀 영구정지
	@Override
	public void AdminTeamPermanentPenalty(Long teamId, String reason) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("reason", reason);
		teampenaltyDao.insertTeamPermanentPenalty(param);
	}
	// 팀 페널티 점수 조정
	@Override
	public void AdminChangeTeamPenalty(Long teamId, int change, String reason) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("teamId", teamId);
		param.put("change", change);   // 부여면 +, 차감이면 -
		param.put("reason", reason);
		teampenaltyDao.insertTeamChangePenalty(param);
	}
}
