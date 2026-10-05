package dao;

import java.util.List;
import java.util.Map;

import dto.PersonalMatch;

public interface FavoriteDao {
	void insertMyPageHeartMatch(Map<String,Object>param)throws Exception;
	void deleteMyPageHeartMatch(Map<String,Object>param)throws Exception;
	Long selectMyPageHeartMatchExists(Map<String,Object>param)throws Exception;
	List<PersonalMatch>selectMyPageFavoriteList(Map<String,Object> param)throws Exception;
	Integer selectMyPageFavoriteCnt(Map<String, Object> param)throws Exception;
}
