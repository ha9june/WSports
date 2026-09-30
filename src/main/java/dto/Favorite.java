package dto;
import java.time.LocalDateTime;

/** 찜 */
public class Favorite {

    private Long favoriteId;          // 찜 ID (PK)
    private Long userId;              // 회원 ID
    private Long matchId;             // 매치 ID
    private LocalDateTime createdAt;  // 찜 일시
    private String matchType;         // 매치 유형 (개인/팀)
    
    
    
	public Favorite() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Favorite(Long favoriteId, Long userId, Long matchId, LocalDateTime createdAt, String matchType) {
		super();
		this.favoriteId = favoriteId;
		this.userId = userId;
		this.matchId = matchId;
		this.createdAt = createdAt;
		this.matchType = matchType;
	}
	
	public Long getFavoriteId() {
		return favoriteId;
	}
	public void setFavoriteId(Long favoriteId) {
		this.favoriteId = favoriteId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getMatchId() {
		return matchId;
	}
	public void setMatchId(Long matchId) {
		this.matchId = matchId;
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

	@Override
	public String toString() {
		return "Favorite [favoriteId=" + favoriteId + ", userId=" + userId + ", matchId=" + matchId + ", createdAt="
				+ createdAt + ", matchType=" + matchType + "]";
	}
    
	
}
