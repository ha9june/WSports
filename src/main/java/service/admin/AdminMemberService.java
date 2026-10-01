package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminMemberService {
	//리스트 뽑아오기
	List<Map<String, Object>> getAdminMemberList(PageInfo pageInfo, String status, String keyword) throws Exception;
}
