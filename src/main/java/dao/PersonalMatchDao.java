package dao;

import java.util.List;
import java.util.Map;

import dto.PersonalMatch;

public interface PersonalMatchDao {
	List<PersonalMatch> selectPersonalMatchList() throws Exception;
	
	
	//마이페이지 경기 종목별 조회
	List<PersonalMatch>selectMyPagePersonalMatchsportList(Map<String,Object> param)throws Exception;
	//마이페이지 경기 목록 조회
	List<PersonalMatch>selectMyPagePersonalMatchList(Map<String, Object> param) throws Exception;
	//(페이징용) 전체 마이페이지 경기 목록 개수 조회
	Integer selectMyPagePersonalMatchCnt(Map<String, Object> param)throws Exception;

	//마이페이지 내가만든 경기 목록 조회
	List<PersonalMatch>selectMyPageCreatedPersonalMatchList(Map<String,Object> param)throws Exception;
	//(페이징)마이페이지 내가만든 경기 목록 개수 조회
	Integer selectMyPageCreatedPersonalMatchCnt(Map<String, Object> param)throws Exception;
	//마이페이지 내가만든 경기 종목별 조회
	List<PersonalMatch>selectMyPageCreatedPersonalMatchsportList(Map<String,Object> param)throws Exception;
}
