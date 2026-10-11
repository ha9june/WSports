package service.support;

import java.util.List;
import java.util.Map;

import dto.Report;
import util.PageInfo;

public interface ReportService {
	void writeReport(Report report) throws Exception;
	List<Map<String,Object>> reportList(PageInfo pageInfo, long userId, String status) throws Exception;
	Map<String, Object> detailReport(Long reportId) throws Exception;
}
