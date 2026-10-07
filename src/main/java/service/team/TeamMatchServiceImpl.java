package service.team;

import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDateTime;
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
		teamMatchDao.insertTeamMatch(teamMatch);
		return teamMatch.getTeamMatchId();
	}

	@Override
	public TeamMatch getTeamMatch(Long teamMatchId) throws Exception {
		return teamMatchDao.selectTeamMatch(teamMatchId);
	}

	@Override
	public String getTeamMatchState(TeamMatch teamMatch) throws Exception {
		TeamMatchService teamMatchService = new TeamMatchServiceImpl();
	    TeamMatchParticipantService teamMatchParticipantService = new TeamMatchParticipantServiceImpl();
	    TeamUserService teamUserService = new TeamUserServiceImpl();
	    
		try {
			
			//state
		    
		    //작성자 취소 // 디비에서 상태값으로 가져옴 처리 X
		    //인원 미달 취소 //마감 시간에 팀 안 차면 자동으로 처리되게. 디비도? 그게 되나
		    //경기 종료 //모집 마감 상태였다가 경기 시간 지나면 경기 종료

			String state = "";
			LocalDateTime now = LocalDateTime.now();
			
			LocalDateTime matchStart = LocalDateTime.of(teamMatch.getMatchDate(), teamMatch.getStartTime());
			LocalDateTime matchEnd   = LocalDateTime.of(teamMatch.getMatchDate(), teamMatch.getEndTime());
			LocalDateTime deadline   = teamMatch.getDeadline();
			
			boolean pastDeadline = !deadline.isAfter(now);    // 마감 시각이 되었거나 지남 (deadline ≤ now)
			boolean started      = !matchStart.isAfter(now);  // 경기 시작됨
			boolean finished     = !matchEnd.isAfter(now);    // 경기 끝남
			
			//모집 마감 //팀 구해짐.

			return state;
		}catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
}
