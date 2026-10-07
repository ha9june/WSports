package dao;

import dto.Report;
import java.util.List;
import java.util.Map;

public interface ReportDao {
	void insertReport(Report report) throws Exception;
	//관리자 신고관리 개수 
	Integer selectAdminReportCnt(Map<String, Object> param) throws Exception;
	//관리자 신고관리 리스트
	List<Map<String, Object>> selectAdminReportList(Map<String, Object> param) throws Exception;
	//관리자 신고 답변 
	Integer updateAdminReportAnswer(Map<String, Object> param) throws Exception;
	//특정 신고 상세
	Map<String, Object> selectAdminReportDetail(Long reportId) throws Exception;
	//관리자 사이드바 - 처리대기인 갯수
	Integer selectAdminReportWaitCnt() throws Exception;
	List<Map<String, Object>> selectReportList(Map<String, Object> param) throws Exception;
	Integer selectReportCnt(Map<String, Object> param) throws Exception;
}
