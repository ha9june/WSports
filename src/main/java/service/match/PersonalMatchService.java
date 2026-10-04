package service.match;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import dto.PersonalMatch;
import util.MatchSearchInfo;
import util.PageInfo;

public interface PersonalMatchService {
	//추천 매치 가져오기
	List<PersonalMatch> getRecomandMatch() throws Exception;
	
	//참가 경기 목록 페이징처리
	List<PersonalMatch> MyPagePersonalMatchList(PageInfo pageInfo, long userId, String month,String status,String sport)throws Exception;
	//일반 매치 가져오기
	List<PersonalMatch> getNormalMatch(MatchSearchInfo searchInfo) throws Exception;
	List<PersonalMatch> getMapMatch(MatchSearchInfo searchInfo) throws Exception;
	
	
	//페이징처리
	List<PersonalMatch> MyPagePersonalMatchList(PageInfo pageInfo, long userId, String month)throws Exception;
	//내가만든 경기 목록 페이징 처리
	List<PersonalMatch>MyPageCreatedPersonalMatchList(PageInfo pageInfo,Long userId,String month,String status,String sport)throws Exception;
	//개인매치 상세글
	Map<String,Object> getPersmalMatchDetail(Integer personalMatchId) throws Exception;

}
