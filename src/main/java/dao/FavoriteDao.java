package dao;

import java.util.Map;

public interface FavoriteDao {
	void insertMyPageHeartMatch(Map<String,Object>param)throws Exception;
	void deleteMyPageHeartMatch(Map<String,Object>param)throws Exception;
	Long selectMyPageHeartMatchExists(Map<String,Object>param)throws Exception;
}
