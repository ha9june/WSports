package dao;

import java.util.List;

import dto.PersonalMatch;

public interface PersonalMatchDao {
	List<PersonalMatch> selectPersonalMatchList() throws Exception;
}
