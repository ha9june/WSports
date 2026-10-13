package controller.settlement;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.User;
import service.settlement.SettlementService;
import service.settlement.SettlementServiceImpl;
import util.PageInfo;

/**
 * Servlet implementation class SettlementPersonalList
 */
@WebServlet("/settlement/personal/list")
public class SettlementPersonalList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SettlementPersonalList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User loginUser = (User) request.getSession().getAttribute("user");
		Long userId = loginUser.getUserId();
		
		// 검색 기능
		String period = request.getParameter("period");
		if (period == null || period.isEmpty()) period = "3m";
		String keyword = request.getParameter("keyword");
		String settlementStatus = request.getParameter("settlementStatus");
		if (settlementStatus == null || settlementStatus.isEmpty()) settlementStatus = "ALL";
		
		String sPage = request.getParameter("page");
		Integer page = 1;
		if(sPage!=null && !sPage.isEmpty()) {
			page = Integer.parseInt(sPage);
		}
		
		PageInfo pageInfo = new PageInfo(page);
		
		// 계좌정보
		String accountNo = loginUser.getAccountNumber();
		String maskedAccount = null;
		if(accountNo!=null && !accountNo.isEmpty()) {
			int len = accountNo.length();
			if(len<=3) {
				maskedAccount = accountNo;
			} else {
				int head = len>7 ? 4 : 0;
				StringBuilder sb = new StringBuilder(accountNo.substring(0,head));
				for(int i=0; i<len-head-3; i++) sb.append('*');
				maskedAccount = sb.append(accountNo.substring(len-3)).toString();
			}
		}
		
		SettlementService service = new SettlementServiceImpl();
		try {
			request.setAttribute("bankName", loginUser.getBankName());
			request.setAttribute("maskedAccount", maskedAccount);

			List<Map<String,Object>> personalSettlementList = service.MypagePersonalSettlementList(pageInfo, keyword, userId, settlementStatus, period);
			request.setAttribute("personalSettlementList", personalSettlementList);
	        request.setAttribute("pageInfo", pageInfo);
	        
	        Map<String, Object> summary = service.MypagePersonalSettlementSummary(keyword, userId, period);
	        request.setAttribute("summary", summary);
	        request.getRequestDispatcher("/jsp/settlement/personalSettlementList.jsp").forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
