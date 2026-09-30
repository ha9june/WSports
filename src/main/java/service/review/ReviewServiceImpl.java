package service.review;

import java.io.File;
import java.nio.file.Paths;

import javax.servlet.http.Part;

import dao.ReviewDao;
import dao.ReviewDaoImpl;
import dto.Review;

public class ReviewServiceImpl implements ReviewService {
	private ReviewDao reviewDao;
	
	public ReviewServiceImpl() {
		reviewDao = new ReviewDaoImpl();
		
	}
	
	
	// 사진(이미지) 파일 업로드
	
	public String fileUpload(String uploadPath,Part file)throws Exception{
		String fileName = Paths.get(file.getSubmittedFileName()).getFileName().toString();
		if(fileName!=null&&!fileName.isEmpty()) {
			File uploadDir = new File(uploadPath);
			if(!uploadDir.exists()) uploadDir.mkdir();
			file.write(uploadPath + File.separator + fileName);
		}
		return fileName;
	}

	// 후기 글작성
	
	@Override
	public Long wirteReview(Review review, String uploadPath, Part ifile, Part dfile) throws Exception {
		if(ifile!=null) review.setImage(fileUpload(uploadPath, dfile));
		return reviewDao.insertReview(review);
	}

}
