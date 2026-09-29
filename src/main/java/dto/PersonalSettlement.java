package dto;
import java.time.LocalDateTime;

/** 개인 매치 정산 */
public class PersonalSettlement {

    private Long settlementId;        // 정산 ID (PK)
    private Long userId;              // 정산 대상 회원 ID
    private Long personalMatchId;     // 개인 매치 ID
    private String accountNumber;     // 계좌번호
    private String bankName;          // 은행명
    private Integer amount;           // 정산 금액
    private String settlementStatus;  // 정산 상태
    private LocalDateTime settledAt;  // 정산 일시
    private Long adminId;             // 처리 관리자 ID
}
