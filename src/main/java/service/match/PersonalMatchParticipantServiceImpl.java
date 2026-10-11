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
	public void updateParticipantCancel(PersonalMatchParticipant personalMatchParticipation) throws Exception {
		personalMatchParticipantDao.updateStatusCancel(personalMatchParticipation);
	}
	@Override
	public void updateAttendacne(PersonalMatchParticipant personalMatchParticipation) throws Exception {
		personalMatchParticipantDao.updateAttendance(personalMatchParticipation);
	}

	@Override
	public PersonalMatchParticipant getParticipant(Map<String, Object> param) throws Exception {
		return personalMatchParticipantDao.selectPersonalMatchParticipation(param);
	}

	@Override
	public List<User> getPersonalMatchParticipantList(Long personalMatchId) throws Exception {
		return personalMatchParticipantDao.selectPersonalMatchParticipantList(personalMatchId);
	}











}
