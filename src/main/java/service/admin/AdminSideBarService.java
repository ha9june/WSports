package service.admin;

import java.util.Map;

public interface AdminSideBarService {
	Map<String, Object> getAdminStats() throws Exception;
	Integer getSettlementWaitCnt() throws Exception;
	Integer getReportWaitCnt() throws Exception;
	Integer getInquiryWaitCnt() throws Exception;
}
