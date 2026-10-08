package service.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.InquiryDao;
import dao.InquiryDaoImpl;
import dto.Inquiry;
import util.PageInfo;

public class InquiryServiceImpl implements InquiryService {
	private InquiryDao inquiryDao;
	
	public InquiryServiceImpl() {
		inquiryDao = new InquiryDaoImpl();
	}
	
	@Override
	public void writeInquiry(Inquiry inquiry) throws Exception {
		inquiryDao.insertInquiry(inquiry);
		
	}

	@Override
	public List<Map<String, Object>> inquiryList(PageInfo pageInfo, long userId, String status) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		
		if("WAIT".equals(status)) param.put("status", "답변대기");
		if("DONE".equals(status)) param.put("status", "답변완료");
		
		Integer inquiryCnt = inquiryDao.selectInquiryCnt(param);
		Integer allPage = (int)Math.ceil(inquiryCnt/10.0);
		if (allPage == 0) allPage = 1;
		
		if (pageInfo.getCurPage() == null || pageInfo.getCurPage() < 1) pageInfo.setCurPage(1);
		if (pageInfo.getCurPage() > allPage) pageInfo.setCurPage(allPage);
		
		Integer startPage = (pageInfo.getCurPage()-1)/10*10+1;
		Integer endPage = startPage+9;
		if (endPage > allPage) endPage = allPage;
		
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		
		Integer row = (pageInfo.getCurPage()-1)*10+1;
		param.put("row", row-1);
		return inquiryDao.selectInquiryList(param);
	}
}
