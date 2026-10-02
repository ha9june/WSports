package service.match;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import dto.PersonalMatch;
import util.PageInfo;

public interface PersonalMatchService {
	//추천 매치 가져오기
	List<PersonalMatch> getRecomandMatch() throws Exception;
	//일반 매치 가져오기
	List<PersonalMatch> getNormalMatch(Integer page) throws Exception;
	List<PersonalMatch> getMapMatch(Map<String,Object> latlong) throws Exception;
	
	
	//페이징처리
	List<PersonalMatch> MyPagePersonalMatchList(PageInfo pageInfo, long userId, String month)throws Exception;

	//개인매치 상세글
	Map<String,Object> getPersmalMatchDetail(Integer personalMatchId) throws Exception;

}
