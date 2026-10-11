package dto;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.TextStyle;
import java.util.Locale;

/** 팀 매치 */
public class TeamMatch {

    private Long teamMatchId;           // 팀 매치 ID (PK)
    private String title;               // 제목
    private String content;             // 내용
    private Long userId;                // 작성자 회원 ID
    private Long teamId;                // 팀 ID
    private LocalDateTime createdAt;    // 작성 일시
    private LocalDate matchDate;        // 경기 날짜
    private String sport;               // 종목
    private LocalTime startTime;        // 시작 시간
    private LocalTime endTime;          // 종료 시간
    private String placeName;           // 장소명
    private String address;             // 주소
    private BigDecimal latitude;        // 위도
    private BigDecimal longitude;       // 경도
    private Integer participationFee;   // 참가비
    private Integer fee;                // 수수료
    private LocalDateTime deadline;     // 모집 마감 일시
    private Boolean skillIntro;         // 실력: 입문 허용 여부
    private Boolean skillBeginner;      // 실력: 초급 허용 여부
    private Boolean skillIntermediate;  // 실력: 중급 허용 여부
    private Boolean skillAdvanced;      // 실력: 고급 허용 여부
    private Boolean age20s;             // 20대 허용 여부
    private Boolean age30s;             // 30대 허용 여부
    private Boolean age40s;             // 40대 허용 여부
    private Boolean age50s;             // 50대 허용 여부
    private Boolean age60Plus;          // 60대 이상 허용 여부
    private String gender;              // 성별 구분
    private Integer matchPeople;        // 매치 인원
    private Boolean deleted;            // 삭제 여부
    private LocalDateTime updatedAt;    // 수정 일시
    private LocalDateTime deletedAt;    // 삭제 일시
    private String image1;              // 이미지 1
    private String image2;              // 이미지 2
    private String image3;              // 이미지 3
    private String image4;              // 이미지 4
    private String image5;              // 이미지 5
    private String status;              // 매치 상태
    private String region;              // 지역
    
    //디비에서 가져오는 값
    private String teamName;
    private Double teamRating;
    private Integer teamRatingCount;
    private String hostNickname;
    private String hostProfileImage;
    private String hostBio;
    private String hostRegion1, hostRegion2, hostRegion3;
    private String hostRole;
    private String hostSkill;
    private Double hostRating;        // 평가가 없으면 null이어야 해서 래퍼 타입
    private Integer hostRatingCount;

    private boolean favorite;

    public boolean isFavorite() { return favorite; }
    public void setFavorite(boolean favorite) { this.favorite = favorite; }
    
	public String getDayOfWeekKorean() {
	    if (matchDate == null) {
	        return "";
	    }
	    String day = matchDate.getDayOfWeek()
	            .getDisplayName(TextStyle.FULL, Locale.KOREAN);
	    return day.substring(0, 1);
	}
	private Integer minPeople;
	public Integer getMinPeople() {
		return minPeople;
	}
	public void setMinPeople(Integer minPeople) {
		this.minPeople = minPeople;
	}
	private Integer maxPeople;
	private Integer currentPeople;

	public Integer getMaxPeople() { return maxPeople; }
	public void setMaxPeople(Integer maxPeople) { this.maxPeople = maxPeople; }
	public Integer getCurrentPeople() { return currentPeople; }
	public void setCurrentPeople(Integer currentPeople) { this.currentPeople = currentPeople; }
    
