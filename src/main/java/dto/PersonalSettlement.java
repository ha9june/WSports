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
    
    
    
    
    
	public PersonalSettlement() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public PersonalSettlement(Long settlementId, Long userId, Long personalMatchId, String accountNumber,
			String bankName, Integer amount, String settlementStatus, LocalDateTime settledAt, Long adminId) {
		super();
		this.settlementId = settlementId;
		this.userId = userId;
		this.personalMatchId = personalMatchId;
		this.accountNumber = accountNumber;
		this.bankName = bankName;
		this.amount = amount;
		this.settlementStatus = settlementStatus;
		this.settledAt = settledAt;
		this.adminId = adminId;
	}



	public Long getSettlementId() {
		return settlementId;
	}
	public void setSettlementId(Long settlementId) {
		this.settlementId = settlementId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getPersonalMatchId() {
		return personalMatchId;
	}
	public void setPersonalMatchId(Long personalMatchId) {
		this.personalMatchId = personalMatchId;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public String getSettlementStatus() {
		return settlementStatus;
	}
	public void setSettlementStatus(String settlementStatus) {
		this.settlementStatus = settlementStatus;
	}
	public LocalDateTime getSettledAt() {
		return settledAt;
	}
	public void setSettledAt(LocalDateTime settledAt) {
		this.settledAt = settledAt;
	}
	public Long getAdminId() {
		return adminId;
	}
	public void setAdminId(Long adminId) {
		this.adminId = adminId;
	}
	
	
	@Override
	public String toString() {
		return "PersonalSettlement [settlementId=" + settlementId + ", userId=" + userId + ", personalMatchId="
				+ personalMatchId + ", accountNumber=" + accountNumber + ", bankName=" + bankName + ", amount=" + amount
				+ ", settlementStatus=" + settlementStatus + ", settledAt=" + settledAt + ", adminId=" + adminId + "]";
	}
    
   
}
