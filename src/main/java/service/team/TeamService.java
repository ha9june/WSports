package service.team;

import java.util.List;

import javax.servlet.http.Part;

import dto.Team;
import dto.TeamSearchCondition;

public interface TeamService {
	Long makeTeam(Team team, long userId, String realPath, Part profileImage, Part activityImg1, Part activityImg2, Part activityImg3,
			Part activityImg4, Part activityImg5) throws Exception;
	List<Team> getTeamList(TeamSearchCondition condition) throws Exception;
	int getTemaListCnt(TeamSearchCondition condition) throws Exception;
	String changeAges(Boolean age20s, Boolean age30s, Boolean age40s, Boolean age50s, Boolean age60Plus) throws Exception;
	String changeDays(Boolean dayMon, Boolean dayTue, Boolean dayWed, Boolean dayThu, Boolean dayFri, Boolean daySat, Boolean daySun) throws Exception;
	String changeRegions(String region1, String region2, String region3) throws Exception;
	String changeTimes(Boolean time0609, Boolean time0912, Boolean time1218, Boolean time1822, Boolean time2206) throws Exception;
}	
