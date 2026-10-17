package service.team;

import java.util.Map;

public interface TeamPenaltyService {
	int getTeamPenaltyScore(Long teamId) throws Exception;
	Map<String, Object> getMypageMyTeamPenalty(long userId, long teamId) throws Exception;
}
