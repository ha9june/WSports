package service.admin;

import java.util.List;
import java.util.Map;

import dto.PageInfo;

public interface AdminInquiryService {
	//관리자 문의 리스트
	List<Map<String, Object>> getAdminInquiryList(PageInfo pageInfo, String status) throws Exception;
	//관리자 문의조치 답변
	void AdminInquiryAnswer(Long inquiryId, String answer, Long adminId) throws Exception;
	//문의 세부 정보
	Map<String, Object> getAdminInquiryDetail(Long inquiryId) throws Exception;
}
