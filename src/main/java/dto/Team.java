package dto;
import java.time.LocalDateTime;

/** 팀 */
public class Team {
    private Long teamId;              // 팀 ID (PK)
    private String teamName;          // 팀 이름
    private String profileImage;      // 팀 프로필 이미지
    private String description;       // 팀 소개
    private String skill;             // 팀 실력
    private String sport;             // 종목
    private String gender;            // 성별 구분
    private LocalDateTime createdAt;  // 팀 생성 일시
    private Boolean deleted;          // 삭제 여부
    private String region1;           // 활동 지역 1
    private String region2;           // 활동 지역 2
    private String region3;           // 활동 지역 3
    private Boolean age20s;           // 20대 허용 여부
    private Boolean age30s;           // 30대 허용 여부
    private Boolean age40s;           // 40대 허용 여부
    private Boolean age50s;           // 50대 허용 여부
    private Boolean age60Plus;        // 60대 이상 허용 여부
    private Boolean dayMon;           // 활동 요일: 월
    private Boolean dayTue;           // 활동 요일: 화
    private Boolean dayWed;           // 활동 요일: 수
    private Boolean dayThu;           // 활동 요일: 목
    private Boolean dayFri;           // 활동 요일: 금
    private Boolean daySat;           // 활동 요일: 토
    private Boolean daySun;           // 활동 요일: 일
    private Boolean time0609;         // 활동 시간대: 06~09시
    private Boolean time0912;         // 활동 시간대: 09~12시
    private Boolean time1218;         // 활동 시간대: 12~18시
    private Boolean time1822;         // 활동 시간대: 18~22시
    private Boolean time2206;         // 활동 시간대: 22~06시
    private String activityImage1;    // 활동 이미지 1
    private String activityImage2;    // 활동 이미지 2
    private String activityImage3;    // 활동 이미지 3
    private String activityImage4;    // 활동 이미지 4
    private String activityImage5;    // 활동 이미지 5
    //dto에만 있는거 조인해서 가져오거나 문자열 합쳐서 저장할거.
    private Integer currentPeople;		//현재인원
    private String regions; 			//지역 합친거 영등포구 외 1
    private String ages;				//나이대 20~30대
    private String days;				//월 화 수 ... 평일 주말등등
    private String times; 				//시간대 아침 오전 오후 저녁 심야
    public Team() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	@Override
	public String toString() {
		return "Team [teamId=" + teamId + ", teamName=" + teamName + ", profileImage=" + profileImage + ", description="
				+ description + ", skill=" + skill + ", sport=" + sport + ", gender=" + gender + ", createdAt="
				+ createdAt + ", deleted=" + deleted + ", region1=" + region1 + ", region2=" + region2 + ", region3="
				+ region3 + ", age20s=" + age20s + ", age30s=" + age30s + ", age40s=" + age40s + ", age50s=" + age50s
				+ ", age60Plus=" + age60Plus + ", dayMon=" + dayMon + ", dayTue=" + dayTue + ", dayWed=" + dayWed
				+ ", dayThu=" + dayThu + ", dayFri=" + dayFri + ", daySat=" + daySat + ", daySun=" + daySun
				+ ", time0609=" + time0609 + ", time0912=" + time0912 + ", time1218=" + time1218 + ", time1822="
				+ time1822 + ", time2206=" + time2206 + ", activityImage1=" + activityImage1 + ", activityImage2="
				+ activityImage2 + ", activityImage3=" + activityImage3 + ", activityImage4=" + activityImage4
				+ ", activityImage5=" + activityImage5 + ", currentPeople=" + currentPeople + ", regions=" + regions
				+ ", ages=" + ages + ", days=" + days + ", times=" + times + "]";
	}

	public Team(Long teamId, String teamName, String profileImage, String description, String skill, String sport,
			String gender, LocalDateTime createdAt, Boolean deleted, String region1, String region2, String region3,
			Boolean age20s, Boolean age30s, Boolean age40s, Boolean age50s, Boolean age60Plus, Boolean dayMon,
			Boolean dayTue, Boolean dayWed, Boolean dayThu, Boolean dayFri, Boolean daySat, Boolean daySun,
			Boolean time0609, Boolean time0912, Boolean time1218, Boolean time1822, Boolean time2206,
			String activityImage1, String activityImage2, String activityImage3, String activityImage4,
			String activityImage5, Integer currentPeople, String regions, String ages, String days, String times) {
		super();
		this.teamId = teamId;
		this.teamName = teamName;
		this.profileImage = profileImage;
		this.description = description;
		this.skill = skill;
		this.sport = sport;
		this.gender = gender;
		this.createdAt = createdAt;
		this.deleted = deleted;
		this.region1 = region1;
		this.region2 = region2;
		this.region3 = region3;
		this.age20s = age20s;
		this.age30s = age30s;
		this.age40s = age40s;
		this.age50s = age50s;
		this.age60Plus = age60Plus;
		this.dayMon = dayMon;
		this.dayTue = dayTue;
		this.dayWed = dayWed;
		this.dayThu = dayThu;
		this.dayFri = dayFri;
		this.daySat = daySat;
		this.daySun = daySun;
		this.time0609 = time0609;
		this.time0912 = time0912;
		this.time1218 = time1218;
		this.time1822 = time1822;
		this.time2206 = time2206;
		this.activityImage1 = activityImage1;
		this.activityImage2 = activityImage2;
		this.activityImage3 = activityImage3;
		this.activityImage4 = activityImage4;
		this.activityImage5 = activityImage5;
		this.currentPeople = currentPeople;
		this.regions = regions;
		this.ages = ages;
		this.days = days;
		this.times = times;
	}



