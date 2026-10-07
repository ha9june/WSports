package service.match;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Part;

import dto.PersonalMatch;
import util.MatchSearchInfo;
import util.PageInfo;

public interface PersonalMatchService {
	//추천 매치 가져오기
	List<PersonalMatch> getNowMatchList(MatchSearchInfo searchInfo) throws Exception;
	//일반 매치 가져오기
	List<PersonalMatch> getNormalMatchList(MatchSearchInfo searchInfo) throws Exception;
	List<PersonalMatch> getMapMatchList(MatchSearchInfo searchInfo) throws Exception;
	
	//참가 경기 목록 페이징처리
	List<PersonalMatch> MyPagePersonalMatchList(PageInfo pageInfo,Long userId,String status,String sport, String startDate, String endDate)throws Exception;
	//내가만든 경기 목록 페이징 처리

	List<PersonalMatch>MyPageCreatedPersonalMatchList(PageInfo pageInfo,Long userId,String month,String status,String sport)throws Exception;
		

	List<PersonalMatch>MyPageCreatedPersonalMatchList(PageInfo pageInfo,Long userId,String status,String sport, String startDate, String endDate)throws Exception;
	//일반 매치 가져오기
	List<PersonalMatch> getNormalMatch(MatchSearchInfo searchInfo) throws Exception;
	List<PersonalMatch> getMapMatch(MatchSearchInfo searchInfo) throws Exception;
	List<String>getMyPageCreatedPersonalMatchDates(Long userId, String status, String sport)throws Exception;
	List<String>getMyPagePersonalMatchDates(Long userId, String status, String sport)throws Exception;
	List<String>getMyPageFavoriteDates(Long userId, String status, String sport) throws Exception;
	List<PersonalMatch>selectMyPageFavoriteList(PageInfo pageInfo,Long userId,String status,String sport, String startDate, String endDate)throws Exception;
	//마이페이지 관심경기 추가
	void insertMyPageHeartMatch(Map<String,Object>param)throws Exception;
	//마이페이지 관심경기 제거
	void deleteMyPageHeartMatch(Map<String,Object>param)throws Exception;
	//마이페이지 관심경기 0,1표시
	Boolean toggleMyPageHeartMatch(long userId,long matchId,String matchType)throws Exception;
	Boolean isHeart(long userId,long matchId,String matchType)throws Exception;
	//개인매치 상세글
	PersonalMatch getPersmalMatchDetail(Long personalMatchId) throws Exception;

	Long createPersonalMatch(PersonalMatch personalMatch,Collection<Part> parts,String realPath) throws Exception;
	Long updatePersonalMatch(PersonalMatch personalMatch,Collection<Part> parts,String realPath) throws Exception;
	void deletePersmalMatchDetail(Long personalMatchId) throws Exception;
	
}
