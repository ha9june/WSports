package dao;

import java.util.List;
import java.util.Map;

import dto.PersonalMatchParticipant;
import dto.User;

public interface PersonalMatchParticipantDao {
	void insertCreatorPersonalMatchParticipant(PersonalMatchParticipant personalMatchParticipant) throws Exception;
	void insertOtherPersonalMatchParticipant (PersonalMatchParticipant personalMatchParticipant) throws Exception;
	void updateStatusCancel (PersonalMatchParticipant personalMatchParticipant) throws Exception;
	void updateAttendance(PersonalMatchParticipant personalMatchParticipant) throws Exception;
	PersonalMatchParticipant selectPersonalMatchParticipation(Map<String,Object> param) throws Exception;
	List<User> selectPersonalMatchParticipantList(Long personalMatchId) throws Exception;
	User selectMyPersonalMatchParticipant(Long personalMatchId, Long userId) throws Exception;
	List<User> selectOtherPersonalMatchParticipantList(Long personalMatchId, Long userId) throws Exception;

	//스케줄러 알림 발송요 아이디 가져오기
	List<Long> selectParticipantUserIds(Long personalMatchId) throws Exception;

}
