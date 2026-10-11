package service.team;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Part;

import dao.FavoriteDao;
import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dto.TeamMatch;
import dto.TeamSearchCondition;

public class TeamMatchServiceImpl implements TeamMatchService {
	
	TeamMatchDao teamMatchDao;
	TeamDao teamDao;
	FavoriteDao favoriteDao;
	
	public TeamMatchServiceImpl() {
		teamMatchDao = new TeamMatchDaoImpl();
		teamDao = new TeamDaoImpl();
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
	public List<TeamMatch> getTeamMatchList(Long teamId) throws Exception {
		if(teamDao.selectTeam(teamId) == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}
		return teamMatchDao.selectTeamMatchList(teamId);
	}

	@Override
	public Long makeTeamMatch(TeamMatch teamMatch, String realPath, List<Part> files) throws Exception {
		if(files.size() > 0) teamMatch.setImage1(fileUpload(realPath, files.get(0)));
		if(files.size() > 1) teamMatch.setImage2(fileUpload(realPath, files.get(1)));
		if(files.size() > 2) teamMatch.setImage3(fileUpload(realPath, files.get(2)));
		if(files.size() > 3) teamMatch.setImage4(fileUpload(realPath, files.get(3)));
		if(files.size() > 4) teamMatch.setImage5(fileUpload(realPath, files.get(4)));
		teamMatchDao.insertTeamMatch(teamMatch);
		return teamMatch.getTeamMatchId();
	}

	@Override
	public TeamMatch getTeamMatchUser(Long teamMatchId, Long userId) throws Exception {
		return teamMatchDao.selectTeamMatchUser(teamMatchId, userId);
	}
	public TeamMatch getTeamMatchNotUser(Long teamMatchId) throws Exception {
		return teamMatchDao.selectTeamMatchNotUser(teamMatchId);
	}

	@Override
	public List<TeamMatch> getTeamMatchListSearch(TeamSearchCondition teamSearchCondition) throws Exception {
		return teamMatchDao.selectTeamMatchListForSearch(teamSearchCondition);
	}

	@Override
	public int getTeamMatchListSearchCnt(TeamSearchCondition teamSearchCondition) throws Exception {
		return teamMatchDao.selectTeamMatchListForSearchCnt(teamSearchCondition);
	}

	@Override
	public int modifyTeamMatch(TeamMatch tm, List<String> keepImages, String realPath, List<Part> files) throws Exception {
	    List<String> finalImages = new ArrayList<>(keepImages);
	    for (Part p : files) {
	        finalImages.add(fileUpload(realPath, p));   // makeTeamMatch가 쓰는 저장 로직 재사용
	    }
	    tm.setImage1(finalImages.size() > 0 ? finalImages.get(0) : null);
	    tm.setImage2(finalImages.size() > 1 ? finalImages.get(1) : null);
	    tm.setImage3(finalImages.size() > 2 ? finalImages.get(2) : null);
	    tm.setImage4(finalImages.size() > 3 ? finalImages.get(3) : null);
	    tm.setImage5(finalImages.size() > 4 ? finalImages.get(4) : null);
	    return teamMatchDao.updateTeamMatch(tm);
	}
}
