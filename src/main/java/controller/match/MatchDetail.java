package controller.match;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.PersonalMatch;
import dto.PersonalMatchParticipant;
import dto.User;
import service.match.PersonalMatchParticipantService;
import service.match.PersonalMatchParticipantServiceImpl;
import service.match.PersonalMatchService;
import service.match.PersonalMatchServiceImpl;
import service.team.TeamMatchService;
import service.team.TeamMatchServiceImpl;
import service.team.TeamService;
import service.team.TeamServiceImpl;
import service.team.TeamUserService;
import service.team.TeamUserServiceImpl;
import util.CheckUtil;

/**
 * Servlet implementation class MatchDetail
 */
@WebServlet("/match/detail/view")
public class MatchDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MatchDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = CheckUtil.getLoginUser(request);


		Long personalMatchId = Long.parseLong(request.getParameter("personalMatchId"));

		PersonalMatchService pmService = new PersonalMatchServiceImpl();
		PersonalMatchParticipantService pmpService = new PersonalMatchParticipantServiceImpl();
	    TeamService teamService = new TeamServiceImpl();

		try {
			
			PersonalMatch pm = new PersonalMatch();
			pm.setPersonalMatchId(personalMatchId);
			if(user!=null)
				pm.setUserId(user.getUserId());
			

			PersonalMatch pMatch = pmService.getPersonalMatchDetail(pm);
			if (pMatch == null) {
			    request.setAttribute("errorTitle", "삭제된 경기예요");
			    request.setAttribute("error", "관리자가 삭제했거나 운영 정책에 따라 삭제된 경기입니다.");
			    request.getRequestDispatcher("/jsp/common/error.jsp").forward(request, response);
			    return;
			}
			
			
			
			String ages = teamService.changeAges(pMatch.getAge20s(), pMatch.getAge30s(), pMatch.getAge40s(), pMatch.getAge50s(), pMatch.getAge60Plus());
			request.setAttribute("ages", ages);
			
			
			boolean[] s = {
			        Boolean.TRUE.equals(pMatch.getSkillIntro()), Boolean.TRUE.equals(pMatch.getSkillBeginner()),
			        Boolean.TRUE.equals(pMatch.getSkillIntermediate()), Boolean.TRUE.equals(pMatch.getSkillAdvanced())
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

			
			
			Boolean applied = false;
			if(user!=null) {
				HashMap<String,Object> map = new HashMap<>();
				map.put("userId", user.getUserId());
				map.put("personalMatchId", personalMatchId);
				PersonalMatchParticipant participant = pmpService.getParticipant(map);
				if(participant != null && "결제완료".equals(participant.getStatus())) {
				    applied = true;
				}
			}
			request.setAttribute("applied",applied);
			System.out.println(pMatch);
			request.setAttribute("personalMatch", pMatch);
			request.getRequestDispatcher("/jsp/match/personalMatchDetail.jsp").forward(request, response);	
			
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
	}

}
