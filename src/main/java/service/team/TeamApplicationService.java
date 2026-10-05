package service.team;

import java.util.List;

import dto.TeamApplication;
import dto.User;

public interface TeamApplicationService {
	void application(Long teamId, User user, String message) throws Exception;
	TeamApplication getApplication(Long teamId, Long userId) throws Exception;
	TeamApplication getApplicationByApplicationId(Long applicationId) throws Exception;
	List<TeamApplication> getApplicationList(Long teamId) throws Exception;
	void approve(Long teamId, Long applicationId) throws Exception;
}
