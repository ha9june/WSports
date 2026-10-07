package service.support;

import dao.InquiryDao;
import dao.InquiryDaoImpl;
import dto.Inquiry;

public class InquiryServiceImpl implements InquiryService {
	private InquiryDao inquiryDao;
	
	public InquiryServiceImpl() {
		inquiryDao = new InquiryDaoImpl();
	}
	
	@Override
	public void write(Inquiry inquiry) throws Exception {
		inquiryDao.insertInquiry(inquiry);
		
	}

}
