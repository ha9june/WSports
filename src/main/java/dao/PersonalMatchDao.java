package dao;

import java.util.List;
import java.util.Map;

import dto.PersonalMatch;
import util.MatchSearchInfo;

public interface PersonalMatchDao {
	List<PersonalMatch> selectNowPersonalMatchList(MatchSearchInfo searchInfo) throws Exception;	
	List<PersonalMatch> selectNormalPersonalMatchList(MatchSearchInfo searchInfo) throws Exception;
	List<PersonalMatch> selectMapPersonalMatchList(MatchSearchInfo searchInfo) throws Exception;
	
	//마이페이지 경기 목록 조회
	List<PersonalMatch>selectMyPagePersonalMatchList(Map<String, Object> param) throws Exception;
	Integer selectMyPagePersonalMatchCnt(Map<String, Object> param)throws Exception;
	List<String>selectMyPageCreatedPersonalMatchDates(Map<String,Object>param)throws Exception;
	List<String>selectMyPagePersonalMatchDates(Map<String,Object>param)throws Exception;
	List<PersonalMatch>selectMyPageCreatedPersonalMatchList(Map<String,Object> param)throws Exception;
	Integer selectMyPageCreatedPersonalMatchCnt(Map<String, Object> param)throws Exception;
	
	//매치 글 조회
	Map<String,Object> selectPersonalMatch(Integer personaMatchId) throws Exception;


}
