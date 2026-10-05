package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminInquiryService {
	//관리자 신고 리스트
	List<Map<String, Object>> getAdminInquiryList(PageInfo pageInfo, String status) throws Exception;
	//관리자 신고조치 답변
	void AdminInquiryAnswer(Long inquiryId, String answer, Long adminId) throws Exception;
	//신고 세부 정보
	Map<String, Object> getAdminInquiryDetail(Long inquiryId) throws Exception;
}
