package dto;
import java.time.LocalDateTime;

/** 팀 패널티 */
public class TeamPenalty {

    private Long penaltyId;                   // 패널티 ID (PK)
    private Long teamId;                      // 팀 ID
    private LocalDateTime receivedAt;         // 패널티 부여 일시
    private Integer score;                    // 패널티 점수
    private Long matchId;                     // 매치 ID
    private Long reportId;                    // 신고 ID
    private String reason;                    // 패널티 사유
    private LocalDateTime suspensionStartAt;  // 정지 시작 일시
    private LocalDateTime suspensionEndAt;    // 정지 종료 일시
    private Boolean permanentSuspension;      // 영구 정지 여부
    private Long cancelledAdminId;            // 패널티 취소 관리자 ID
    
    
    
    
    
	public TeamPenalty() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public TeamPenalty(Long penaltyId, Long teamId, LocalDateTime receivedAt, Integer score, Long matchId,
			Long reportId, String reason, LocalDateTime suspensionStartAt, LocalDateTime suspensionEndAt,
			Boolean permanentSuspension, Long cancelledAdminId) {
		super();
		this.penaltyId = penaltyId;
		this.teamId = teamId;
		this.receivedAt = receivedAt;
		this.score = score;
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
	public Long getTeamId() {
		return teamId;
	}
	public void setTeamId(Long teamId) {
		this.teamId = teamId;
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
		return "TeamPenalty [penaltyId=" + penaltyId + ", teamId=" + teamId + ", receivedAt=" + receivedAt + ", score="
				+ score + ", matchId=" + matchId + ", reportId=" + reportId + ", reason=" + reason
				+ ", suspensionStartAt=" + suspensionStartAt + ", suspensionEndAt=" + suspensionEndAt
				+ ", permanentSuspension=" + permanentSuspension + ", cancelledAdminId=" + cancelledAdminId + "]";
	}
    
	
    
}
