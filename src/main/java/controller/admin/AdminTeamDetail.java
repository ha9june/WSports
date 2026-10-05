package controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.AdminMemberServiceImpl;
import service.admin.AdminTeamServiceImpl;

/**
 * Servlet implementation class AdminTeamDetail
 */
@WebServlet("/admin/team/detail")
public class AdminTeamDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminTeamDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminTeamServiceImpl service = new AdminTeamServiceImpl();
		
		try {
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			Map<String, Object> teaminfo = service.getTeamInfo(teamId);
			List<Map<String, Object>> penaltylist = service.getTeamPenaltyList(teamId);
			
			String captain = service.getTeamCaptain(teamId);
			Integer membercnt = service.getTeamMemberCnt(teamId);
			String suspension = service.getTeamSuspention(teamId)> 0 ? "정지" : "정상";
			
			request.setAttribute("teaminfo", teaminfo);
			request.setAttribute("penaltylist", penaltylist);
			request.setAttribute("captain", captain);
			request.setAttribute("membercnt", membercnt);
			request.setAttribute("suspension", suspension);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "회원관리 상세 목록 조회 오류");
		}
		request.getRequestDispatcher("/jsp/admin/adminTeamDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminTeamServiceImpl service = new AdminTeamServiceImpl();
		try {
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			
			String reason = request.getParameter("reason");
			String action = request.getParameter("action");

			if ("adjust".equals(action)){
				// 패널티 점수 부여/차감
				int change = Integer.parseInt(request.getParameter("change"));
				service.AdminChangeTeamPenalty(teamId, change, reason);
			}
			else if ("permanent".equals(action)) {
				// 영구 정지 (기간 없음)
				service.AdminTeamPermanentPenalty(teamId, reason);
			} else {
				// 기간 정지
				int days = Integer.parseInt(request.getParameter("days"));
				service.AdminTeamPenalty(teamId, days, reason);
			}
			
			response.getWriter().print("true");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("false");
		}
	}

}
