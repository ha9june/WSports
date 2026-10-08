package controller.team;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Team;
import dto.TeamMatch;
import dto.User;
import service.team.TeamMatchParticipantService;
import service.team.TeamMatchParticipantServiceImpl;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;
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
	    TeamService teamService = new TeamServiceImpl();
		try {
			Long teamMatchId = Long.parseLong(request.getParameter("teamMatchId"));
			TeamMatch teamMatch;
			if(user != null) {
				teamMatch = teamMatchService.getTeamMatchUser(teamMatchId, user.getUserId());
				if(teamMatch.getUserId().equals(user.getUserId())) {
					request.setAttribute("isHost", true);
				}else {
					request.setAttribute("isHost", false);
				}
			}else {
				teamMatch = teamMatchService.getTeamMatchNotUser(teamMatchId);
				request.setAttribute("isHost", false);
			}
			
			
			//내가 호스트인지
//			if(teamMatch.getUserId().equals(user.getUserId())) {
//				request.setAttribute("isHost", true);
//			}else {
//				request.setAttribute("isHost", false);
//			}
			
			Boolean applied = false;
			//우리 팀이 신청한 경기인지 아닌지
			if(user != null) {
				//유저 아이디로 소속된 팀 불러오기
				List<Long> teamIdList = teamUserService.getTeamIdListByUserId(user.getUserId());
				//이 경기 아이디로 참가 팀 아이디 불러오기 2개
				List<Long> tmpIdList = teamMatchParticipantService.getTeamMatchParticipantIdList(teamMatchId);
				//유저 아이디로 불러온 팀 아이디랑 맞으면 소속된 팀이 신청한 경기
				
				for(Long teamId : teamIdList) {
					for(Long tmpId : tmpIdList) {
						if(teamId.equals(tmpId)) {
							applied = true;
						}
					}
				}
			}

			//신청한 매치인지 아닌지
			request.setAttribute("applied", applied);
			
			//모집중 //모집 마감 // 경기 종료 // 경기 취소
			//근데 이거 그냥 팀매치를 넘기는데 거기서 가져와도 되는거 아닌지 그게 맞는듯
//			request.setAttribute("state", teamMatch.getStatus());
			
			//데이터 가공 재언님과 통일 필요
			//나이대
			String ages = teamService.changeAges(teamMatch.getAge20s(), teamMatch.getAge30s(), teamMatch.getAge40s(), teamMatch.getAge50s(), teamMatch.getAge60Plus());
			request.setAttribute("ages", ages);
			//실력
			boolean[] s = {
			        Boolean.TRUE.equals(teamMatch.getSkillIntro()), Boolean.TRUE.equals(teamMatch.getSkillBeginner()),
			        Boolean.TRUE.equals(teamMatch.getSkillIntermediate()), Boolean.TRUE.equals(teamMatch.getSkillAdvanced())
			    };
			String[] label = {"입문", "초급", "중급", "상급"};
			List<String> parts = new ArrayList<>();
			int i=0; 
			while(i < s.length) {
				if(s[i]) {
					parts.add(label[i]);
				}
				i++;
			}
			String skills = String.join(" · ", parts);
			request.setAttribute("skills", skills);
			//일시
			//참가비
			
			try {
				List<Team> myTeamList = teamService.getTeamInfoByUserManagerSport(user.getUserId(), teamMatch.getSport());
				request.setAttribute("myTeamList", myTeamList);
				request.setAttribute("isMyTeamList", true);
			}catch(Exception e) {
				request.setAttribute("isMyTeamList", false);
			}
			
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
