package service.match;

import java.util.List;

import dao.PersonalMatchDao;
import dao.PersonalMatchDaoImpl;
import dto.PersonalMatch;

public class PersonalMatchServiceImpl implements PersonalMatchService {

	private PersonalMatchDao personalMatchDao;
	
	public PersonalMatchServiceImpl() {
		personalMatchDao = new PersonalMatchDaoImpl();
	}
	
	@Override
	public List<PersonalMatch> getRecomandMatch() throws Exception {
		return personalMatchDao.selectPersonalMatchList();
	}

}
