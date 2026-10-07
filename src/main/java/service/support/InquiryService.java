package service.support;

import java.util.List;
import java.util.Map;

import dto.Inquiry;
import util.PageInfo;

public interface InquiryService {
	void write(Inquiry inquiry) throws Exception;
	List<Map<String,Object>> inquiryList(PageInfo pageInfo, long userId, String status) throws Exception;
}
