package service.team;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.TeamDao;
import dao.TeamDaoImpl;
import dao.TeamPenaltyDao;
import dao.TeamPenaltyDaoImpl;

public class TeamPenaltyServiceImpl implements TeamPenaltyService {

	TeamDao teamDao;
	TeamPenaltyDao teamPenaltyDao;
	
	public TeamPenaltyServiceImpl() {
		teamPenaltyDao = new TeamPenaltyDaoImpl();
		teamDao = new TeamDaoImpl();
	}

	@Override
	public int getTeamPenaltyScore(Long teamId) throws Exception {
		if(teamDao.selectTeam(teamId) == null) {
			throw new Exception ("존재하지 않는 팀 입니다.");
		}
		return teamPenaltyDao.selectsTeamPenaltyScore(teamId);
	}

	@Override
	public Map<String, Object> getMypageMyTeamPenalty(long userId, long teamId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		param.put("teamId", teamId);

		// 내가 속한 팀이 아니면 접근 불가
		String teamName = teamPenaltyDao.selectMypageMyTeamNameIfMember(param);
		if (teamName == null)
			return null;

		List<Map<String, Object>> list = teamPenaltyDao.selectMypageTeamPenaltyList(param);

		boolean permanent = false;
		boolean suspended = false;
		String suspendEnd = null;
		LocalDateTime now = LocalDateTime.now();
		Integer latestScore = null;

		// 1) 오래된 행부터: 이전 점수와의 차이로 +/- 계산
		int prev = 0;
		for (int i = list.size() - 1; i >= 0; i--) {
			Map<String, Object> row = list.get(i);
			int score = Integer.parseInt(String.valueOf(row.get("score")));
			int diff = score - prev; // 20 → 19 이면 -1
			row.put("scoreText", scoreText(diff));
			row.put("scoreClass", scoreClass(diff));
			if (Integer.parseInt(String.valueOf(row.get("cancelled"))) != 1)
				prev = score; // 취소된 행은 기준에서 제외
		}

		// 2) 현재 점수, 정지 여부 (최신순 그대로)
		for (Map<String, Object> row : list) {
			if (Integer.parseInt(String.valueOf(row.get("cancelled"))) == 1)
				continue;

			if (latestScore == null)
				latestScore = Integer.parseInt(String.valueOf(row.get("score")));

			if (Integer.parseInt(String.valueOf(row.get("permanentSuspension"))) == 1)
				permanent = true;

			Object end = row.get("suspensionEnd");
			if (end != null) {
				LocalDateTime endAt = LocalDateTime.parse(end.toString().replace(' ', 'T'));
				if (endAt.isAfter(now) && (suspendEnd == null || end.toString().compareTo(suspendEnd) > 0)) {
					suspended = true;
					suspendEnd = end.toString();
				}
			}
		}

		Map<String, Object> result = new HashMap<>();
		result.put("teamName", teamName);
		result.put("penaltyList", list);
		result.put("totalPoint", latestScore == null ? 0 : latestScore);
		result.put("permanent", permanent);
		result.put("suspended", suspended);
		result.put("suspendEnd", suspendEnd);
		return result;
	}

	private static String scoreText(int score) {
		if (score > 0)
			return "+" + score;
		if (score < 0)
			return String.valueOf(score); // 음수는 이미 "-1" 형태
		return "0";
	}

	private static String scoreClass(int score) {
		if (score > 0)
			return "plus";
		if (score < 0)
			return "minus";
		return "";
	}

	// 지금 정지 중인 팀인지
	@Override
	public boolean isTeamSuspended(Long teamId) throws Exception {
		Integer cnt = teamPenaltyDao.selectTeamSuspension(teamId);
		return cnt != null && cnt > 0;
	}
}
