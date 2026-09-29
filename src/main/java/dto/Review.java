package dto;
import java.time.LocalDateTime;

/** 후기 */
public class Review {

    private Long reviewId;            // 후기 ID (PK)
    private Long userId;              // 작성자 회원 ID
    private String matchType;         // 매치 유형 (개인/팀)
    private Long matchId;             // 매치 ID
    private String title;             // 제목
    private String content;           // 내용
    private String image;             // 이미지
    private Boolean deleted;          // 삭제 여부
    private LocalDateTime createdAt;  // 작성 일시
    private LocalDateTime updatedAt;  // 수정 일시
    
    
    
    

	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Review(Long reviewId, Long userId, String matchType, Long matchId, String title, String content,
			String image, Boolean deleted, LocalDateTime createdAt, LocalDateTime updatedAt) {
		super();
		this.reviewId = reviewId;
		this.userId = userId;
		this.matchType = matchType;
		this.matchId = matchId;
		this.title = title;
		this.content = content;
		this.image = image;
		this.deleted = deleted;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}
	
	public Long getReviewId() {
		return reviewId;
	}
	public void setReviewId(Long reviewId) {
		this.reviewId = reviewId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getMatchType() {
		return matchType;
	}
	public void setMatchType(String matchType) {
		this.matchType = matchType;
	}
	public Long getMatchId() {
		return matchId;
	}
	public void setMatchId(Long matchId) {
		this.matchId = matchId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public Boolean getDeleted() {
		return deleted;
	}
	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	@Override
	public String toString() {
		return "Review [reviewId=" + reviewId + ", userId=" + userId + ", matchType=" + matchType + ", matchId="
				+ matchId + ", title=" + title + ", content=" + content + ", image=" + image + ", deleted=" + deleted
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}
}

