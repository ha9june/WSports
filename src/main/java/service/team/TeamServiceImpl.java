package service.team;

import java.io.File;
import java.nio.file.Paths;

import javax.servlet.http.Part;

import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamUserDao;
import dao.TeamUserDaoImpl;
import dto.Team;
import dto.TeamUser;

public class TeamServiceImpl implements TeamService {

	TeamDao teamDao;
	TeamUserDao teamUserDao;
	
	public TeamServiceImpl() {
		teamDao = new TeamDaoImpl();
		teamUserDao = new TeamUserDaoImpl();
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
	public Integer makeTeam(Team team, long userId, String realPath, Part profileImage, Part activityImg1, Part activityImg2, Part activityImg3,
			Part activityImg4, Part activityImg5) throws Exception {
		if(profileImage != null) team.setProfileImage(fileUpload(realPath, profileImage));
		if(activityImg1 != null) team.setActivityImage1(fileUpload(realPath, activityImg1));
		if(activityImg2 != null) team.setActivityImage2(fileUpload(realPath, activityImg2));
		if(activityImg3 != null) team.setActivityImage3(fileUpload(realPath, activityImg3));
		if(activityImg4 != null) team.setActivityImage4(fileUpload(realPath, activityImg4));
		if(activityImg5 != null) team.setActivityImage5(fileUpload(realPath, activityImg5));
		
		Integer teamId = teamDao.insertTeam(team);
		TeamUser teamUser = new TeamUser();
		teamUser.setTeamId((long)teamId);
		teamUser.setUserId(userId);
		teamUser.setTeamRole("CAPTAIN");
		teamUser.setWithdrawn(false);
		teamUserDao.insertTeamUser(teamUser);

		return teamId;
		
	}
}
