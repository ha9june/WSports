package dto;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/** 팀 평점 */
public class TeamRating {

    private Long ratingId;            // 평점 ID (PK)
    private Long teamId;              // 평가 받은 팀 ID
    private Long evaluatorUserId;     // 평가한 회원 ID
    private BigDecimal score;         // 평점
    private LocalDateTime createdAt;  // 평가 일시
    private Long matchId;             // 매치 ID
    
    
    
	public TeamRating() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TeamRating(Long ratingId, Long teamId, Long evaluatorUserId, BigDecimal score, LocalDateTime createdAt,
			Long matchId) {
		super();
		this.ratingId = ratingId;
		this.teamId = teamId;
		this.evaluatorUserId = evaluatorUserId;
		this.score = score;
		this.createdAt = createdAt;
		this.matchId = matchId;
	}
	
	public Long getRatingId() {
		return ratingId;
	}
	public void setRatingId(Long ratingId) {
		this.ratingId = ratingId;
	}
	public Long getTeamId() {
		return teamId;
	}
	public void setTeamId(Long teamId) {
		this.teamId = teamId;
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
	public Long getMatchId() {
		return matchId;
	}
	public void setMatchId(Long matchId) {
		this.matchId = matchId;
	}

	@Override
	public String toString() {
		return "TeamRating [ratingId=" + ratingId + ", teamId=" + teamId + ", evaluatorUserId=" + evaluatorUserId
				+ ", score=" + score + ", createdAt=" + createdAt + ", matchId=" + matchId + "]";
	}
    
    
}
