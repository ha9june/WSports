package dto;
import java.time.LocalDateTime;

/** 후기 댓글 */
public class Comment {

    private Long commentId;           // 댓글 ID (PK)
    private Long parentCommentId;     // 부모 댓글 ID (대댓글일 때)
    private Long reviewId;            // 후기 ID
    private Long userId;              // 작성자 회원 ID
    private String content;           // 댓글 내용
    private LocalDateTime createdAt;  // 작성 일시
    private LocalDateTime updatedAt;  // 수정 일시
    private Boolean deleted;          // 삭제 여부
}
