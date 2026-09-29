package dto;
import java.time.LocalDateTime;

/** 팀 가입 신청 */
public class TeamApplication {

    private Long applicationId;         // 신청 ID (PK)
    private Long userId;                // 신청 회원 ID
    private Long teamId;                // 팀 ID
    private String message;             // 신청 메시지
    private String status;              // 신청 상태
    private String rejectionReason;     // 거절 사유
    private LocalDateTime appliedAt;    // 신청 일시
    private LocalDateTime processedAt;  // 처리 일시
    
    
    
    
    
	public TeamApplication() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public TeamApplication(Long applicationId, Long userId, Long teamId, String message, String status,
			String rejectionReason, LocalDateTime appliedAt, LocalDateTime processedAt) {
		super();
		this.applicationId = applicationId;
		this.userId = userId;
		this.teamId = teamId;
		this.message = message;
		this.status = status;
		this.rejectionReason = rejectionReason;
		this.appliedAt = appliedAt;
		this.processedAt = processedAt;
	}



	public Long getApplicationId() {
		return applicationId;
	}
	public void setApplicationId(Long applicationId) {
		this.applicationId = applicationId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getTeamId() {
		return teamId;
	}
	public void setTeamId(Long teamId) {
		this.teamId = teamId;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRejectionReason() {
		return rejectionReason;
	}
	public void setRejectionReason(String rejectionReason) {
		this.rejectionReason = rejectionReason;
	}
	public LocalDateTime getAppliedAt() {
		return appliedAt;
	}
	public void setAppliedAt(LocalDateTime appliedAt) {
		this.appliedAt = appliedAt;
	}
	public LocalDateTime getProcessedAt() {
		return processedAt;
	}
	public void setProcessedAt(LocalDateTime processedAt) {
		this.processedAt = processedAt;
	}

	@Override
	public String toString() {
		return "TeamApplication [applicationId=" + applicationId + ", userId=" + userId + ", teamId=" + teamId
				+ ", message=" + message + ", status=" + status + ", rejectionReason=" + rejectionReason
				+ ", appliedAt=" + appliedAt + ", processedAt=" + processedAt + "]";
	}
    
    
    
}
