package dto;
import java.time.LocalDateTime;

/** 개인 매치 참가자 */
public class PersonalMatchParticipant {

    private Long participantId;         // 참가자 ID (PK)
    private Long userId;                // 회원 ID
    private Long personalMatchId;       // 개인 매치 ID
    private Boolean attendance;         // 출석 여부
    private String status;              // 참가 상태
    private Long paymentId;             // 결제 ID
    private LocalDateTime appliedAt;    // 신청 일시
    private LocalDateTime cancelledAt;  // 취소 일시
    private String cancelReason;        // 취소 사유
    
    
    
    
    
    
	public PersonalMatchParticipant() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
	public PersonalMatchParticipant(Long participantId, Long userId, Long personalMatchId, Boolean attendance,
			String status, Long paymentId, LocalDateTime appliedAt, LocalDateTime cancelledAt, String cancelReason) {
		super();
		this.participantId = participantId;
		this.userId = userId;
		this.personalMatchId = personalMatchId;
		this.attendance = attendance;
		this.status = status;
		this.paymentId = paymentId;
		this.appliedAt = appliedAt;
		this.cancelledAt = cancelledAt;
		this.cancelReason = cancelReason;
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
	public Long getPersonalMatchId() {
		return personalMatchId;
	}
	public void setPersonalMatchId(Long personalMatchId) {
		this.personalMatchId = personalMatchId;
	}
	public Boolean getAttendance() {
		return attendance;
	}
	public void setAttendance(Boolean attendance) {
		this.attendance = attendance;
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
	public LocalDateTime getAppliedAt() {
		return appliedAt;
	}
	public void setAppliedAt(LocalDateTime appliedAt) {
		this.appliedAt = appliedAt;
	}
	public LocalDateTime getCancelledAt() {
		return cancelledAt;
	}
	public void setCancelledAt(LocalDateTime cancelledAt) {
		this.cancelledAt = cancelledAt;
	}
	public String getCancelReason() {
		return cancelReason;
	}
	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}

	@Override
	public String toString() {
		return "PersonalMatchParticipant [participantId=" + participantId + ", userId=" + userId + ", personalMatchId="
				+ personalMatchId + ", attendance=" + attendance + ", status=" + status + ", paymentId=" + paymentId
				+ ", appliedAt=" + appliedAt + ", cancelledAt=" + cancelledAt + ", cancelReason=" + cancelReason + "]";
	}
    
    
    
}
