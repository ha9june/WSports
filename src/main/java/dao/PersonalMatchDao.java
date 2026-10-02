package dao;

import java.util.List;
import java.util.Map;

import dto.PersonalMatch;

public interface PersonalMatchDao {
	List<PersonalMatch> selectPersonalMatchList() throws Exception;
	List<PersonalMatch> selectNormalPersonalMatchList(Integer startIndex) throws Exception;
	List<PersonalMatch> selectMapPersonalMatchList(Map<String,Object> latlong) throws Exception;
	
	//페이징용 마이페이지 경기 목록 조회
	List<PersonalMatch>selectMyPagePersonalMatchList(Map<String, Object> param) throws Exception;
	//페이징용 전체 마이페이지 경기 목록 개수 조회
	Integer selectMyPagePersonalMatchCnt(Map<String, Object> param)throws Exception;

	Map<String,Object> selectPersonalMatch(Integer personaMatchId) throws Exception;


}
