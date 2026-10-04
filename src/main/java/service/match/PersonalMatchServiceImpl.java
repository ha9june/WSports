package service.match;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dto.PersonalMatch;
import util.MatchSearchInfo;
import util.PageInfo;

public class PersonalMatchServiceImpl implements PersonalMatchService {

	private PersonalMatchDao personalMatchDao;

	public PersonalMatchServiceImpl() {
		personalMatchDao = new PersonalMatchDaoImpl();
	}
	
	

	@Override
	public List<PersonalMatch> getRecomandMatch() throws Exception {
		return personalMatchDao.selectPersonalMatchList();
	}
	
	// 마이페이지 참가 경기 목록 조회(페이징)
	@Override
	public List<PersonalMatch> getNormalMatch(MatchSearchInfo searchInfo) throws Exception {
		return personalMatchDao.selectNormalPersonalMatchList(searchInfo);
	}
	
	@Override
	public List<PersonalMatch> getMapMatch(MatchSearchInfo searchInfo) throws Exception {
		return personalMatchDao.selectMapPersonalMatchList(searchInfo);
	}

	@Override
	public List<PersonalMatch> MyPagePersonalMatchList(PageInfo pageInfo, long userId, String month,String status,String sport) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("month", month);
		param.put("status", status);
		param.put("sport", sport);
		
		int cnt = personalMatchDao.selectMyPagePersonalMatchCnt(param);
		Integer allPage = (int) Math.ceil(cnt / 10.0);
		Integer startPage = (pageInfo.getCurPage() - 1) / 10 * 10 + 1;
		int endPage = Math.min(startPage + 9, allPage);

		if (endPage < 1) endPage = 1;
		if (pageInfo.getCurPage() > endPage) {
			pageInfo.setCurPage(endPage);
		}
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		param.put("offset",(pageInfo.getCurPage() - 1) * 10);
		param.put("size", 10);
		
		
		return personalMatchDao.selectMyPagePersonalMatchList(param);
	}
	// 마이페이지 내가 만든 경기 목록 조회(페이징)
	@Override
	public List<PersonalMatch> MyPageCreatedPersonalMatchList(PageInfo pageInfo, Long userId, String month,
			String status, String sport) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("month", month);
		param.put("status", status);
		param.put("sport", sport);
		
		int cnt = personalMatchDao.selectMyPageCreatedPersonalMatchCnt(param);
		Integer allPage = (int) Math.ceil(cnt / 10.0);
		Integer startPage = (pageInfo.getCurPage() - 1) / 10 * 10 + 1;
		int endPage = Math.min(startPage + 9, allPage);

		if (endPage < 1) endPage = 1;
		if (pageInfo.getCurPage() > endPage) {
			pageInfo.setCurPage(endPage);
		}
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		param.put("offset",(pageInfo.getCurPage() - 1) * 10);
		param.put("size", 10);
		
		
		return personalMatchDao.selectMyPageCreatedPersonalMatchsportList(param);
	
	
	
	}
	@Override
	public Map<String,Object> getPersmalMatchDetail(Integer personalMatchId) throws Exception {
		// TODO Auto-generated method stub
		return personalMatchDao.selectPersonalMatch(personalMatchId);
	}



	@Override
	public List<PersonalMatch> MyPagePersonalMatchList(PageInfo pageInfo, long userId, String month) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


}
