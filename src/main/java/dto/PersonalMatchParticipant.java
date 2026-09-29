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
}
