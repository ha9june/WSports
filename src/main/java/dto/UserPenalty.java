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
}
