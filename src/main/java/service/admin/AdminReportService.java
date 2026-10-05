package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminReportService {
	List<Map<String, Object>> getAdminReportList(PageInfo pageInfo, String status) throws Exception;
	//관리자 신고조치 답변
	void AdminReportAnswer(Long reportId, String answer, Long adminId) throws Exception;
	Map<String, Object> getAdminReportDetail(Long reportId) throws Exception;
}
