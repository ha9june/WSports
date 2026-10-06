package service.match;

import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Part;

import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dto.PersonalMatch;
import dto.PersonalMatchParticipant;
import util.MatchSearchInfo;
import util.PageInfo;

public class PersonalMatchServiceImpl implements PersonalMatchService {

	private PersonalMatchDao personalMatchDao;

	public PersonalMatchServiceImpl() {
		personalMatchDao = new PersonalMatchDaoImpl();
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
	
	// 마이페이지 참가 경기 목록 조회(페이징)
	@Override
	public List<PersonalMatch> getNormalMatchList(MatchSearchInfo searchInfo) throws Exception {
		return personalMatchDao.selectNormalPersonalMatchList(searchInfo);
	}
	
	@Override
	public List<PersonalMatch> getMapMatchList(MatchSearchInfo searchInfo) throws Exception {
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


	@Override
	public Long createPersonalMatch(PersonalMatch personalMatch,Collection<Part> parts,String realPath ) throws Exception {
		int imageIndex = 1;
		for (Part part : parts) {
            if (part.getSubmittedFileName() == null || part.getSubmittedFileName().isEmpty()) {
                continue;
            }
            String fileName = fileUpload(realPath, part);

            if (imageIndex == 1) {
            	personalMatch.setImage(fileName);
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
        //결제 완료시
        
        //개인 경기 참가지 인서트
        PersonalMatchParticipant pmp = new PersonalMatchParticipant();
        pmp.setUserId(personalMatch.getUserId());	
        pmp.setPersonalMatchId(personalMatchId);
        pmp.setAttendance(true);
        
        return personalMatchId;
		
		
	}






}
