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
public class AdminSettlementTeam extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminSettlementTeam() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminSettlementService service = new AdminSettlementServiceImpl();
		try {
			String dateParam = request.getParameter("date");
			LocalDate date;
			if(dateParam == null) {
				date = LocalDate.now();
			}else {
				date = LocalDate.parse(dateParam);
			}
			LocalDate prevDate = date.minusDays(1);
			LocalDate nextDate = date.plusDays(1);
			
			request.setAttribute("date", date);
			request.setAttribute("prevDate", prevDate);
			request.setAttribute("nextDate", nextDate);
			
			Integer teamwait = service.getTeamSettlementWait();
			Long teamwaitmoney = service.getTeamSettlementWaitMoney();
			List<Map<String, Object>> teamwaitlist = service.getTeamSettlementWaitList();
			List<Map<String, Object>> teamfinish = service.getTeamSettlementFinishList();
			List<Map<String, Object>> teamday = service.getTeamSettlementDayList(date);
			
			//팀
			request.setAttribute("teamwait", teamwait);	//정산대기 숫자
			request.setAttribute("teamwaitmoney", teamwaitmoney==null? 0:teamwaitmoney);	//지급 예정 금액
			
			request.setAttribute("date", date);
			request.setAttribute("prevDate", date.minusDays(1));
			request.setAttribute("nextDate", date.plusDays(1));
			
			request.setAttribute("teamwaitlist", teamwaitlist);	//정산 대기 리스트
			request.setAttribute("teamfinish", teamfinish);	//지급 완료 리스트
			request.setAttribute("teamday", teamday);	//날짜별 리스트
			
			request.getRequestDispatcher("/jsp/admin/adminSettlementTeam.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "정산관리 목록 조회 오류");
		}
	}

}
