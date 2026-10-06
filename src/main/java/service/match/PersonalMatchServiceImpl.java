package service.match;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.FavoriteDao;
import dao.FavoriteDaoImpl;
import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dto.PersonalMatch;
import util.MatchSearchInfo;
import util.PageInfo;

public class PersonalMatchServiceImpl implements PersonalMatchService {

	private FavoriteDao favoriteDao;
	private PersonalMatchDao personalMatchDao;

	public PersonalMatchServiceImpl() {
		personalMatchDao = new PersonalMatchDaoImpl();
		this.favoriteDao = new FavoriteDaoImpl();
	}

	@Override
	public List<PersonalMatch> getNowMatchList(MatchSearchInfo searchInfo) throws Exception {
		return personalMatchDao.selectNowPersonalMatchList(searchInfo);
	}

	@Override
	public List<PersonalMatch> getNormalMatchList(MatchSearchInfo searchInfo) throws Exception {
		return personalMatchDao.selectNormalPersonalMatchList(searchInfo);
	}

	@Override
	public List<PersonalMatch> getMapMatchList(MatchSearchInfo searchInfo) throws Exception {
		return personalMatchDao.selectMapPersonalMatchList(searchInfo);
	}

	@Override
	public List<PersonalMatch> MyPagePersonalMatchList(PageInfo pageInfo,Long userId,String status,String sport, String startDate, String endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("status", status);
		param.put("sport", sport);
		param.put("startDate", startDate);
		param.put("endDate", endDate);

		int size = 5;
		int cnt = personalMatchDao.selectMyPagePersonalMatchCnt(param);
		
		
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
		return personalMatchDao.selectMyPagePersonalMatchList(param);
	}

	@Override
	public List<PersonalMatch> MyPageCreatedPersonalMatchList(PageInfo pageInfo,Long userId,String status,String sport, String startDate, String endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("status", status);
		param.put("sport", sport);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		
		int size = 5;
		int cnt = personalMatchDao.selectMyPageCreatedPersonalMatchCnt(param);
		
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

		return personalMatchDao.selectMyPageCreatedPersonalMatchList(param);

	}

	@Override
	public Map<String, Object> getPersmalMatchDetail(Integer personalMatchId) throws Exception {
		// TODO Auto-generated method stub
		return personalMatchDao.selectPersonalMatch(personalMatchId);
	}

	@Override
	public void insertMyPageHeartMatch(Map<String, Object> param) throws Exception {
		favoriteDao.insertMyPageHeartMatch(param);
	}

	@Override
	public void deleteMyPageHeartMatch(Map<String, Object> param) throws Exception {
		favoriteDao.deleteMyPageHeartMatch(param);
	}

	@Override
	public Boolean toggleMyPageHeartMatch(long userId, long matchId, String matchType) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("matchId", matchId);
		param.put("matchType", matchType);

		if (isHeart(userId, matchId, matchType)) {
			favoriteDao.deleteMyPageHeartMatch(param);
			return false;
		} else {
			favoriteDao.insertMyPageHeartMatch(param);
			return true;
		}

	}

	@Override
	public Boolean isHeart(long userId, long matchId, String matchType) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("matchId", matchId);
		param.put("matchType", matchType);

		Long count = favoriteDao.selectMyPageHeartMatchExists(param);
		return count != null && count > 0;
	}

	@Override
	public List<PersonalMatch> selectMyPageFavoriteList(PageInfo pageInfo, Long userId, String status, String sport,
			String startDate, String endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("status", status);
		param.put("sport", sport);
		param.put("startDate", startDate);
		param.put("endDate", endDate);
		int size = 5;
		int cnt = favoriteDao.selectMyPageFavoriteCnt(param);
		Integer allPage = (int) Math.ceil(cnt / (double) size);
		Integer startPage = (pageInfo.getCurPage() - 1) / 10 * 10 + 1;
		int endPage = Math.min(startPage + 9, allPage);

		if (endPage < 1)
			endPage = 1;
		if (pageInfo.getCurPage() > endPage) {
			pageInfo.setCurPage(endPage);
		}
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);

		param.put("offset", (pageInfo.getCurPage() - 1) * size);
		param.put("size", size);

		return favoriteDao.selectMyPageFavoriteList(param);
	}

	@Override
	public List<PersonalMatch> getNormalMatch(MatchSearchInfo searchInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PersonalMatch> getMapMatch(MatchSearchInfo searchInfo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> getMyPageFavoriteDates(Long userId, String status, String sport) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("status", status);
		param.put("sport", sport);
		return favoriteDao.selectMyPageFavoriteDates(param);
	}

	@Override
	public List<String> getMyPagePersonalMatchDates(Long userId, String status, String sport) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("status", status);
		param.put("sport", sport);
		return personalMatchDao.selectMyPagePersonalMatchDates(param);
	}

	@Override
	public List<String> getMyPageCreatedPersonalMatchDates(Long userId, String status, String sport) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("status", status);
		param.put("sport", sport);
		return personalMatchDao.selectMyPageCreatedPersonalMatchDates(param);
	}

}
