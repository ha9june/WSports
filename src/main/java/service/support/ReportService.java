package service.support;

import java.util.List;
import java.util.Map;

import dto.Report;
import util.PageInfo;

public interface ReportService {
	void write(Report report) throws Exception;
	List<Map<String,Object>> reportList(PageInfo pageInfo, long userId, String status) throws Exception;
}
