package dto;
import java.time.LocalDateTime;

/** 공지사항 */
public class Notice {

    private Long noticeId;            // 공지 ID (PK)
    private String title;             // 제목
    private String content;           // 내용
    private LocalDateTime createdAt;  // 작성 일시
    private Boolean isPinned;         // 상단 고정 여부
    private Long adminId;             // 작성 관리자 ID
    private String type;              // 공지 유형
    private Boolean deleted;          // 삭제 여부
    private LocalDateTime updatedAt;  // 수정 일시
    
    
    
    
    
	public Notice() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
	public Notice(Long noticeId, String title, String content, LocalDateTime createdAt, Boolean isPinned, Long adminId,
			String type, Boolean deleted, LocalDateTime updatedAt) {
		super();
		this.noticeId = noticeId;
		this.title = title;
		this.content = content;
		this.createdAt = createdAt;
		this.isPinned = isPinned;
		this.adminId = adminId;
		this.type = type;
		this.deleted = deleted;
		this.updatedAt = updatedAt;
	}




	public Long getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(Long noticeId) {
		this.noticeId = noticeId;
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
	public Boolean getIsPinned() {
		return isPinned;
	}
	public void setIsPinned(Boolean isPinned) {
		this.isPinned = isPinned;
	}
	public Long getAdminId() {
		return adminId;
	}
	public void setAdminId(Long adminId) {
		this.adminId = adminId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Boolean getDeleted() {
		return deleted;
	}
	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}




	@Override
	public String toString() {
		return "Notice [noticeId=" + noticeId + ", title=" + title + ", content=" + content + ", createdAt=" + createdAt
				+ ", isPinned=" + isPinned + ", adminId=" + adminId + ", type=" + type + ", deleted=" + deleted
				+ ", updatedAt=" + updatedAt + "]";
	}
    
    
}
