package dto;
import java.time.LocalDateTime;

/** 팀 매치 참가자 */
public class TeamMatchParticipant {

    private Long participantId;         // 참가자 ID (PK)
    private Long userId;                // 회원 ID
    private Long teamMatchId;           // 팀 매치 ID
    private Long teamId;                // 팀 ID
    private LocalDateTime appliedAt;    // 신청 일시
    private String status;              // 참가 상태
    private Long paymentId;             // 결제 ID
    private Boolean attendance;         // 출석 여부
    private LocalDateTime cancelledAt;  // 취소 일시
    
    
    
	public TeamMatchParticipant() {
		super();
		// TODO Auto-generated constructor stub
	}


	public TeamMatchParticipant(Long participantId, Long userId, Long teamMatchId, Long teamId, LocalDateTime appliedAt,
			String status, Long paymentId, Boolean attendance, LocalDateTime cancelledAt) {
		super();
		this.participantId = participantId;
		this.userId = userId;
		this.teamMatchId = teamMatchId;
		this.teamId = teamId;
		this.appliedAt = appliedAt;
		this.status = status;
		this.paymentId = paymentId;
		this.attendance = attendance;
		this.cancelledAt = cancelledAt;
	}
	
	
	public Long getParticipantId() {
		return participantId;
	}
	public void setParticipantId(Long participantId) {
		this.participantId = participantId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getTeamMatchId() {
		return teamMatchId;
	}
	public void setTeamMatchId(Long teamMatchId) {
		this.teamMatchId = teamMatchId;
	}
	public Long getTeamId() {
		return teamId;
	}
	public void setTeamId(Long teamId) {
		this.teamId = teamId;
	}
	public LocalDateTime getAppliedAt() {
		return appliedAt;
	}
	public void setAppliedAt(LocalDateTime appliedAt) {
		this.appliedAt = appliedAt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Long getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(Long paymentId) {
		this.paymentId = paymentId;
	}
	public Boolean getAttendance() {
		return attendance;
	}
	public void setAttendance(Boolean attendance) {
		this.attendance = attendance;
	}
	public LocalDateTime getCancelledAt() {
		return cancelledAt;
	}
	public void setCancelledAt(LocalDateTime cancelledAt) {
		this.cancelledAt = cancelledAt;
	}


	@Override
	public String toString() {
		return "TeamMatchParticipant [participantId=" + participantId + ", userId=" + userId + ", teamMatchId="
				+ teamMatchId + ", teamId=" + teamId + ", appliedAt=" + appliedAt + ", status=" + status
				+ ", paymentId=" + paymentId + ", attendance=" + attendance + ", cancelledAt=" + cancelledAt + "]";
	}
    
    
    
}
