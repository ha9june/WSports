package controller.match;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.PersonalMatch;
import dto.User;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import util.AlertUtil;
import util.CheckUtil;

/**
 * Servlet implementation class MatchStatusUpdate
 */
@WebServlet("/match/status/update")
public class MatchStatusUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchStatusUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = CheckUtil.getLoginUser(request);
		if (user == null) {
		    response.sendRedirect(request.getContextPath() + "/auth/login");
		    return;
		}
		
		
		Long personalMatchId = Long.parseLong(request.getParameter("personalMatchId"));

		String updateType = request.getParameter("updateType");
		String updateString = "";
		
		PersonalMatch pm = new PersonalMatch();
		
		

		if(updateType.equals("hostCancel")) {
			updateString="작성자 경기 취소";	
		}
		else if(updateType.equals("adminDelete")) {
			updateString="관리자 경기 삭제";	
			pm.setDeleted(true);
		}
		else {
			AlertUtil.back(response, "올바르지 않은 접근입니다.");
			return;
		}
		
		
		
		PersonalMatchService service = new PersonalMatchServiceImpl();
		pm.setPersonalMatchId(personalMatchId);
		pm.setStatus(updateString);
		try {
			service.updateStatue(pm);
            response.sendRedirect(request.getContextPath() + "/match/detail/view?personalMatchId=" + personalMatchId);

		} catch (Exception e) {
			e.printStackTrace();
			AlertUtil.back(response, "취소/삭제가 실패하였습니다.");
		}

		
		
	}

}
