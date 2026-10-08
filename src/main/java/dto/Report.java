package dto;
import java.time.LocalDateTime;

/** 신고 */
public class Report {

    private Long reportId;             // 신고 ID (PK)
    private Long userId;               // 신고자 회원 ID
    private String type;               // 신고 유형
    private String title;              // 제목
    private String content;            // 내용
    private String postType;           // 신고 대상 게시글 유형
    private Long postId;               // 신고 대상 게시글 ID
    private LocalDateTime createdAt;   // 신고 일시
    private String status;             // 처리 상태
    private String answer;             // 답변 내용
    private LocalDateTime answeredAt;  // 답변 일시
    private Long adminId;              // 처리 관리자 ID
    private Boolean deleted;           // 삭제 여부
    
    
    
    
    public Report() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Report(Long reportId, Long userId, String type, String title, String content, String postType, Long postId,
			LocalDateTime createdAt, String status, String answer, LocalDateTime answeredAt, Long adminId,
			Boolean deleted) {
		super();
		this.reportId = reportId;
		this.userId = userId;
		this.type = type;
		this.title = title;
		this.content = content;
		this.postType = postType;
		this.postId = postId;
		this.createdAt = createdAt;
		this.status = status;
		this.answer = answer;
		this.answeredAt = answeredAt;
		this.adminId = adminId;
		this.deleted = deleted;
	}
	
	
	public Long getReportId() {
		return reportId;
	}
	public void setReportId(Long reportId) {
		this.reportId = reportId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getPostType() {
		return postType;
	}
	public void setPostType(String postType) {
		this.postType = postType;
	}
	public Long getPostId() {
		return postId;
	}
	public void setPostId(Long postId) {
		this.postId = postId;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public LocalDateTime getAnsweredAt() {
		return answeredAt;
	}
	public void setAnsweredAt(LocalDateTime answeredAt) {
		this.answeredAt = answeredAt;
	}
	public Long getAdminId() {
		return adminId;
	}
	public void setAdminId(Long adminId) {
		this.adminId = adminId;
	}
	public Boolean getDeleted() {
		return deleted;
	}
	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}


	@Override
	public String toString() {
		return "Report [reportId=" + reportId + ", userId=" + userId + ", type=" + type + ", title=" + title
				+ ", content=" + content + ", postType=" + postType + ", postId=" + postId + ", createdAt=" + createdAt
				+ ", status=" + status + ", answer=" + answer + ", answeredAt=" + answeredAt + ", adminId=" + adminId
				+ ", deleted=" + deleted + "]";
	}
    
    
    
}
