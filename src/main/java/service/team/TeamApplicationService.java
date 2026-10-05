package service.team;

import dto.TeamApplication;

public interface TeamApplicationService {
	void application(Long teamId, Long userId, String message) throws Exception;
	TeamApplication getApplication(Long teamId, Long userId) throws Exception;
}
