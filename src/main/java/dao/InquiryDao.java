package dao;

import java.util.List;
import java.util.Map;

import dto.Inquiry;

public interface InquiryDao {
	void insertInquiry(Inquiry inquiry) throws Exception;
	//관리자 문의관리 개수 
	Integer selectAdminInquiryCnt(Map<String, Object> param) throws Exception;
	//관리자 문의관리 리스트
	List<Map<String, Object>> selectAdminInquiryList(Map<String, Object> param) throws Exception;
	//관리자 문의 답변 
	Integer updateAdminInquiryAnswer(Map<String, Object> param) throws Exception;
	//특정 문의 상세
	Map<String, Object> selectAdminInquiryDetail(Long inquiryId) throws Exception;
	
	List<Map<String, Object>> selectInquiryList(Map<String, Object> param) throws Exception;
	Integer selectInquiryCnt(Map<String, Object> param) throws Exception;
}
