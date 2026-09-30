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
    
    
    
	public TeamPayment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TeamPayment(Long paymentId, String orderId, String paymentKey, String orderName, String paymentStatus,
			String paymentMethod, Integer totalAmount, Integer balance, String currency, String cardCompany,
			String cardNumber, Integer installmentMonths, String easyPaymentProvider, String receiptUrl,
			LocalDateTime requestedAt, LocalDateTime approvedAt, String rawResponse) {
		super();
		this.paymentId = paymentId;
		this.orderId = orderId;
		this.paymentKey = paymentKey;
		this.orderName = orderName;
		this.paymentStatus = paymentStatus;
		this.paymentMethod = paymentMethod;
		this.totalAmount = totalAmount;
		this.balance = balance;
		this.currency = currency;
		this.cardCompany = cardCompany;
		this.cardNumber = cardNumber;
		this.installmentMonths = installmentMonths;
		this.easyPaymentProvider = easyPaymentProvider;
		this.receiptUrl = receiptUrl;
		this.requestedAt = requestedAt;
		this.approvedAt = approvedAt;
		this.rawResponse = rawResponse;
	}
	
	public Long getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(Long paymentId) {
		this.paymentId = paymentId;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getPaymentKey() {
		return paymentKey;
	}
	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public Integer getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(Integer totalAmount) {
		this.totalAmount = totalAmount;
	}
	public Integer getBalance() {
		return balance;
	}
	public void setBalance(Integer balance) {
		this.balance = balance;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getCardCompany() {
		return cardCompany;
	}
	public void setCardCompany(String cardCompany) {
		this.cardCompany = cardCompany;
	}
	public String getCardNumber() {
		return cardNumber;
	}
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	public Integer getInstallmentMonths() {
		return installmentMonths;
	}
	public void setInstallmentMonths(Integer installmentMonths) {
		this.installmentMonths = installmentMonths;
	}
	public String getEasyPaymentProvider() {
		return easyPaymentProvider;
	}
	public void setEasyPaymentProvider(String easyPaymentProvider) {
		this.easyPaymentProvider = easyPaymentProvider;
	}
	public String getReceiptUrl() {
		return receiptUrl;
	}
	public void setReceiptUrl(String receiptUrl) {
		this.receiptUrl = receiptUrl;
	}
	public LocalDateTime getRequestedAt() {
		return requestedAt;
	}
	public void setRequestedAt(LocalDateTime requestedAt) {
		this.requestedAt = requestedAt;
	}
	public LocalDateTime getApprovedAt() {
		return approvedAt;
	}
	public void setApprovedAt(LocalDateTime approvedAt) {
		this.approvedAt = approvedAt;
	}
	public String getRawResponse() {
		return rawResponse;
	}
	public void setRawResponse(String rawResponse) {
		this.rawResponse = rawResponse;
	}
	
	@Override
	public String toString() {
		return "TeamPayment [paymentId=" + paymentId + ", orderId=" + orderId + ", paymentKey=" + paymentKey
				+ ", orderName=" + orderName + ", paymentStatus=" + paymentStatus + ", paymentMethod=" + paymentMethod
				+ ", totalAmount=" + totalAmount + ", balance=" + balance + ", currency=" + currency + ", cardCompany="
				+ cardCompany + ", cardNumber=" + cardNumber + ", installmentMonths=" + installmentMonths
				+ ", easyPaymentProvider=" + easyPaymentProvider + ", receiptUrl=" + receiptUrl + ", requestedAt="
				+ requestedAt + ", approvedAt=" + approvedAt + ", rawResponse=" + rawResponse + "]";
	}
    
    
    
}
