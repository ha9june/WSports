package dto;
import java.time.LocalDateTime;

/** 팀 멤버 */
public class TeamUser {

    private Long teamUserId;            // 팀 멤버 ID (PK)
    private Long teamId;                // 팀 ID
    private Long userId;                // 회원 ID
    private String teamRole;            // 팀 내 역할
    private Boolean withdrawn;          // 탈퇴 여부
    private LocalDateTime joinedAt;     // 가입 일시
    private LocalDateTime withdrawnAt;  // 탈퇴 일시
    
    
    
	public TeamUser() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public TeamUser(Long teamUserId, Long teamId, Long userId, String teamRole, Boolean withdrawn,
			LocalDateTime joinedAt, LocalDateTime withdrawnAt) {
		super();
		this.teamUserId = teamUserId;
		this.teamId = teamId;
		this.userId = userId;
		this.teamRole = teamRole;
		this.withdrawn = withdrawn;
		this.joinedAt = joinedAt;
		this.withdrawnAt = withdrawnAt;
	}


	public Long getTeamUserId() {
		return teamUserId;
	}
	public void setTeamUserId(Long teamUserId) {
		this.teamUserId = teamUserId;
	}
	public Long getTeamId() {
		return teamId;
	}
	public void setTeamId(Long teamId) {
		this.teamId = teamId;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getTeamRole() {
		return teamRole;
	}
	public void setTeamRole(String teamRole) {
		this.teamRole = teamRole;
	}
	public Boolean getWithdrawn() {
		return withdrawn;
	}
	public void setWithdrawn(Boolean withdrawn) {
		this.withdrawn = withdrawn;
	}
	public LocalDateTime getJoinedAt() {
		return joinedAt;
	}
	public void setJoinedAt(LocalDateTime joinedAt) {
		this.joinedAt = joinedAt;
	}
	public LocalDateTime getWithdrawnAt() {
		return withdrawnAt;
	}
	public void setWithdrawnAt(LocalDateTime withdrawnAt) {
		this.withdrawnAt = withdrawnAt;
	}


	@Override
	public String toString() {
		return "TeamUser [teamUserId=" + teamUserId + ", teamId=" + teamId + ", userId=" + userId + ", teamRole="
				+ teamRole + ", withdrawn=" + withdrawn + ", joinedAt=" + joinedAt + ", withdrawnAt=" + withdrawnAt
				+ "]";
	}
    
    
    
}
