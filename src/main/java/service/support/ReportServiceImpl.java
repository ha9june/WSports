package service.support;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.ReportDao;
import dao.ReportDaoImpl;
import dto.Report;
import util.PageInfo;

public class ReportServiceImpl implements ReportService {
	private ReportDao reportDao;
	
	public ReportServiceImpl() {
		reportDao = new ReportDaoImpl();
	}
	
	@Override
	public void writeReport(Report report) throws Exception {
		reportDao.insertReport(report);
		
	}

	@Override
	public List<Map<String,Object>> reportList(PageInfo pageInfo, long userId, String status) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		
		if("WAIT".equals(status)) param.put("status", "처리대기");
		if("DONE".equals(status)) param.put("status", "처리완료");
		
		Integer reportCnt = reportDao.selectReportCnt(param);
		Integer allPage = (int)Math.ceil(reportCnt/10.0);
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
		return reportDao.selectReportList(param);
	}

	@Override
	public Map<String, Object> detailReport(Long reportId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("reportId", reportId);
		return reportDao.selectDetailReport(param);
	}
}
