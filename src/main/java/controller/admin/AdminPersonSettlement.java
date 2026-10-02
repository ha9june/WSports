package controller.admin;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PersonalSettlement;
import dto.TeamSettlement;
import service.admin.AdminSettlementService;
import service.admin.AdminSettlementServiceImpl;

/**
 * Servlet implementation class AdminSettlement
 */
@WebServlet("/admin/settlement/person")
public class AdminPersonSettlement extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPersonSettlement() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminSettlementService service = new AdminSettlementServiceImpl();
		try {
			// 조회 기간 받기 (없으면 최근 7일)
			String startParam = request.getParameter("startDate");
			String endParam = request.getParameter("endDate");

			LocalDate endDate = (endParam == null || endParam.isEmpty()) ? LocalDate.now() : LocalDate.parse(endParam);
			LocalDate startDate = (startParam == null || startParam.isEmpty()) ? endDate.minusDays(6) : LocalDate.parse(startParam);

			// 시작일이 종료일보다 늦으면 서로 바꿈
			if (startDate.isAfter(endDate)) {
				LocalDate temp = startDate;
				startDate = endDate;
				endDate = temp;
			}
			
			Integer personwait = service.getPersonalSettlementWait();
			Long personwaitmoney = service.getPersonalSettlementWaitMoney();
			List<Map<String, Object>> personwaitlist = service.getPersonalSettlementWaitList();
			List<Map<String, Object>> personfinish = service.getPersonalSettlementFinishList();
			List<Map<String, Object>> personday = service.getPersonalSettlementDayList(startDate, endDate);
					
			//개인
			request.setAttribute("personwait", personwait);	//정산대기 숫자
			request.setAttribute("personwaitmoney", personwaitmoney==null? 0:personwaitmoney);	//지급 예정 금액
			request.setAttribute("personwaitlist", personwaitlist);	//정산 대기 리스트
			request.setAttribute("personfinish", personfinish);	//지급 완료 리스트
			request.setAttribute("personday", personday);	//날짜별 리스트
	
			
			request.setAttribute("startDate", startDate);  // 달력에 표시할 시작일
			request.setAttribute("endDate", endDate);      // 달력에 표시할 종료일
			
			request.getRequestDispatcher("/jsp/admin/adminPersonSettlement.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "정산관리 목록 조회 오류");
			request.getRequestDispatcher("/jsp/admin/adminTeamSettlement.jsp").forward(request, response);
		}
	}


}
