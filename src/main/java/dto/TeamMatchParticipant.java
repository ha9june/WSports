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
}
