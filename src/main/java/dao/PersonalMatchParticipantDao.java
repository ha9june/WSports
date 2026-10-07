package dao;

import java.util.List;
import java.util.Map;

import dto.PersonalMatchParticipant;
import dto.User;

public interface PersonalMatchParticipantDao {
	void insertCreatorPersonalMatchParticipant(PersonalMatchParticipant personalMatchParticipant) throws Exception;
	void insertOtherPersonalMatchParticipant (PersonalMatchParticipant personalMatchParticipant) throws Exception;
	Boolean selectisIsPersonalMatchParticipant(Map<String,Object> param) throws Exception;
	List<User> selectPersonalMatchParticipantList(Long personalMatchId) throws Exception;
}
