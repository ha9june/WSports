package dto;
import java.time.LocalDateTime;

/** 공지사항 */
public class Notice {

    private Long noticeId;            // 공지 ID (PK)
    private String title;             // 제목
    private String content;           // 내용
    private LocalDateTime createdAt;  // 작성 일시
    private Boolean isPinned;         // 상단 고정 여부
    private Long adminId;             // 작성 관리자 ID
    private String type;              // 공지 유형
    private Boolean deleted;          // 삭제 여부
    private LocalDateTime updatedAt;  // 수정 일시
}
