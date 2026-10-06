package dao;

import dto.PersonalMatch;
import dto.PersonalMatchParticipant;

public interface PersonalMatchParticipantDao {
	Long insertPersonalMatchParticipantDao(PersonalMatchParticipant personalMatchParticipant) throws Exception;

}
