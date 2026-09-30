package dto;
import java.time.LocalDateTime;

/** 회원 패널티 */
public class UserPenalty {

    private Long penaltyId;                   // 패널티 ID (PK)
    private Long userId;                      // 회원 ID
    private LocalDateTime receivedAt;         // 패널티 부여 일시
    private Integer score;                    // 패널티 점수
    private String matchType;                 // 매치 유형 (개인/팀)
    private Long matchId;                     // 매치 ID
    private Long reportId;                    // 신고 ID
    private String reason;                    // 패널티 사유
    private LocalDateTime suspensionStartAt;  // 정지 시작 일시
    private LocalDateTime suspensionEndAt;    // 정지 종료 일시
    private Boolean permanentSuspension;      // 영구 정지 여부
    private Long cancelledAdminId;            // 패널티 취소 관리자 ID
    
    
    
    
    
	public UserPenalty() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public UserPenalty(Long penaltyId, Long userId, LocalDateTime receivedAt, Integer score, String matchType,
			Long matchId, Long reportId, String reason, LocalDateTime suspensionStartAt, LocalDateTime suspensionEndAt,
			Boolean permanentSuspension, Long cancelledAdminId) {
		super();
		this.penaltyId = penaltyId;
		this.userId = userId;
		this.receivedAt = receivedAt;
		this.score = score;
		this.matchType = matchType;
		this.matchId = matchId;
		this.reportId = reportId;
		this.reason = reason;
		this.suspensionStartAt = suspensionStartAt;
		this.suspensionEndAt = suspensionEndAt;
		this.permanentSuspension = permanentSuspension;
		this.cancelledAdminId = cancelledAdminId;
	}



	public Long getPenaltyId() {
		return penaltyId;
	}
	public void setPenaltyId(Long penaltyId) {
		this.penaltyId = penaltyId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public LocalDateTime getReceivedAt() {
		return receivedAt;
	}
	public void setReceivedAt(LocalDateTime receivedAt) {
		this.receivedAt = receivedAt;
	}
	public Integer getScore() {
		return score;
	}
	public void setScore(Integer score) {
		this.score = score;
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
	public Long getReportId() {
		return reportId;
	}
	public void setReportId(Long reportId) {
		this.reportId = reportId;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public LocalDateTime getSuspensionStartAt() {
		return suspensionStartAt;
	}
	public void setSuspensionStartAt(LocalDateTime suspensionStartAt) {
		this.suspensionStartAt = suspensionStartAt;
	}
	public LocalDateTime getSuspensionEndAt() {
		return suspensionEndAt;
	}
	public void setSuspensionEndAt(LocalDateTime suspensionEndAt) {
		this.suspensionEndAt = suspensionEndAt;
	}
	public Boolean getPermanentSuspension() {
		return permanentSuspension;
	}
	public void setPermanentSuspension(Boolean permanentSuspension) {
		this.permanentSuspension = permanentSuspension;
	}
	public Long getCancelledAdminId() {
		return cancelledAdminId;
	}
	public void setCancelledAdminId(Long cancelledAdminId) {
		this.cancelledAdminId = cancelledAdminId;
	}
	
	@Override
	public String toString() {
		return "UserPenalty [penaltyId=" + penaltyId + ", userId=" + userId + ", receivedAt=" + receivedAt + ", score="
				+ score + ", matchType=" + matchType + ", matchId=" + matchId + ", reportId=" + reportId + ", reason="
				+ reason + ", suspensionStartAt=" + suspensionStartAt + ", suspensionEndAt=" + suspensionEndAt
				+ ", permanentSuspension=" + permanentSuspension + ", cancelledAdminId=" + cancelledAdminId + "]";
	}
    
    
    
}
