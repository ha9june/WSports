package controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.User;
import service.admin.AdminSettlementService;
import service.admin.AdminSettlementServiceImpl;

/**
 * Servlet implementation class AdminDetailSettlement
 */
@WebServlet("/admin/settlement/detail")
public class AdminSettlementDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminSettlementDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		AdminSettlementService service = new AdminSettlementServiceImpl();
		try {
			Long matchId = Long.parseLong(request.getParameter("matchId"));
			String matchType = request.getParameter("matchType");

			Map<String, Object> detail;
			
			if ("team".equals(matchType)) {
				detail = service.getTeamSettlementDetail(matchId);
			} else {
				detail = service.getPersonalSettlementDetail(matchId);
			}
			request.setAttribute("detail", detail);
			request.setAttribute("matchId", matchId);
			request.setAttribute("isTeam", "team".equals(matchType));
			
			request.getRequestDispatcher("/jsp/admin/adminSettlementDetail.jsp").forward(request, response);
			
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "정산관리 목록 조회 오류");
			request.getRequestDispatcher("/jsp/admin/adminSettlementDetail.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminSettlementService service = new AdminSettlementServiceImpl(); 
		
		String idParam = request.getParameter("settlementId");
		String matchId = request.getParameter("matchId");
		String matchType = request.getParameter("matchType");
		
		if(idParam == null || idParam.isEmpty() || matchId == null || matchId.isEmpty()) {
			response.sendRedirect(request.getContextPath()+"/admin/settlement/person");
			return;
		}
		
		long settlementId = Long.parseLong(idParam);

		HttpSession session = request.getSession(false);
		User loginUser = (session == null) ? null : (User) session.getAttribute("user");
		Long adminId = (loginUser == null) ? null : loginUser.getUserId();
		
		try {
			if ("team".equals(matchType)) {
				service.updateTeamSettlement(settlementId, adminId);
			} else {
				service.updatePersonalSettlement(settlementId, adminId);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 새로고침 시 중복 처리 방지
		response.sendRedirect(request.getContextPath() + "/admin/settlement/detail?matchId=" + matchId + "&matchType=" + matchType);
	}

}
