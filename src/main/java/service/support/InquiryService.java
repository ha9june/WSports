package service.support;

import java.util.List;
import java.util.Map;

import dto.Inquiry;
import util.PageInfo;

public interface InquiryService {
	void writeInquiry(Inquiry inquiry) throws Exception;
	List<Map<String,Object>> inquiryList(PageInfo pageInfo, long userId, String status) throws Exception;
	Map<String, Object> detailInquiry(Long inquiryId) throws Exception;
}
