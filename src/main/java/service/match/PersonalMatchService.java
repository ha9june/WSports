package service.match;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import dto.PersonalMatch;
import util.PageInfo;

public interface PersonalMatchService {
	List<PersonalMatch> getRecomandMatch() throws Exception;
	//페이징처리
	List<PersonalMatch> MyPagePersonalMatchList(PageInfo pageInfo, long userId, String month)throws Exception;



}
