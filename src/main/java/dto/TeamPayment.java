package dto;
import java.time.LocalDateTime;

/** 팀 매치 결제 */
public class TeamPayment {

    private Long paymentId;              // 결제 ID (PK)
    private String orderId;              // 주문 ID
    private String paymentKey;           // 결제 키 (PG사 발급)
    private String orderName;            // 주문명
    private String paymentStatus;        // 결제 상태
    private String paymentMethod;        // 결제 수단
    private Integer totalAmount;         // 총 결제 금액
    private Integer balance;             // 잔액 (취소 후 남은 금액)
    private String currency;             // 통화
    private String cardCompany;          // 카드사
    private String cardNumber;           // 카드 번호 (마스킹)
    private Integer installmentMonths;   // 할부 개월 수
    private String easyPaymentProvider;  // 간편결제 제공사
    private String receiptUrl;           // 영수증 URL
    private LocalDateTime requestedAt;   // 결제 요청 일시
    private LocalDateTime approvedAt;    // 결제 승인 일시
    private String rawResponse;          // PG사 원본 응답 (JSON)
}
