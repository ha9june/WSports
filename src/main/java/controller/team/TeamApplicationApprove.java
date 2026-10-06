package controller.team;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.team.TeamApplicationService;
import service.team.TeamApplicationServiceImpl;

/**
 * Servlet implementation class TeamApplicationApprove
 */
@WebServlet("/team/application/approve")
public class TeamApplicationApprove extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamApplicationApprove() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TeamApplicationService teamApplicationService = new TeamApplicationServiceImpl();
		
		try {
			Long teamId = Long.parseLong(request.getParameter("teamId"));
			Long applicationId = Long.parseLong(request.getParameter("applicationId"));
			
			teamApplicationService.approve(teamId, applicationId);
			response.sendRedirect(request.getContextPath()+"/team/manage/applications?teamId="+teamId);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "가입 신청 승인중 오류 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
		
		
		
	}

}
