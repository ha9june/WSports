package service.match;

import controller.match.PersonalMatchParticipation;
import dao.PersonalMatchParticipantDao;
import dao.PersonalMatchParticipantDaoImpl;
import dto.PersonalMatchParticipant;

public class PersonalMatchParticipationServiceImpl implements PersonalMatchParticipationService
{
	private PersonalMatchParticipantDao personalMatchParticipantDao;
	
	public PersonalMatchParticipationServiceImpl() {
		personalMatchParticipantDao = new PersonalMatchParticipantDaoImpl();
	}

	@Override
	public void addPersonalMatchParticipation(PersonalMatchParticipant personalMatchParticipant) throws Exception {
		personalMatchParticipantDao.insertOtherPersonalMatchParticipant(personalMatchParticipant);
		
	}

}
