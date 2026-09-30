package service.review;

import dto.Review;
import javax.servlet.http.Part;
public interface ReviewService {
	//후기 작성
	Long wirteReview(Review review,String realPath,Part ifile,Part dfile)throws Exception; 
}
