package service.team;

import java.util.Map;

public interface TeamPenaltyService {
	int getTeamPenaltyScore(Long teamId) throws Exception;
	Map<String, Object> getMypageMyTeamPenalty(long userId, long teamId) throws Exception;
	// 지금 정지 중인 팀인지
	boolean isTeamSuspended(Long teamId) throws Exception;
}
