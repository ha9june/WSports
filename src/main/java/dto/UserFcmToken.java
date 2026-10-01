package dto;

import java.time.LocalDateTime;

public class UserFcmToken {
	private Long fcmToKenId;
	private Long userId;
	private String fcmToken;
	private Boolean active;
	private LocalDateTime createdAt;
	private LocalDateTime lastUsedAt;
	public UserFcmToken() {
		super();
		// TODO Auto-generated constructor stub
	}
	public UserFcmToken(Long fcmToKenId, Long userId, String fcmToken, Boolean active, LocalDateTime createdAt,
			LocalDateTime lastUsedAt) {
		super();
		this.fcmToKenId = fcmToKenId;
		this.userId = userId;
		this.fcmToken = fcmToken;
		this.active = active;
		this.createdAt = createdAt;
		this.lastUsedAt = lastUsedAt;
	}
	@Override
	public String toString() {
		return "UserFcmToken [fcmToKenId=" + fcmToKenId + ", userId=" + userId + ", fcmToken=" + fcmToken + ", active="
				+ active + ", createdAt=" + createdAt + ", lastUsedAt=" + lastUsedAt + "]";
	}
	public Long getFcmToKenId() {
		return fcmToKenId;
	}
	public void setFcmToKenId(Long fcmToKenId) {
		this.fcmToKenId = fcmToKenId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getFcmToken() {
		return fcmToken;
	}
	public void setFcmToken(String fcmToken) {
		this.fcmToken = fcmToken;
	}
	public Boolean getActive() {
		return active;
	}
	public void setActive(Boolean active) {
		this.active = active;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDateTime getLastUsedAt() {
		return lastUsedAt;
	}
	public void setLastUsedAt(LocalDateTime lastUsedAt) {
		this.lastUsedAt = lastUsedAt;
	}
	
}
