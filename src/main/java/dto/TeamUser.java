package dto;
import java.time.LocalDateTime;

/** 팀 멤버 */
public class TeamUser {

    private Long teamUserId;            // 팀 멤버 ID (PK)
    private Long teamId;                // 팀 ID
    private Long userId;                // 회원 ID
    private String teamRole;            // 팀 내 역할
    private Boolean withdrawn;          // 탈퇴 여부
    private LocalDateTime joinedAt;     // 가입 일시
    private LocalDateTime withdrawnAt;  // 탈퇴 일시
}
