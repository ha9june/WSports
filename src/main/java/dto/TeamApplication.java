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
}
