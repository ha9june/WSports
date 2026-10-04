package service.team;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Part;

import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamUserDao;
import dao.TeamUserDaoImpl;
import dto.Team;
import dto.TeamSearchCondition;
import dto.TeamUser;

public class TeamServiceImpl implements TeamService {

	TeamDao teamDao;
	TeamUserDao teamUserDao;
	
	public TeamServiceImpl() {
		teamDao = new TeamDaoImpl();
		teamUserDao = new TeamUserDaoImpl();
	}
	
	private String fileUpload(String uploadPath, Part file) throws Exception {
//	    if (file == null || file.getSize() == 0) return null;
//
//	    String original = Paths.get(file.getSubmittedFileName()).getFileName().toString();
//	    String fileName = UUID.randomUUID() + "_" + original;   // 이름 충돌 방지
//
//	    File dir = new File(uploadPath);
//	    if (!dir.exists()) dir.mkdirs();
//
//	    file.write(uploadPath + File.separator + fileName);
//	    return fileName;
		
		String fileName = Paths.get(file.getSubmittedFileName()).getFileName().toString();		
		if(fileName != null && !fileName.isEmpty()) {
			File uploadDir = new File(uploadPath);			
			if(!uploadDir.exists()) uploadDir.mkdir();			
			file.write(uploadPath+File.separator+fileName);		
		}		
		return fileName;
	}

	@Override
	public Long makeTeam(Team team, long userId, String realPath, Part profileImage, Part activityImg1, Part activityImg2, Part activityImg3,
			Part activityImg4, Part activityImg5) throws Exception {
		if(profileImage != null) team.setProfileImage(fileUpload(realPath, profileImage));
		if(activityImg1 != null) team.setActivityImage1(fileUpload(realPath, activityImg1));
		if(activityImg2 != null) team.setActivityImage2(fileUpload(realPath, activityImg2));
		if(activityImg3 != null) team.setActivityImage3(fileUpload(realPath, activityImg3));
		if(activityImg4 != null) team.setActivityImage4(fileUpload(realPath, activityImg4));
		if(activityImg5 != null) team.setActivityImage5(fileUpload(realPath, activityImg5));
		
		Long teamId = teamDao.insertTeam(team);
		TeamUser teamUser = new TeamUser();
		teamUser.setTeamId((long)teamId);
		teamUser.setUserId(userId);
		teamUser.setTeamRole("CAPTAIN");
		teamUser.setWithdrawn(false);
		teamUserDao.insertTeamUser(teamUser);

		return teamId;
		
	}

	@Override
	public List<Team> getTeamList(TeamSearchCondition condition) throws Exception {
		List<Team> teamList =  teamDao.selectTeamList(condition);
		int teamCnt = teamDao.selectTeamlistCnt(condition);
		for(int i=0; i<teamList.size(); i++) {
			teamList.get(i).setAges(changeAges(teamList.get(i).getAge20s() , teamList.get(i).getAge30s(), teamList.get(i).getAge40s(), teamList.get(i).getAge50s(), teamList.get(i).getAge60Plus()));
			teamList.get(i).setDays(changeDays(teamList.get(i).getDayMon(), teamList.get(i).getDayTue(), teamList.get(i).getDayWed(), teamList.get(i).getDayThu(), teamList.get(i).getDayFri(), teamList.get(i).getDaySat(), teamList.get(i).getDaySun()));
			teamList.get(i).setRegions(changeRegions(teamList.get(i).getRegion1(), teamList.get(i).getRegion2(), teamList.get(i).getRegion3()));
			teamList.get(i).setTimes(changeTimes(teamList.get(i).getTime0609(), teamList.get(i).getTime0912(), teamList.get(i).getTime1218(), teamList.get(i).getTime1822(), teamList.get(i).getTime2206()));
		}
		return teamList;
	}
	
	@Override
	public int getTemaListCnt(TeamSearchCondition condition) throws Exception {
		return teamDao.selectTeamlistCnt(condition);
	}

