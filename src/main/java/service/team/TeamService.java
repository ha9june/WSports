package service.team;

import javax.servlet.http.Part;

import dto.Team;

public interface TeamService {
	Integer makeTeam(Team team, String realPath, Part profileImage, Part activityImg1, Part activityImg2, Part activityImg3,
			Part activityImg4, Part activityImg5) throws Exception;
}
