package service.match;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import dto.PersonalMatch;
import util.PageInfo;

public interface PersonalMatchService {
	List<PersonalMatch> getRecomandMatch() throws Exception;
	
	//참가 경기 목록 페이징처리
	List<PersonalMatch> MyPagePersonalMatchList(PageInfo pageInfo, long userId, String month,String status,String sport)throws Exception;

	//내가만든 경기 목록 페이징 처리
	List<PersonalMatch>MyPageCreatedPersonalMatchList(PageInfo pageInfo,Long userId,String month,String status,String sport)throws Exception;

}