	@Override
	public String changeAges(Boolean age20s, Boolean age30s, Boolean age40s, Boolean age50s, Boolean age60Plus)
			throws Exception {

		
		// 1. 연령무관 플래그가 true면 반복문까지 가지 않고 바로 반환
	    if (Boolean.TRUE.equals(age60Plus)) return "연령 무관";

	    boolean[] f = {
	        Boolean.TRUE.equals(age20s), Boolean.TRUE.equals(age30s),
	        Boolean.TRUE.equals(age40s), Boolean.TRUE.equals(age50s)
	    };
	    String[] label = {"20", "30", "40", "50"};

	    // 2. 반복문으로 구간 묶기 (앞에서 설명한 부분)
	    List<String> parts = new ArrayList<>();
	    int i = 0;
	    while (i < f.length) {
	        if (!f[i]) { i++; continue; }
	        int start = i;
	        while (i + 1 < f.length && f[i + 1]) i++; //구간 끝까지 이동
	        parts.add(start == i ? label[start] + "대"
	                             : label[start] + "~" + label[i] + "대");
	        i++;
	    }

	    // 3. 아무것도 선택 안 했거나 4개 전부 선택했으면 사실상 무관
	    if (parts.isEmpty() || (f[0] && f[1] && f[2] && f[3])) return "연령 무관";

	    return String.join("·", parts);
		
		
	}

	@Override
	public String changeDays(Boolean dayMon, Boolean dayTue, Boolean dayWed, Boolean dayThu,
	                         Boolean dayFri, Boolean daySat, Boolean daySun) throws Exception {
	    boolean[] f = {
	        Boolean.TRUE.equals(dayMon), Boolean.TRUE.equals(dayTue),
	        Boolean.TRUE.equals(dayWed), Boolean.TRUE.equals(dayThu),
	        Boolean.TRUE.equals(dayFri), Boolean.TRUE.equals(daySat),
	        Boolean.TRUE.equals(daySun)
	    };
	    String[] label = {"월", "화", "수", "목", "금", "토", "일"};

	    boolean weekday = f[0] && f[1] && f[2] && f[3] && f[4];
	    boolean weekend = f[5] && f[6];
	    boolean anyWeekday = f[0] || f[1] || f[2] || f[3] || f[4];
	    boolean anyWeekend = f[5] || f[6];

	    if (!anyWeekday && !anyWeekend) return "요일 무관";
	    if (weekday && weekend) return "요일 무관";
	    if (weekday && !anyWeekend) return "평일";
	    if (weekend && !anyWeekday) return "주말";

	    List<String> parts = new ArrayList<>();
	    for (int i = 0; i < f.length; i++) {
	        if (f[i]) parts.add(label[i]);
	    }
	    return String.join("·", parts);
	}

	@Override
	public String changeRegions(String region1, String region2, String region3) {
	    List<String> list = new ArrayList<>();
	    for (String r : new String[]{region1, region2, region3}) {
	        if (r == null || r.trim().isEmpty()) continue;
	        String[] p = r.trim().split(" ");
	        list.add(p[p.length - 1]);          // "서울시 영등포구" -> "영등포구"
	    }
	    if (list.isEmpty()) return "";
	    return list.size() == 1 ? list.get(0) : list.get(0) + " 외 " + (list.size() - 1);
	}

	@Override
	public String changeTimes(Boolean time0609, Boolean time0912, Boolean time1218, Boolean time1822, Boolean time2206) throws Exception {
		boolean[] f = {
				Boolean.TRUE.equals(time0609), Boolean.TRUE.equals(time0912), Boolean.TRUE.equals(time1218), Boolean.TRUE.equals(time1822), Boolean.TRUE.equals(time2206)
		};
		
		String[] label = {"아침", "오전", "오후", "저녁", "심야"};
		List<String> parts = new ArrayList<>();

		for (int i = 0; i < f.length; i++) {
		    if (f[i]) parts.add(label[i]);
		}

	    if (parts.isEmpty() || (f[0] && f[1] && f[2] && f[3] && f[4])) return "시간 무관";
	    
	    return String.join("·", parts);
	}


}
