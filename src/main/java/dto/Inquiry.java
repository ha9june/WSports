package dto;
import java.time.LocalDateTime;

/** 문의 */
public class Inquiry {

    private Long inquiryId;            // 문의 ID (PK)
    private Long userId;               // 문의 회원 ID
    private String type;               // 문의 유형
    private String title;              // 제목
    private String content;            // 내용
    private LocalDateTime createdAt;   // 문의 일시
    private String answerStatus;       // 답변 상태
    private String answer;             // 답변 내용
    private LocalDateTime answeredAt;  // 답변 일시
    private Long adminId;              // 답변 관리자 ID
    private Boolean deleted;           // 삭제 여부
}
