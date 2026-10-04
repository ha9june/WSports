package dao;

import java.util.List;
import java.util.Map;

import dto.PersonalMatch;
import util.MatchSearchInfo;

public interface PersonalMatchDao {
	List<PersonalMatch> selectPersonalMatchList() throws Exception;
	List<PersonalMatch> selectNormalPersonalMatchList(MatchSearchInfo searchInfo) throws Exception;
	List<PersonalMatch> selectMapPersonalMatchList(MatchSearchInfo searchInfo) throws Exception;
	
	//마이페이지 경기 목록 조회
	List<PersonalMatch>selectMyPagePersonalMatchList(Map<String, Object> param) throws Exception;
	//(페이징용) 전체 마이페이지 경기 목록 개수 조회
	Integer selectMyPagePersonalMatchCnt(Map<String, Object> param)throws Exception;

	//마이페이지 내가만든 경기 목록 조회
	List<PersonalMatch>selectMyPageCreatedPersonalMatchList(Map<String,Object> param)throws Exception;
	//(페이징)마이페이지 내가만든 경기 목록 개수 조회
	Integer selectMyPageCreatedPersonalMatchCnt(Map<String, Object> param)throws Exception;
	Map<String,Object> selectPersonalMatch(Integer personaMatchId) throws Exception;


}
