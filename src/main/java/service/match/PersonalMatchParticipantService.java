package service.match;

import java.util.List;
import java.util.Map;

import dto.PersonalMatchParticipant;
import dto.User;

public interface PersonalMatchParticipantService {
	void addPersonalMatchParticipant(PersonalMatchParticipant personalMatchParticipation) throws Exception;
	Boolean isPersonalMatchParticipant(Map<String,Object> param) throws Exception;
	List<User> getPersonalMatchParticipantList(Long personalMatchId) throws Exception;
}
