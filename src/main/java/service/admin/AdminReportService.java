package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminReportService {
	//관리자 신고 리스트
	List<Map<String, Object>> getAdminReportList(PageInfo pageInfo, String status) throws Exception;
	//관리자 신고조치 답변
	void AdminReportAnswer(Long reportId, String answer, Long adminId) throws Exception;
	//신고 세부 정보
	Map<String, Object> getAdminReportDetail(Long reportId) throws Exception;
}
