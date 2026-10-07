package dao;

import dto.PersonalMatch;
import dto.PersonalMatchParticipant;

public interface PersonalMatchParticipantDao {
	void insertCreatorPersonalMatchParticipant(PersonalMatchParticipant personalMatchParticipant) throws Exception;
	void insertOtherPersonalMatchParticipant (PersonalMatchParticipant personalMatchParticipant) throws Exception;
}
