package dao;

import java.util.List;
import java.util.Map;

public interface UserPenaltyDao {
	Integer selectAdminMemberCnt(Map<String, Object> param) throws Exception;
	List<Map<String, Object>> selectAdminMemberList(Map<String, Object> param) throws Exception;
}