	public TeamMatch() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Long getTeamMatchId() {
		return teamMatchId;
	}
	public void setTeamMatchId(Long teamMatchId) {
		this.teamMatchId = teamMatchId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDate getMatchDate() {
		return matchDate;
	}
	public void setMatchDate(LocalDate matchDate) {
		this.matchDate = matchDate;
	}
	public String getSport() {
		return sport;
	}
	public void setSport(String sport) {
		this.sport = sport;
	}
	public LocalTime getStartTime() {
		return startTime;
	}
	public void setStartTime(LocalTime startTime) {
		this.startTime = startTime;
	}
	public LocalTime getEndTime() {
		return endTime;
	}
	public void setEndTime(LocalTime endTime) {
		this.endTime = endTime;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public BigDecimal getLatitude() {
		return latitude;
	}
	public void setLatitude(BigDecimal latitude) {
		this.latitude = latitude;
	}
	public BigDecimal getLongitude() {
		return longitude;
	}
	public void setLongitude(BigDecimal longitude) {
		this.longitude = longitude;
	}
	public Integer getParticipationFee() {
		return participationFee;
	}
	public void setParticipationFee(Integer participationFee) {
		this.participationFee = participationFee;
	}
	public Integer getFee() {
		return fee;
	}
	public void setFee(Integer fee) {
		this.fee = fee;
	}
	public LocalDateTime getDeadline() {
		return deadline;
	}
	public void setDeadline(LocalDateTime deadline) {
		this.deadline = deadline;
	}
	public Boolean getSkillIntro() {
		return skillIntro;
	}
	public void setSkillIntro(Boolean skillIntro) {
		this.skillIntro = skillIntro;
	}
	public Boolean getSkillBeginner() {
		return skillBeginner;
	}
	public void setSkillBeginner(Boolean skillBeginner) {
		this.skillBeginner = skillBeginner;
	}
	public Boolean getSkillIntermediate() {
		return skillIntermediate;
	}
	public void setSkillIntermediate(Boolean skillIntermediate) {
		this.skillIntermediate = skillIntermediate;
	}
	public Boolean getSkillAdvanced() {
		return skillAdvanced;
	}
	public void setSkillAdvanced(Boolean skillAdvanced) {
		this.skillAdvanced = skillAdvanced;
	}
	public Boolean getAge20s() {
		return age20s;
	}
	public void setAge20s(Boolean age20s) {
		this.age20s = age20s;
	}
	public Boolean getAge30s() {
		return age30s;
	}
	public void setAge30s(Boolean age30s) {
		this.age30s = age30s;
	}
	public Boolean getAge40s() {
		return age40s;
	}
	public void setAge40s(Boolean age40s) {
		this.age40s = age40s;
	}
	public Boolean getAge50s() {
		return age50s;
	}
	public void setAge50s(Boolean age50s) {
		this.age50s = age50s;
	}
	public Boolean getAge60Plus() {
		return age60Plus;
	}
	public void setAge60Plus(Boolean age60Plus) {
		this.age60Plus = age60Plus;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public Integer getMatchPeople() {
		return matchPeople;
	}
	public void setMatchPeople(Integer matchPeople) {
		this.matchPeople = matchPeople;
	}
	public Boolean getDeleted() {
		return deleted;
	}
	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
	public LocalDateTime getDeletedAt() {
		return deletedAt;
	}
	public void setDeletedAt(LocalDateTime deletedAt) {
		this.deletedAt = deletedAt;
	}
	public String getImage1() {
		return image1;
	}
	public void setImage1(String image1) {
		this.image1 = image1;
	}
	public String getImage2() {
		return image2;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	public String getImage3() {
		return image3;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}
	public String getImage4() {
		return image4;
	}
	public void setImage4(String image4) {
		this.image4 = image4;
	}
	public String getImage5() {
		return image5;
	}
	public void setImage5(String image5) {
		this.image5 = image5;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public Double getTeamRating() {
		return teamRating;
	}
	public void setTeamRating(Double teamRating) {
		this.teamRating = teamRating;
	}
	public String getHostNickname() {
		return hostNickname;
	}
	public void setHostNickname(String hostNickname) {
		this.hostNickname = hostNickname;
	}
	public String getHostProfileImage() {
		return hostProfileImage;
	}
	public void setHostProfileImage(String hostProfileImage) {
		this.hostProfileImage = hostProfileImage;
	}
	public String getHostBio() {
		return hostBio;
	}
	public void setHostBio(String hostBio) {
		this.hostBio = hostBio;
	}
	public String getHostRegion1() {
		return hostRegion1;
	}
	public void setHostRegion1(String hostRegion1) {
		this.hostRegion1 = hostRegion1;
	}
	public String getHostRegion2() {
		return hostRegion2;
	}
	public void setHostRegion2(String hostRegion2) {
		this.hostRegion2 = hostRegion2;
	}
	public String getHostRegion3() {
		return hostRegion3;
	}
	public void setHostRegion3(String hostRegion3) {
		this.hostRegion3 = hostRegion3;
	}
	public String getHostRole() {
		return hostRole;
	}
	public void setHostRole(String hostRole) {
		this.hostRole = hostRole;
	}
	public String getHostSkill() {
		return hostSkill;
	}
	public void setHostSkill(String hostSkill) {
		this.hostSkill = hostSkill;
	}
	public Double getHostRating() {
		return hostRating;
	}
	public void setHostRating(Double hostRating) {
		this.hostRating = hostRating;
	}
	public Integer getHostRatingCount() {
		return hostRatingCount;
	}
	public void setHostRatingCount(Integer hostRatingCount) {
		this.hostRatingCount = hostRatingCount;
	}
	public Integer getTeamRatingCount() {
		return teamRatingCount;
	}
	public void setTeamRatingCount(Integer teamRatingCount) {
		this.teamRatingCount = teamRatingCount;
	}
	@Override
	public String toString() {
		return "TeamMatch [teamMatchId=" + teamMatchId + ", title=" + title + ", content=" + content + ", userId="
				+ userId + ", teamId=" + teamId + ", createdAt=" + createdAt + ", matchDate=" + matchDate + ", sport="
				+ sport + ", startTime=" + startTime + ", endTime=" + endTime + ", placeName=" + placeName
				+ ", address=" + address + ", latitude=" + latitude + ", longitude=" + longitude + ", participationFee="
				+ participationFee + ", fee=" + fee + ", deadline=" + deadline + ", skillIntro=" + skillIntro
				+ ", skillBeginner=" + skillBeginner + ", skillIntermediate=" + skillIntermediate + ", skillAdvanced="
				+ skillAdvanced + ", age20s=" + age20s + ", age30s=" + age30s + ", age40s=" + age40s + ", age50s="
				+ age50s + ", age60Plus=" + age60Plus + ", gender=" + gender + ", matchPeople=" + matchPeople
				+ ", deleted=" + deleted + ", updatedAt=" + updatedAt + ", deletedAt=" + deletedAt + ", image1="
				+ image1 + ", image2=" + image2 + ", image3=" + image3 + ", image4=" + image4 + ", image5=" + image5
				+ ", status=" + status + ", region=" + region + ", teamName=" + teamName + ", teamRating=" + teamRating
				+ ", teamRatingCount=" + teamRatingCount + ", hostNickname=" + hostNickname + ", hostProfileImage="
				+ hostProfileImage + ", hostBio=" + hostBio + ", hostRegion1=" + hostRegion1 + ", hostRegion2="
				+ hostRegion2 + ", hostRegion3=" + hostRegion3 + ", hostRole=" + hostRole + ", hostSkill=" + hostSkill
				+ ", hostRating=" + hostRating + ", hostRatingCount=" + hostRatingCount + ", favorite=" + favorite
				+ "]";
	}

    
    
}
