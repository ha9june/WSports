package controller.admin;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			List<Map<String, Object>> detail = service.getTeamDetailList(teamId);
			request.setAttribute("detail", detail);
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
