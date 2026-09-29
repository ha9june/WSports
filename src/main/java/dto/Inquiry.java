package dto;
import java.time.LocalDateTime;

/** 문의 */
public class Inquiry {

    private Long inquiryId;            // 문의 ID (PK)
    private Long userId;               // 문의 회원 ID
    private String type;               // 문의 유형
    private String title;              // 제목
    private String content;            // 내용
    private LocalDateTime createdAt;   // 문의 일시
    private String answerStatus;       // 답변 상태
    private String answer;             // 답변 내용
    private LocalDateTime answeredAt;  // 답변 일시
    private Long adminId;              // 답변 관리자 ID
    private Boolean deleted;           // 삭제 여부
    
    
    
	public Inquiry() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Inquiry(Long inquiryId, Long userId, String type, String title, String content, LocalDateTime createdAt,
			String answerStatus, String answer, LocalDateTime answeredAt, Long adminId, Boolean deleted) {
		super();
		this.inquiryId = inquiryId;
		this.userId = userId;
		this.type = type;
		this.title = title;
		this.content = content;
		this.createdAt = createdAt;
		this.answerStatus = answerStatus;
		this.answer = answer;
		this.answeredAt = answeredAt;
		this.adminId = adminId;
		this.deleted = deleted;
	}
	
	public Long getInquiryId() {
		return inquiryId;
	}
	public void setInquiryId(Long inquiryId) {
		this.inquiryId = inquiryId;
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
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public String getAnswerStatus() {
		return answerStatus;
	}
	public void setAnswerStatus(String answerStatus) {
		this.answerStatus = answerStatus;
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
		return "Inquiry [inquiryId=" + inquiryId + ", userId=" + userId + ", type=" + type + ", title=" + title
				+ ", content=" + content + ", createdAt=" + createdAt + ", answerStatus=" + answerStatus + ", answer="
				+ answer + ", answeredAt=" + answeredAt + ", adminId=" + adminId + ", deleted=" + deleted + "]";
	}
    
	
    
}
