package dto;
import java.time.LocalDateTime;

/** 후기 댓글 */
public class Comment {

    private Long commentId;           // 댓글 ID (PK)
    private Long parentCommentId;     // 부모 댓글 ID (대댓글일 때)
    private Long reviewId;            // 후기 ID
    private Long userId;              // 작성자 회원 ID
    private String content;           // 댓글 내용
    private LocalDateTime createdAt;  // 작성 일시
    private LocalDateTime updatedAt;  // 수정 일시
    private Boolean deleted;          // 삭제 여부
    
    
    
    private String profileImage;

    public String getProfileImage() { return profileImage; }
    public void setProfileImage(String profileImage) { this.profileImage = profileImage; }
	public Comment() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	private String nickname;
	public String getNickname() { return nickname; }
	public void setNickname(String nickname) { this.nickname = nickname; }
	private String createdAtStr;
	public String getCreatedAtStr() { return createdAtStr; }
	public void setCreatedAtStr(String createdAtStr) { this.createdAtStr = createdAtStr; }
	public Comment(Long commentId, Long parentCommentId, Long reviewId, Long userId, String content,
			LocalDateTime createdAt, LocalDateTime updatedAt, Boolean deleted) {
		super();
		this.commentId = commentId;
		this.parentCommentId = parentCommentId;
		this.reviewId = reviewId;
		this.userId = userId;
		this.content = content;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.deleted = deleted;
	}
	
	public Long getCommentId() {
		return commentId;
	}
	public void setCommentId(Long commentId) {
		this.commentId = commentId;
	}
	public Long getParentCommentId() {
		return parentCommentId;
	}
	public void setParentCommentId(Long parentCommentId) {
		this.parentCommentId = parentCommentId;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public Boolean getDeleted() {
		return deleted;
	}
	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}

	@Override
	public String toString() {
		return "Comment [commentId=" + commentId + ", parentCommentId=" + parentCommentId + ", reviewId=" + reviewId
				+ ", userId=" + userId + ", content=" + content + ", createdAt=" + createdAt + ", updatedAt="
				+ updatedAt + ", deleted=" + deleted + "]";
	}
    
	
}
