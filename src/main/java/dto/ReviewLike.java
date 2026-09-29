package dto;
import java.time.LocalDateTime;

/** 후기 좋아요 */
public class ReviewLike {

    private Long reviewLikeId;        // 좋아요 ID (PK)
    private Long userId;              // 회원 ID
    private Long reviewId;            // 후기 ID
    private LocalDateTime createdAt;  // 좋아요 일시
}
