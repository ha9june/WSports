package service.support;

import dao.ReportDao;
import dao.ReportDaoImpl;
import dto.Report;

public class ReportServiceImpl implements ReportService {
	private ReportDao reportDao;
	
	public ReportServiceImpl() {
		reportDao = new ReportDaoImpl();
	}
	
	@Override
	public void write(Report report) throws Exception {
		reportDao.insertReport(report);
		
	}

}
