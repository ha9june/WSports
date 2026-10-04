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

import dto.TeamSettlement;
import service.admin.AdminSettlementService;
import service.admin.AdminSettlementServiceImpl;

/**
 * Servlet implementation class AdminSettlementTeam
 */
@WebServlet("/admin/settlement/team")
public class AdminTeamSettlement extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminTeamSettlement() {
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
			
			Integer teamwait = service.getTeamSettlementWait();
			Long teamwaitmoney = service.getTeamSettlementWaitMoney();
			List<Map<String, Object>> teamwaitlist = service.getTeamSettlementWaitList();
			List<Map<String, Object>> teamfinish = service.getTeamSettlementFinishList();
			List<Map<String, Object>> teamday = service.getTeamSettlementDayList(startDate, endDate);
			List<Map<String, Object>> displayList = service.getTeamSettlementList();
			
			//팀
			request.setAttribute("teamwait", teamwait);	//정산대기 숫자
			request.setAttribute("teamwaitmoney", teamwaitmoney==null ? 0:teamwaitmoney);	//지급 예정 금액
			request.setAttribute("teamwaitlist", teamwaitlist);	//정산 대기 리스트
			request.setAttribute("teamfinish", teamfinish);	//지급 완료 리스트
			request.setAttribute("teamday", teamday);	//날짜별 리스트
			request.setAttribute("displayList", displayList); //모든 리스트
			
			request.setAttribute("startDate", startDate);  // 달력에 표시할 시작일
			request.setAttribute("endDate", endDate);      // 달력에 표시할 종료일
			
			request.getRequestDispatcher("/jsp/admin/adminTeamSettlement.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "정산관리 목록 조회 오류");
			request.getRequestDispatcher("/jsp/admin/adminTeamSettlement.jsp").forward(request, response);
		}
	}

}
