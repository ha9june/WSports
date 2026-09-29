package dto;
import java.time.LocalDateTime;

/** 신고 */
public class Report {

    private Long reportId;             // 신고 ID (PK)
    private Long userId;               // 신고자 회원 ID
    private String type;               // 신고 유형
    private String title;              // 제목
    private String content;            // 내용
    private String postType;           // 신고 대상 게시글 유형
    private Long postId;               // 신고 대상 게시글 ID
    private LocalDateTime createdAt;   // 신고 일시
    private String status;             // 처리 상태
    private String answer;             // 답변 내용
    private LocalDateTime answeredAt;  // 답변 일시
    private Long adminId;              // 처리 관리자 ID
    private Boolean deleted;           // 삭제 여부
}
