package service.support;

import java.util.List;
import java.util.Map;

import util.PageInfo;

public interface NoticeService {
	List<Map<String,Object>> noticeList(PageInfo pageInfo, String keyword, String type) throws Exception;
	Map<String, Object> detailNotice(Long noticeId) throws Exception;
}
