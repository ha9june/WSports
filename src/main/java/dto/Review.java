package dto;
import java.time.LocalDateTime;

/** 후기 */
public class Review {

    private Long reviewId;            // 후기 ID (PK)
    private Long userId;              // 작성자 회원 ID
    private String matchType;         // 매치 유형 (개인/팀)
    private Long matchId;             // 매치 ID
    private String title;             // 제목
    private String content;           // 내용
    private String image;             // 이미지
    private Boolean deleted;          // 삭제 여부
    private LocalDateTime createdAt;  // 작성 일시
    private LocalDateTime updatedAt;  // 수정 일시
}
