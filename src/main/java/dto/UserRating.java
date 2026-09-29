package dto;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/** 회원 평점 */
public class UserRating {

    private Long ratingId;            // 평점 ID (PK)
    private Long receiverUserId;      // 평가 받은 회원 ID
    private Long evaluatorUserId;     // 평가한 회원 ID
    private BigDecimal score;         // 평점
    private LocalDateTime createdAt;  // 평가 일시
    private String matchType;         // 매치 유형 (개인/팀)
    private Long matchId;             // 매치 ID
}
