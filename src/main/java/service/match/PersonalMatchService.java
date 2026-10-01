package service.match;

import java.util.List;

import dto.PersonalMatch;

public interface PersonalMatchService {
	List<PersonalMatch> getRecomandMatch() throws Exception;

}
