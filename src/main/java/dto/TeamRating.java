package dto;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/** 팀 평점 */
public class TeamRating {

    private Long ratingId;            // 평점 ID (PK)
    private Long teamId;              // 평가 받은 팀 ID
    private Long evaluatorUserId;     // 평가한 회원 ID
    private BigDecimal score;         // 평점
    private LocalDateTime createdAt;  // 평가 일시
    private Long matchId;             // 매치 ID
}
