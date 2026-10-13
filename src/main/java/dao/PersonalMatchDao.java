package dao;

import java.util.List;
import java.util.Map;

import dto.PersonalMatch;
import util.MatchSearchInfo;

public interface PersonalMatchDao {
	//추천경기,인기경기,마감임박경기,최신경기
	List<PersonalMatch> selectNowPersonalMatchList(MatchSearchInfo searchInfo) throws Exception;	
	//4개 미만일 경우 최신 경기 가져오기
	List<PersonalMatch> selectLatestPersonalMatchList(Map<String, Object> param) throws Exception;
	//일반 매치 리스트
	List<PersonalMatch> selectNormalPersonalMatchList(MatchSearchInfo searchInfo) throws Exception;
	//지도기반 매치 리스트
	List<PersonalMatch> selectMapPersonalMatchList(MatchSearchInfo searchInfo) throws Exception;
	
	//마이페이지 경기 목록 조회
	List<PersonalMatch>selectMyPagePersonalMatchList(Map<String, Object> param) throws Exception;
	Integer selectMyPagePersonalMatchCnt(Map<String, Object> param)throws Exception;
	List<String>selectMyPageCreatedPersonalMatchDates(Map<String,Object>param)throws Exception;
	List<String>selectMyPagePersonalMatchDates(Map<String,Object>param)throws Exception;
	List<PersonalMatch>selectMyPageCreatedPersonalMatchList(Map<String,Object> param)throws Exception;
	Integer selectMyPageCreatedPersonalMatchCnt(Map<String, Object> param)throws Exception;
	
	//매치 글 조회
	PersonalMatch selectPersonalMatch(PersonalMatch personalMatch) throws Exception;

	//매치글 인서트
	Long insertPersonalMatch(PersonalMatch personalMatch) throws Exception;
	Long updatePersonalMatch(PersonalMatch personalMatch) throws Exception;
	Long updatePersonalMatchStatue(PersonalMatch personalMatch) throws Exception;

	
	//관리자 경기수 세기 - 개인
	Long selectMatchCntPersonal() throws Exception;

	
	//스케줄러
	//마감 지난 최소 인원 미달 경기
	List<PersonalMatch> selectExpiredUnderMin() throws Exception;
	//최소 인원 미달 경기 취소
	int updateStatusToUnderMinCancel(Long personalMatchId) throws Exception;
	//최소인원 충족으로 인한 모집마감 조회
	List<PersonalMatch> selectExpiredSuccess() throws Exception;
	int updateStatusToExpired(Long personalMatchId) throws Exception;
	

	List<PersonalMatch> selectFinishedSuccess() throws Exception;
	int updateStatusToFinished(Long personalMatchId) throws Exception;
	
	
	int updateStatusCancelOfHost(Long personalMatchId) throws Exception;
	int updateStatusDeleteOfAdmin(Long personalMatchId) throws Exception;
	

}
