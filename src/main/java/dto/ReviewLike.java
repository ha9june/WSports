package dto;
import java.time.LocalDateTime;

/** 후기 좋아요 */
public class ReviewLike {

    private Long reviewLikeId;        // 좋아요 ID (PK)
    private Long userId;              // 회원 ID
    private Long reviewId;            // 후기 ID
    private LocalDateTime createdAt;  // 좋아요 일시
    
    
    
	public ReviewLike() {
		super();
		// TODO Auto-generated constructor stub
	}


	public ReviewLike(Long reviewLikeId, Long userId, Long reviewId, LocalDateTime createdAt) {
		super();
		this.reviewLikeId = reviewLikeId;
		this.userId = userId;
		this.reviewId = reviewId;
		this.createdAt = createdAt;
	}
	
	
	public Long getReviewLikeId() {
		return reviewLikeId;
	}
	public void setReviewLikeId(Long reviewLikeId) {
		this.reviewLikeId = reviewLikeId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getReviewId() {
		return reviewId;
	}
	public void setReviewId(Long reviewId) {
		this.reviewId = reviewId;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	
	@Override
	public String toString() {
		return "ReviewLike [reviewLikeId=" + reviewLikeId + ", userId=" + userId + ", reviewId=" + reviewId
				+ ", createdAt=" + createdAt + "]";
	}
    
	
    
}
