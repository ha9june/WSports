package service.match;

import java.util.List;
import java.util.Map;

import dao.PersonalMatchParticipantDao;
import dao.PersonalMatchParticipantDaoImpl;
import dto.PersonalMatchParticipant;
import dto.User;

public class PersonalMatchParticipantServiceImpl implements PersonalMatchParticipantService
{
	private PersonalMatchParticipantDao personalMatchParticipantDao;
	
	public PersonalMatchParticipantServiceImpl() {
		personalMatchParticipantDao = new PersonalMatchParticipantDaoImpl();
	}

	@Override
	public void addPersonalMatchParticipant(PersonalMatchParticipant personalMatchParticipation)
			throws Exception {
		personalMatchParticipantDao.insertOtherPersonalMatchParticipant(personalMatchParticipation);
		
	}

	@Override
	public Boolean isPersonalMatchParticipant(Map<String, Object> param) throws Exception {
		return personalMatchParticipantDao.selectisIsPersonalMatchParticipant(param);
	}

	@Override
	public List<User> getPersonalMatchParticipantList(Long personalMatchId) throws Exception {
		return personalMatchParticipantDao.selectPersonalMatchParticipantList(personalMatchId);
	}






}
