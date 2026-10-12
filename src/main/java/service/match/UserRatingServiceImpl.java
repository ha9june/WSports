package service.match;

import dao.UserRatingDao;
import dao.UserRatingDaoImpl;
import dto.UserRating;

public class UserRatingServiceImpl implements UserRatingService {
	
	private UserRatingDao userRatingDao;
	
	public UserRatingServiceImpl() {
		userRatingDao = new UserRatingDaoImpl();
	}
	
	//경기 후 평가 별점주기
	@Override
	public void saveUserRating(UserRating userRating) throws Exception {
		
		 int count = userRatingDao.selectUserRatingCount(userRating);
		    if (count > 0) {
		    	userRatingDao.updateUserRating(userRating);
		    } else {
		    	userRatingDao.insertUserRating(userRating);
		    }
	}	

}
