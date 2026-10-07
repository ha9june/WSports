package service.team;

import java.io.File;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.http.Part;

import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamMatchDao;
import dao.TeamMatchDaoImpl;
import dto.TeamMatch;

public class TeamMatchServiceImpl implements TeamMatchService {
	
	TeamMatchDao teamMatchDao;
	TeamDao teamDao;
	
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
		System.out.println(files.size());
		System.out.println(teamMatch);
		return teamMatchDao.insertTeamMatch(teamMatch);
	}
	
}
