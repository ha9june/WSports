package dto;
import java.time.LocalDateTime;

/** 알림 */
public class Notification {

    private Long notificationId;      // 알림 ID (PK)
    private Long userId;              // 수신 회원 ID
    private String content;           // 알림 내용
    private Boolean isRead;           // 읽음 여부
    private LocalDateTime createdAt;  // 생성 일시
    private String title;             // 알림 제목
    private String link;              // 이동 링크
    
    
    
    
	public Notification() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Notification(Long notificationId, Long userId, String content, Boolean isRead, LocalDateTime createdAt,
			String title, String link) {
		super();
		this.notificationId = notificationId;
		this.userId = userId;
		this.content = content;
		this.isRead = isRead;
		this.createdAt = createdAt;
		this.title = title;
		this.link = link;
	}

	public Long getNotificationId() {
		return notificationId;
	}
	public void setNotificationId(Long notificationId) {
		this.notificationId = notificationId;
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
	public Boolean getIsRead() {
		return isRead;
	}
	public void setIsRead(Boolean isRead) {
		this.isRead = isRead;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	
	@Override
	public String toString() {
		return "Notification [notificationId=" + notificationId + ", userId=" + userId + ", content=" + content
				+ ", isRead=" + isRead + ", createdAt=" + createdAt + ", title=" + title + ", link=" + link + "]";
	}
    
    
    
}
