package dto;
import java.time.LocalDateTime;

/** 팀 가입 신청 */
public class TeamApplication {

    private Long applicationId;         // 신청 ID (PK)
    private Long userId;                // 신청 회원 ID
    private Long teamId;                // 팀 ID
    private String message;             // 신청 메시지
    private String status;              // 신청 상태
    private String rejectionReason;     // 거절 사유
    private LocalDateTime appliedAt;    // 신청 일시
    private LocalDateTime processedAt;  // 처리 일시
    //조인해서 가져와서 넣을거
    private String profileImage;
    private String nickname;
    private String preferredRegion1;
    private String soccerSkill;              // 축구 실력
    private String basketballSkill;          // 농구 실력
    private String tennisSkill;              // 테니스 실력
    private String badmintonSkill;           // 배드민턴 실력
    private String skill;

	public TeamApplication() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TeamApplication(Long applicationId, Long userId, Long teamId, String message, String status,
			String rejectionReason, LocalDateTime appliedAt, LocalDateTime processedAt, String profileImage,
			String nickname, String preferredRegion1, String soccerSkill, String basketballSkill, String tennisSkill,
			String badmintonSkill, String skill) {
		super();
		this.applicationId = applicationId;
		this.userId = userId;
		this.teamId = teamId;
		this.message = message;
		this.status = status;
		this.rejectionReason = rejectionReason;
		this.appliedAt = appliedAt;
		this.processedAt = processedAt;
		this.profileImage = profileImage;
		this.nickname = nickname;
		this.preferredRegion1 = preferredRegion1;
		this.soccerSkill = soccerSkill;
		this.basketballSkill = basketballSkill;
		this.tennisSkill = tennisSkill;
		this.badmintonSkill = badmintonSkill;
		this.skill = skill;
	}

	@Override
	public String toString() {
		return "TeamApplication [applicationId=" + applicationId + ", userId=" + userId + ", teamId=" + teamId
				+ ", message=" + message + ", status=" + status + ", rejectionReason=" + rejectionReason
				+ ", appliedAt=" + appliedAt + ", processedAt=" + processedAt + ", profileImage=" + profileImage
				+ ", nickname=" + nickname + ", preferredRegion1=" + preferredRegion1 + ", soccerSkill=" + soccerSkill
				+ ", basketballSkill=" + basketballSkill + ", tennisSkill=" + tennisSkill + ", badmintonSkill="
				+ badmintonSkill + ", skill=" + skill + "]";
	}

	public Long getApplicationId() {
		return applicationId;
	}

	public void setApplicationId(Long applicationId) {
		this.applicationId = applicationId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getTeamId() {
		return teamId;
	}

	public void setTeamId(Long teamId) {
		this.teamId = teamId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRejectionReason() {
		return rejectionReason;
	}

	public void setRejectionReason(String rejectionReason) {
		this.rejectionReason = rejectionReason;
	}

	public LocalDateTime getAppliedAt() {
		return appliedAt;
	}

	public void setAppliedAt(LocalDateTime appliedAt) {
		this.appliedAt = appliedAt;
	}

	public LocalDateTime getProcessedAt() {
		return processedAt;
	}

	public void setProcessedAt(LocalDateTime processedAt) {
		this.processedAt = processedAt;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPreferredRegion1() {
		return preferredRegion1;
	}

	public void setPreferredRegion1(String preferredRegion1) {
		this.preferredRegion1 = preferredRegion1;
	}

	public String getSoccerSkill() {
		return soccerSkill;
	}

	public void setSoccerSkill(String soccerSkill) {
		this.soccerSkill = soccerSkill;
	}

	public String getBasketballSkill() {
		return basketballSkill;
	}

	public void setBasketballSkill(String basketballSkill) {
		this.basketballSkill = basketballSkill;
	}

	public String getTennisSkill() {
		return tennisSkill;
	}

	public void setTennisSkill(String tennisSkill) {
		this.tennisSkill = tennisSkill;
	}

	public String getBadmintonSkill() {
		return badmintonSkill;
	}

	public void setBadmintonSkill(String badmintonSkill) {
		this.badmintonSkill = badmintonSkill;
	}

	public String getSkill() {
		return skill;
	}

	public void setSkill(String skill) {
		this.skill = skill;
	}
    
}
