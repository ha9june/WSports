package dto;
import java.time.LocalDateTime;

/** 찜 */
public class Favorite {

    private Long favoriteId;          // 찜 ID (PK)
    private Long userId;              // 회원 ID
    private Long matchId;             // 매치 ID
    private LocalDateTime createdAt;  // 찜 일시
    private String matchType;         // 매치 유형 (개인/팀)
}
