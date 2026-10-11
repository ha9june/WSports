package service.match;

import java.io.File;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Part;

import dao.FavoriteDao;
import dao.FavoriteDaoImpl;
import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dao.PersonalMatchParticipantDao;
import dao.PersonalMatchParticipantDaoImpl;
import dto.PersonalMatch;
import dto.PersonalMatchParticipant;
import util.MatchSearchInfo;
import util.PageInfo;

public class PersonalMatchServiceImpl implements PersonalMatchService {

	private FavoriteDao favoriteDao;
	private PersonalMatchDao personalMatchDao;
	private PersonalMatchParticipantDao personalMatchParticipantDao;

	public PersonalMatchServiceImpl() {
		personalMatchDao = new PersonalMatchDaoImpl();
		personalMatchParticipantDao = new PersonalMatchParticipantDaoImpl();
		this.favoriteDao = new FavoriteDaoImpl();
	}
	
	private String fileUpload(String uploadPath, Part file) throws Exception {
		
		String fileName = Paths.get(file.getSubmittedFileName()).getFileName().toString();		
		if(fileName != null && !fileName.isEmpty()) {
			File uploadDir = new File(uploadPath);			
			if(!uploadDir.exists()) uploadDir.mkdir();			
			file.write(uploadPath+File.separator+fileName);		
		}		
		return fileName;
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

	public PersonalMatch getPersmalMatchDetail(PersonalMatch personalMatch) throws Exception {
		// TODO Auto-generated method stub
		return personalMatchDao.selectPersonalMatch(personalMatch);
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
	public List<Map<String, Object>> selectMyPageFavoriteList(PageInfo pageInfo, Long userId, String status,
			String sport, String startDate, String endDate) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("status", status);
		param.put("sport", sport);
		param.put("startDate", startDate);
		param.put("endDate", endDate);

		int size = 5;
		int cnt = favoriteDao.selectMyPageFavoriteCnt(param);

		Integer allPage = (int) Math.ceil(cnt / (double) size);
		if (allPage == 0) allPage = 1;
		if (pageInfo.getCurPage() == null || pageInfo.getCurPage() < 1) pageInfo.setCurPage(1);
		if (pageInfo.getCurPage() > allPage) pageInfo.setCurPage(allPage);

		Integer startPage = (pageInfo.getCurPage() - 1) / 10 * 10 + 1;
		int endPage = Math.min(startPage + 9, allPage);

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
	public Long createPersonalMatch(PersonalMatch personalMatch,Collection<Part> parts,String realPath ) throws Exception {
		int imageIndex = 1;
		for (Part part : parts) {
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().isEmpty()) {
                continue;
            }
            String fileName = fileUpload(realPath, part);

            if (imageIndex == 1) {
                personalMatch.setImage1(fileName);
            } else if (imageIndex == 2) {
                personalMatch.setImage2(fileName);
            } else if (imageIndex == 3) {
                personalMatch.setImage3(fileName);
            } else if (imageIndex == 4) {
                personalMatch.setImage4(fileName);
            } else if (imageIndex == 5) {
                personalMatch.setImage5(fileName);
            }
            imageIndex++;
            if (imageIndex > 5) {
                break;
            }  
        }
        //개인 매치 인서트
        Long personalMatchId = personalMatchDao.insertPersonalMatch(personalMatch);
        
        //개인 경기 참가지 인서트
        PersonalMatchParticipant pmp = new PersonalMatchParticipant();
        pmp.setUserId(personalMatch.getUserId());	
        pmp.setPersonalMatchId(personalMatchId);
        pmp.setAttendance(true);
        System.out.println(pmp);
        personalMatchParticipantDao.insertCreatorPersonalMatchParticipant(pmp);
        
        return personalMatchId;

	}
	@Override
	public Long updatePersonalMatch(PersonalMatch personalMatch, Collection<Part> parts, String realPath)
			throws Exception {

        Long personalMatchId = personalMatchDao.updatePersonalMatch(personalMatch);
		return personalMatchId;
	}
	@Override
	public void deletePersmalMatchDetail(Long personalMatchId) throws Exception {
		
	}



	public List<String> getMyPageFavoriteDates(Map<String, Object> param) throws Exception {
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

	@Override
	public List<PersonalMatch> MyPageCreatedPersonalMatchList(PageInfo pageInfo, Long userId, String month,
			String status, String sport) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}




}