	public String getDays() {
		return days;
	}

	public void setDays(String days) {
		this.days = days;
	}

	public String getTimes() {
		return times;
	}

	public void setTimes(String times) {
		this.times = times;
	}

	public Long getTeamId() {
		return teamId;
	}
	public void setTeamId(Long teamId) {
		this.teamId = teamId;
	}
	public String getTeamName() {
		return teamName;
	}
	public void setTeamName(String teamName) {
		this.teamName = teamName;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSkill() {
		return skill;
	}
	public void setSkill(String skill) {
		this.skill = skill;
	}
	public String getSport() {
		return sport;
	}
	public void setSport(String sport) {
		this.sport = sport;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public Boolean getDeleted() {
		return deleted;
	}
	public void setDeleted(Boolean deleted) {
		this.deleted = deleted;
	}
	public String getRegion1() {
		return region1;
	}
	public void setRegion1(String region1) {
		this.region1 = region1;
	}
	public String getRegion2() {
		return region2;
	}
	public void setRegion2(String region2) {
		this.region2 = region2;
	}
	public String getRegion3() {
		return region3;
	}
	public void setRegion3(String region3) {
		this.region3 = region3;
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
	public Boolean getDayMon() {
		return dayMon;
	}
	public void setDayMon(Boolean dayMon) {
		this.dayMon = dayMon;
	}
	public Boolean getDayTue() {
		return dayTue;
	}
	public void setDayTue(Boolean dayTue) {
		this.dayTue = dayTue;
	}
	public Boolean getDayWed() {
		return dayWed;
	}
	public void setDayWed(Boolean dayWed) {
		this.dayWed = dayWed;
	}
	public Boolean getDayThu() {
		return dayThu;
	}
	public void setDayThu(Boolean dayThu) {
		this.dayThu = dayThu;
	}
	public Boolean getDayFri() {
		return dayFri;
	}
	public void setDayFri(Boolean dayFri) {
		this.dayFri = dayFri;
	}
	public Boolean getDaySat() {
		return daySat;
	}
	public void setDaySat(Boolean daySat) {
		this.daySat = daySat;
	}
	public Boolean getDaySun() {
		return daySun;
	}
	public void setDaySun(Boolean daySun) {
		this.daySun = daySun;
	}
	public Boolean getTime0609() {
		return time0609;
	}
	public void setTime0609(Boolean time0609) {
		this.time0609 = time0609;
	}
	public Boolean getTime0912() {
		return time0912;
	}
	public void setTime0912(Boolean time0912) {
		this.time0912 = time0912;
	}
	public Boolean getTime1218() {
		return time1218;
	}
	public void setTime1218(Boolean time1218) {
		this.time1218 = time1218;
	}
	public Boolean getTime1822() {
		return time1822;
	}
	public void setTime1822(Boolean time1822) {
		this.time1822 = time1822;
	}
	public Boolean getTime2206() {
		return time2206;
	}
	public void setTime2206(Boolean time2206) {
		this.time2206 = time2206;
	}
	public String getActivityImage1() {
		return activityImage1;
	}
	public void setActivityImage1(String activityImage1) {
		this.activityImage1 = activityImage1;
	}
	public String getActivityImage2() {
		return activityImage2;
	}
	public void setActivityImage2(String activityImage2) {
		this.activityImage2 = activityImage2;
	}
	public String getActivityImage3() {
		return activityImage3;
	}
	public void setActivityImage3(String activityImage3) {
		this.activityImage3 = activityImage3;
	}
	public String getActivityImage4() {
		return activityImage4;
	}
	public void setActivityImage4(String activityImage4) {
		this.activityImage4 = activityImage4;
	}
	public String getActivityImage5() {
		return activityImage5;
	}
	public void setActivityImage5(String activityImage5) {
		this.activityImage5 = activityImage5;
	}
	public Integer getCurrentPeople() {
		return currentPeople;
	}
	public void setCurrentPeople(Integer currentPeople) {
		this.currentPeople = currentPeople;
	}
	public String getRegions() {
		return regions;
	}
	public void setRegions(String regions) {
		this.regions = regions;
	}
	public String getAges() {
		return ages;
	}
	public void setAges(String ages) {
		this.ages = ages;
	}

    
}
