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
import util.PageInfo;

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
	private Map<Long, Integer> toCountMap(List<Map<String, Object>> rows) {
		Map<Long, Integer> map = new HashMap<>();
		for (Map<String, Object> m : rows) {
			map.put(((Number) m.get("reviewId")).longValue(),
			        ((Number) m.get("cnt")).intValue());
		}
		return map;
	}

	@Override
	public List<Map<String, Object>> selectMainReviewList(PageInfo pageInfo, String status) throws Exception {
				Map<String, Object> param = new HashMap<>();
				// 모르는 값이면 전체
				param.put("status", status == null ? "ALL" : status);
				// 전체 게시글 수
				Integer reviewCnt = reviewDao.selectReviewListCnt(param);
						
				Integer allPage = (int) Math.ceil(reviewCnt / 9.0); // 전체 페이지 수
				if (allPage == 0) allPage = 1; // 회원이 0명이어도 1페이지는 있도록

				// 현재 페이지 보정을 먼저 (1 ~ 마지막 페이지 사이로)
				if (pageInfo.getCurPage() == null || pageInfo.getCurPage() < 1) pageInfo.setCurPage(1);
				if (pageInfo.getCurPage() > allPage) pageInfo.setCurPage(allPage);
						
				// startPage : curPage(1~10)=>1, curPage(11~20)=>11, curPage(21~30)=>21
				Integer startPage = (pageInfo.getCurPage() - 1) / 10 * 9 + 1 ;
				Integer endPage = startPage + 10 -1;
				if (endPage > allPage) endPage = allPage; // 마지막 페이지 보정, 전체 페이지 넘지 않게

				pageInfo.setAllPage(allPage);
				pageInfo.setStartPage(startPage);
				pageInfo.setEndPage(endPage);

				param.put("row",(pageInfo.getCurPage() - 1) * 9);
								
				return reviewDao.selectMainReviewList(param);
			}

	@Override
	public List<Map<String, Object>> getMypageReviewList(PageInfo pageInfo, Long userId) throws Exception {
		Map<String, Object> param = new HashMap<>();
		param.put("userId", userId);
		
		
		// 전체 게시글 수
		Integer reviewCnt = reviewDao.selectMypageReviewListCnt(param);
				
		Integer allPage = (int) Math.ceil(reviewCnt / 5.0); // 전체 페이지 수
		if (allPage == 0) allPage = 1; // 회원이 0명이어도 1페이지는 있도록

		// 현재 페이지 보정을 먼저 (1 ~ 마지막 페이지 사이로)
		if (pageInfo.getCurPage() == null || pageInfo.getCurPage() < 1) pageInfo.setCurPage(1);
		if (pageInfo.getCurPage() > allPage) pageInfo.setCurPage(allPage);
				
		// startPage : curPage(1~10)=>1, curPage(11~20)=>11, curPage(21~30)=>21
		Integer startPage = (pageInfo.getCurPage() - 1) / 10 * 9 + 1 ;
		Integer endPage = startPage + 10 -1;
		if (endPage > allPage) endPage = allPage; // 마지막 페이지 보정, 전체 페이지 넘지 않게
		pageInfo.setTotalCnt(reviewCnt);
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);

		param.put("row",(pageInfo.getCurPage() - 1) * 5);
						
		return reviewDao.selectMypageReviewList(param);
	}

	@Override
	public int modifyMypageReview(Long userId, Long reviewId, String title, String content, String image)
			throws Exception {
		Map<String, Object> param = new HashMap<>();
	    param.put("userId", userId);
	    param.put("reviewId", reviewId);
	    param.put("title", title);
	    param.put("content", content);
	    param.put("image", image);      // null이면 이미지는 변경 안 됨
	    return reviewDao.updateMypageReview(param);
	}


	@Override
	public int deleteMypageReview(Long userId, Long reviewId) throws Exception {
		Map<String, Object> param = new HashMap<>();
	    param.put("userId", userId);
	    param.put("reviewId", reviewId);
	    param.put("deleted", 1);        // 서버에서 고정 (클라이언트 값 사용 금지)
	    return reviewDao.updateMypageReview(param);
	}

	@Override
	public Map<String, Object> selectMyReview(Long userId, Long reviewId) throws Exception {
		 Map<String, Object> param = new HashMap<>();
		    param.put("userId", userId);
		    param.put("reviewId", reviewId);
		    return reviewDao.selectMyReview(param);
		}
}
