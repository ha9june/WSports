package dto;
import java.time.LocalDate;
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
    
    
    private LocalDate matchDate;   // 조회용
    private String sport; //종목
    public LocalDate getMatchDate() { return matchDate; }
    public void setMatchDate(LocalDate matchDate) { this.matchDate = matchDate; }
    
    private int likeCount;
    private int commentCount;
    public int getLikeCount() { return likeCount; }
    public void setLikeCount(int likeCount) { this.likeCount = likeCount; }
    public int getCommentCount() { return commentCount; }
    public void setCommentCount(int commentCount) { this.commentCount = commentCount; }
    
    private String nickname;
    private String createdAtStr;
    public String getCreatedAtStr() {
		return createdAtStr;
	}
	public void setCreatedAtStr(String createdAtStr) {
		this.createdAtStr = createdAtStr;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	private String matchTitle;  // 경기명
	private String matchInfo;   // 경기 부가정보 (없으면 빈 값)

	public String getMatchTitle() { return matchTitle; }
	public void setMatchTitle(String matchTitle) { this.matchTitle = matchTitle; }
	public String getMatchInfo() { return matchInfo; }
	public void setMatchInfo(String matchInfo) { this.matchInfo = matchInfo; }
	public Review() {
		super();
		// TODO Auto-generated constructor stub
	}
	private String profileImage;
	public String getProfileImage() { return profileImage; }
	public void setProfileImage(String profileImage) { this.profileImage = profileImage; }

	public Review(String title, String content, String image) {
		super();
		this.title=title;
		this.content=content;
		this.image=image;
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
	
	public String getSport() {
		return sport;
	}
	public void setSport(String sport) {
		this.sport = sport;
	}
	@Override
	public String toString() {
		return "Review [reviewId=" + reviewId + ", userId=" + userId + ", matchType=" + matchType + ", matchId="
				+ matchId + ", title=" + title + ", content=" + content + ", image=" + image + ", deleted=" + deleted
				+ ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", matchDate=" + matchDate + ", sport="
				+ sport + ", likeCount=" + likeCount + ", commentCount=" + commentCount + "]";
	}
	
	
	
	
}

