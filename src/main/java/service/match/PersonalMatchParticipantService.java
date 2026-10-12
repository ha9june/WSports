package service.match;

import java.util.List;
import java.util.Map;

import dto.PersonalMatchParticipant;
import dto.User;

public interface PersonalMatchParticipantService {
	void addPersonalMatchParticipant(PersonalMatchParticipant personalMatchParticipation) throws Exception;
	void updateParticipantCancel(PersonalMatchParticipant personalMatchParticipation) throws Exception;
	void updateAttendacne(PersonalMatchParticipant personalMatchParticipation) throws Exception;
	PersonalMatchParticipant getParticipant(Map<String,Object> param) throws Exception;
	List<User> getPersonalMatchParticipantList(Long personalMatchId) throws Exception;
}
