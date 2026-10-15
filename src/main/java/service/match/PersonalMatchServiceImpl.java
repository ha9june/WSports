package service.match;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
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
import dao.ReviewDao;
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
		 List<PersonalMatch> matchList = personalMatchDao.selectNowPersonalMatchList(searchInfo);
	    if (matchList.size() < 4) {
	        int remainCount = 4 - matchList.size();
	        Map<String, Object> param = new HashMap<>();
	        param.put("userId", searchInfo.getUserId());
	        param.put("limit", remainCount);
	        List<Long> excludeIds = new ArrayList<>();
	        for (PersonalMatch match : matchList) {
	            excludeIds.add(match.getPersonalMatchId());
	        }
	        param.put("excludeIds", excludeIds);
	        List<PersonalMatch> newMatchList = personalMatchDao.selectLatestPersonalMatchList(param);
	        matchList.addAll(newMatchList);
	    }
	    return matchList;
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

	public PersonalMatch getPersonalMatchDetail(PersonalMatch personalMatch) throws Exception {
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
        return personalMatchId;

	}
	@Override
	public Long updatePersonalMatch(PersonalMatch personalMatch, Collection<Part> parts, String realPath)
			throws Exception {

		List<String> images = new ArrayList<>();

		// 1. 남길 기존 사진 (hidden keepImage)
		for (Part part : parts) {
			if ("keepImage".equals(part.getName())) {
				String name = readPartText(part);
				if (!name.isEmpty() && images.size() < 5) images.add(name);
			}
		}

		// 2. 새로 올린 사진
		for (Part part : parts) {
			if (!"photos".equals(part.getName())) continue;
			String submitted = part.getSubmittedFileName();
			if (submitted == null || submitted.isEmpty() || part.getSize() == 0) continue;
			if (images.size() >= 5) break;
			images.add(fileUpload(realPath, part));
		}

		// 3. image1~5 채우기 (없으면 null)
		personalMatch.setImage1(images.size() > 0 ? images.get(0) : null);
		personalMatch.setImage2(images.size() > 1 ? images.get(1) : null);
		personalMatch.setImage3(images.size() > 2 ? images.get(2) : null);
		personalMatch.setImage4(images.size() > 3 ? images.get(3) : null);
		personalMatch.setImage5(images.size() > 4 ? images.get(4) : null);

		return personalMatchDao.updatePersonalMatch(personalMatch);
	}
	private String readPartText(Part part) throws Exception {
		try (java.util.Scanner sc = new java.util.Scanner(part.getInputStream(), "UTF-8")) {
			sc.useDelimiter("\\A");
			return sc.hasNext() ? sc.next().trim() : "";
		}
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

	
	
	@Override
	public Long updateStatue(PersonalMatch personalMatch) throws Exception {
		return personalMatchDao.updatePersonalMatchStatue(personalMatch);
	}

	@Override
	public int updateStatusCancelOfHost(Long personalMatchId) throws Exception {
		return personalMatchDao.updateStatusCancelOfHost(personalMatchId);
	}

	@Override
	public int updateStatusDeleteOfAdmin(Long personalMatchId) throws Exception {
		return personalMatchDao.updateStatusDeleteOfAdmin(personalMatchId);

	}
}




