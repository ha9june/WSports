package service.match;

import java.util.List;

import dto.TeamMatch;
import util.PageInfo;

public interface TeamMatchService {
	List<TeamMatch>selectMypageTeamMatchList(PageInfo pageInfo,Long userId,String status,String sport, String startDate, String endDate)throws Exception;
	List<String>getMyPageTeamMatchDates(Long userId, String status, String sport)throws Exception;
}
