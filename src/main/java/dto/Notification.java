package dto;
import java.time.LocalDateTime;

/** 알림 */
public class Notification {

    private Long notificationId;      // 알림 ID (PK)
    private Long userId;              // 수신 회원 ID
    private String content;           // 알림 내용
    private Boolean isRead;           // 읽음 여부
    private LocalDateTime createdAt;  // 생성 일시
    private String title;             // 알림 제목
    private String link;              // 이동 링크
}
