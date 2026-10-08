package service.review;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.HashMap;
import javax.servlet.http.Part;

import dao.CommentDao;
import dao.CommentDaoImpl;
import dao.ReviewDao;
import dao.ReviewDaoImpl;
import dao.ReviewLikeDao;
import dao.ReviewLikeDaoImpl;
import dao.UserDao;
import dao.UserDaoImpl;
import dto.Review;

public class ReviewServiceImpl implements ReviewService {
	private ReviewDao reviewDao;
	private UserDao user;
	private ReviewLikeDao reviewlikeDao;
	private CommentDao commentDao;

	public ReviewServiceImpl() {
		reviewDao = new ReviewDaoImpl();
		user = new UserDaoImpl();
		reviewlikeDao = new ReviewLikeDaoImpl();
		commentDao = new CommentDaoImpl();
	}

	// 사진(이미지) 파일 업로드
	public String fileUpload(String uploadPath, Part file) throws Exception {
		File dir = new File(uploadPath);
		if (!dir.exists())
			dir.mkdirs();

		String original = file.getSubmittedFileName();
		String ext = original.substring(original.lastIndexOf(".")).toLowerCase();
		String saved = UUID.randomUUID() + ext;

		file.write(uploadPath + File.separator + saved);
		return saved;
	}

	@Override
	public Long writeReview(Review review, long userId, String realPath, List<Part> images) throws Exception {
		review.setUserId(userId);

		List<String> savedNames = new ArrayList<>();
		try {
			if (images != null) {
				for (Part part : images) {
					savedNames.add(fileUpload(realPath, part));
				}
			}
			if (!savedNames.isEmpty()) {
				review.setImage(String.join(",", savedNames));
			}
			return reviewDao.insertReview(review);

		} catch (Exception e) {
			for (String name : savedNames) {
				new File(realPath, name).delete();
			}
			throw e;
		}

	}

	@Override
	public List<Review> getReviewableMatches(long userId) throws Exception {
	    List<Review> list = new ArrayList<>();
	    try {
	        list.addAll(reviewDao.selectReviewablePersonal(userId));
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    try {
	        list.addAll(reviewDao.selectReviewableTeam(userId));
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	@Override
	public List<Review> getReviewList(Long userId) throws Exception {
		List<Review> list = reviewDao.selectReviewList(userId);

		Map<Long, Integer> likeCounts = toCountMap(reviewlikeDao.selectReviewLikeCnt());
		Map<Long, Integer> commentCounts = toCountMap(commentDao.selectReviewCommentCnt());

		for (Review r : list) {
			r.setLikeCount(likeCounts.getOrDefault(r.getReviewId(), 0));
			r.setCommentCount(commentCounts.getOrDefault(r.getReviewId(), 0));
		}
		return list;
	}
	
	@Override
	public List<Review> getNowReviewList() throws Exception {
		List<Review> list = reviewDao.selectNowReviewList();
		return list;
	}
	
	
	private Map<Long, Integer> toCountMap(List<Map<String, Object>> rows) {
		Map<Long, Integer> map = new HashMap<>();
		for (Map<String, Object> m : rows) {
			map.put(((Number) m.get("reviewId")).longValue(),
			        ((Number) m.get("cnt")).intValue());
		}
		return map;
	}

	
	
}
