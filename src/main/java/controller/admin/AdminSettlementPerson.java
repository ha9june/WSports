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
public class AdminSettlementPerson extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminSettlementPerson() {
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
			
			Integer personwait = service.getPersonalSettlementWait();
			Long personwaitmoney = service.getPersonalSettlementWaitMoney();
			List<Map<String, Object>> personwaitlist = service.getPersonalSettlementWaitList();
			List<Map<String, Object>> personfinish = service.getPersonalSettlementFinishList();
			List<Map<String, Object>> personday = service.getPersonalSettlementDayList(date);
											
			//개인
			request.setAttribute("personwait", personwait);	//정산대기 숫자
			request.setAttribute("personwaitmoney", personwaitmoney==null? 0:personwaitmoney);	//지급 예정 금액
			
			request.setAttribute("date", date);
			request.setAttribute("prevDate", date.minusDays(1));
			request.setAttribute("nextDate", date.plusDays(1));
			
			request.setAttribute("personwaitlist", personwaitlist);	//정산 대기 리스트
			request.setAttribute("personfinish", personfinish);	//지급 완료 리스트
			request.setAttribute("personday", personday);	//날짜별 리스트

			request.getRequestDispatcher("/jsp/admin/adminSettlementPerson.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "정산관리 목록 조회 오류");
			//request.getRequestDispatcher("/common/error.jsp").forward(request, response);
		}
	}


}
