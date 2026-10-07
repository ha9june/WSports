package controller.team;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.TeamMatch;
import dto.User;
import service.team.TeamMatchParticipantService;
import service.team.TeamMatchParticipantServiceImpl;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamUserService;
import service.team.TeamUserServiceImpl;

/**
 * Servlet implementation class TeamMatchDetailView
 */
@WebServlet("/team-match/detail/view")
public class TeamMatchDetailView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeamMatchDetailView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User)request.getSession().getAttribute("user");
	    

	    TeamMatchService teamMatchService = new TeamMatchServiceImpl();
	    TeamMatchParticipantService teamMatchParticipantService = new TeamMatchParticipantServiceImpl();
	    TeamUserService teamUserService = new TeamUserServiceImpl();
		try {
			Long teamMatchId = Long.parseLong(request.getParameter("teamMatchId"));
			TeamMatch teamMatch = teamMatchService.getTeamMatch(teamMatchId);
			
			//내가 호스트인지
			if(teamMatch.getUserId().equals(user.getUserId())) {
				request.setAttribute("isHost", true);
			}else {
				request.setAttribute("isHost", false);
			}
			
			//우리 팀이 신청한 경기인지 아닌지
			
			//유저 아이디로 소속된 팀 불러오기
			List<Long> teamIdList = teamUserService.getTeamIdListByUserId(user.getUserId());
			//이 경기 아이디로 참가 팀 아이디 불러오기 2개
			List<Long> tmpIdList = teamMatchParticipantService.getTeamMatchParticipantIdList(teamMatchId);
			//유저 아이디로 불러온 팀 아이디랑 맞으면 소속된 팀이 신청한 경기
			Boolean applied = false;
			for(Long teamId : teamIdList) {
				for(Long tmpId : tmpIdList) {
					if(teamId.equals(tmpId)) {
						applied = true;
					}
				}
			}
			
			//신청한 매치인지 아닌지
			request.setAttribute("applied", applied);
			
			//모집중 //모집 마감 // 경기 종료 // 경기 취소
			//근데 이거 그냥 팀매치를 넘기는데 거기서 가져와도 되는거 아닌지 그게 맞는듯
//			request.setAttribute("state", teamMatch.getStatus());
			
			request.setAttribute("t", teamMatch);
			request.getRequestDispatcher("/jsp/team/teamMatchDetail.jsp").forward(request, response);
		}catch(Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "팀 경기 상세보기 불러오는 중 에러 발생");
			request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
