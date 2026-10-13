package service.settlement;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.PersonalSettlementDao;
import dao.PersonalSettlementDaoImpl;
import dao.TeamSettlementDao;
import dao.TeamSettlementDaoImpl;
import util.PageInfo;

public class SettlementServiceImpl implements SettlementService {
	private PersonalSettlementDao personalSettlementDao;
	private TeamSettlementDao teamSettlementDao;
	
	public SettlementServiceImpl() {
		this.personalSettlementDao = new PersonalSettlementDaoImpl();
		this.teamSettlementDao = new TeamSettlementDaoImpl();
	}
	
	// 마이페이지 개인경기 정산 리스트
	@Override
	public List<Map<String, Object>> MypagePersonalSettlementList(PageInfo pageInfo, String keyword, Long userId,
			String settlementStatus, String period) throws Exception {
		LocalDate today = LocalDate.now();
	    LocalDate startDate;

	    if ("6m".equals(period)) {
	        startDate = today.minusMonths(6);
	    } else if ("year".equals(period)) {
	        startDate = LocalDate.of(today.getYear(), 1, 1);
	    } else {
	        startDate = today.minusMonths(3);
	    }

	    Map<String, Object> param = new HashMap<>();
	    param.put("userId", userId);
	    param.put("keyword", keyword);
	    param.put("startDate", startDate);
	    param.put("endDate", today);
	    
	    if("WAIT".equals(settlementStatus)) param.put("settlementStatus", "정산대기");
		if("DONE".equals(settlementStatus)) param.put("settlementStatus", "지급완료");
		
		Integer personalsettlementListCnt = personalSettlementDao.selectMyPagePersonalSettlementCnt(param);
		Integer allPage = (int)Math.ceil(personalsettlementListCnt/10.0);
		if (allPage == 0) allPage = 1;
		
		if (pageInfo.getCurPage() == null || pageInfo.getCurPage() < 1) pageInfo.setCurPage(1);
		if (pageInfo.getCurPage() > allPage) pageInfo.setCurPage(allPage);
		
		Integer startPage = (pageInfo.getCurPage()-1)/10*10+1;
		Integer endPage = startPage+9;
		if (endPage > allPage) endPage = allPage;
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (pageInfo.getCurPage()-1)*10+1;
		param.put("row", row-1);
	    return personalSettlementDao.selectMypagePersonalSettlementList(param);
	}
	
	// 마이페이지 개인경기 정산 카운트
	@Override
	public Map<String, Object> MypagePersonalSettlementSummary(String keyword, Long userId, String period)
			throws Exception {
		LocalDate today = LocalDate.now();
	    LocalDate startDate;
	    if ("6m".equals(period)) {
	        startDate = today.minusMonths(6);
	    } else if ("year".equals(period)) {
	        startDate = LocalDate.of(today.getYear(), 1, 1);
	    } else {
	        startDate = today.minusMonths(3);
	    }

	    Map<String, Object> param = new HashMap<>();
	    param.put("userId", userId);
	    param.put("keyword", keyword);
	    param.put("startDate", startDate);
	    param.put("endDate", today);

	    Map<String, Object> result = new HashMap<>();
	    result.putAll(personalSettlementDao.selectMyPagePersonalSettlementSummary(userId));
	    result.putAll(personalSettlementDao.selectMyPagePersonalSettlementTabCnt(param));
	    return result;
	}

	// 마이페이지 팀경기 정산 리스트
	@Override
	public List<Map<String, Object>> MypageTeamSettlementList(PageInfo pageInfo, String keyword, Long userId,
			String settlementStatus, String period, Long teamId) throws Exception {
		LocalDate today = LocalDate.now();
	    LocalDate startDate;

	    if ("6m".equals(period)) {
	        startDate = today.minusMonths(6);
	    } else if ("year".equals(period)) {
	        startDate = LocalDate.of(today.getYear(), 1, 1);
	    } else {
	        startDate = today.minusMonths(3);
	    }

	    Map<String, Object> param = new HashMap<>();
	    param.put("userId", userId);
	    param.put("keyword", keyword);
	    param.put("teamId", teamId);
	    param.put("startDate", startDate);
	    param.put("endDate", today);
	    
	    if("WAIT".equals(settlementStatus)) param.put("settlementStatus", "정산대기");
		if("DONE".equals(settlementStatus)) param.put("settlementStatus", "지급완료");
		
		Integer teamsettlementListCnt = teamSettlementDao.selectMyPageTeamSettlementCnt(param);
		Integer allPage = (int)Math.ceil(teamsettlementListCnt/10.0);
		if (allPage == 0) allPage = 1;
		
		if (pageInfo.getCurPage() == null || pageInfo.getCurPage() < 1) pageInfo.setCurPage(1);
		if (pageInfo.getCurPage() > allPage) pageInfo.setCurPage(allPage);
		
		Integer startPage = (pageInfo.getCurPage()-1)/10*10+1;
		Integer endPage = startPage+9;
		if (endPage > allPage) endPage = allPage;
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (pageInfo.getCurPage()-1)*10+1;
		param.put("row", row-1);
	    return teamSettlementDao.selectMypageTeamSettlementList(param);
	}
	
	// 마이페이지 팀경기 정산 카운트
	@Override
	public Map<String, Object> MypageTeamSettlementSummary(String keyword, Long userId, String period, Long teamId)
			throws Exception {
		LocalDate today = LocalDate.now();
	    LocalDate startDate;
	    if ("6m".equals(period)) {
	        startDate = today.minusMonths(6);
	    } else if ("year".equals(period)) {
	        startDate = LocalDate.of(today.getYear(), 1, 1);
	    } else {
	        startDate = today.minusMonths(3);
	    }

	    Map<String, Object> param = new HashMap<>();
	    param.put("userId", userId);
	    param.put("keyword", keyword);
	    param.put("teamId", teamId);
	    param.put("startDate", startDate);
	    param.put("endDate", today);

	    Map<String, Object> result = new HashMap<>();
	    result.putAll(teamSettlementDao.selectMyPageTeamSettlementSummary(userId));
	    result.putAll(teamSettlementDao.selectMyPageTeamSettlementTabCnt(param));
	    result.put("teamList", teamSettlementDao.selectMyPageTeamList(userId));
	    return result;
	}
}