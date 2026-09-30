package dto;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/** 회원 평점 */
public class UserRating {

    private Long ratingId;            // 평점 ID (PK)
    private Long receiverUserId;      // 평가 받은 회원 ID
    private Long evaluatorUserId;     // 평가한 회원 ID
    private BigDecimal score;         // 평점
    private LocalDateTime createdAt;  // 평가 일시
    private String matchType;         // 매치 유형 (개인/팀)
    private Long matchId;             // 매치 ID
    
    
    
    
	public UserRating() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public UserRating(Long ratingId, Long receiverUserId, Long evaluatorUserId, BigDecimal score,
			LocalDateTime createdAt, String matchType, Long matchId) {
		super();
		this.ratingId = ratingId;
		this.receiverUserId = receiverUserId;
		this.evaluatorUserId = evaluatorUserId;
		this.score = score;
		this.createdAt = createdAt;
		this.matchType = matchType;
		this.matchId = matchId;
	}



	public Long getRatingId() {
		return ratingId;
	}
	public void setRatingId(Long ratingId) {
		this.ratingId = ratingId;
	}
	public Long getReceiverUserId() {
		return receiverUserId;
	}
	public void setReceiverUserId(Long receiverUserId) {
		this.receiverUserId = receiverUserId;
	}
	public Long getEvaluatorUserId() {
		return evaluatorUserId;
	}
	public void setEvaluatorUserId(Long evaluatorUserId) {
		this.evaluatorUserId = evaluatorUserId;
	}
	public BigDecimal getScore() {
		return score;
	}
	public void setScore(BigDecimal score) {
		this.score = score;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public String getMatchType() {
		return matchType;
	}
	public void setMatchType(String matchType) {
		this.matchType = matchType;
	}
	public Long getMatchId() {
		return matchId;
	}
	public void setMatchId(Long matchId) {
		this.matchId = matchId;
	}


	@Override
	public String toString() {
		return "UserRating [ratingId=" + ratingId + ", receiverUserId=" + receiverUserId + ", evaluatorUserId="
				+ evaluatorUserId + ", score=" + score + ", createdAt=" + createdAt + ", matchType=" + matchType
				+ ", matchId=" + matchId + "]";
	}
    
    
    
}
