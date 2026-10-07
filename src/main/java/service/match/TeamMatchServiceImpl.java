package service.match;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.FavoriteDao;
import dao.FavoriteDaoImpl;
import dao.TeamApplicationDao;
import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dto.TeamMatch;
import util.PageInfo;

public class TeamMatchServiceImpl implements TeamMatchService {
	private FavoriteDao favoriteDao;
	private TeamMatchDao teamMatchDao;
	public TeamMatchServiceImpl() {
		teamMatchDao = new TeamMatchDaoImpl();
		this.favoriteDao = new FavoriteDaoImpl();
	}
	
	
	@Override
	public List<TeamMatch> selectMypageTeamMatchList(PageInfo pageInfo, Long userId, String status, String sport,
			String startDate, String endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("status", status);
		param.put("sport", sport);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		
		int size = 5;
		
		int cnt = teamMatchDao.selectMypageTeamMatchCnt(param);
		
		Integer allPage = (int) Math.ceil(cnt / (double) size);
		if (allPage == 0) allPage = 1;
		
		if (pageInfo.getCurPage() == null || pageInfo.getCurPage() < 1) pageInfo.setCurPage(1);
	    if (pageInfo.getCurPage() > allPage) pageInfo.setCurPage(allPage);
	    
	    Integer startPage = (pageInfo.getCurPage() - 1) / 10 * 10 + 1;
		int endPage = Math.min(startPage + 9, allPage);
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		param.put("size", size);
		param.put("offset", (pageInfo.getCurPage() - 1) * size);

		return teamMatchDao.selectMypageTeamMatchList(param);
	}


	@Override
	public List<String> getMyPageTeamMatchDates(Long userId, String status, String sport) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("status", status);
		param.put("sport", sport);
		return teamMatchDao.selectMyPageTeamMatchDates(param);
	}
}
