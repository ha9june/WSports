package dto;

import java.util.Arrays;

public class TeamSearchCondition {
    private int offset;
    private String[] sports;
    private String gender;
    private String[] days;
    private String[] skills;
    private String[] regions;
    private String keyword;
    private String sort;
    
    private String[] ages;        // 나이대 (20대, 30대 ...)
    private String[] matchPeople; // 경기 인원 (2, 3, 5 ...)
    private String startDate;     // 경기 시작일
    private String endDate;       // 경기 종료일
    private Long userId; //로그인 유저 비회원은 널
    

    
    //메인 추천선택용
  	private String SearchType;
    
	public TeamSearchCondition() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public String[] getAges() {
		return ages;
	}

	public void setAges(String[] ages) {
		this.ages = ages;
	}

	public String[] getMatchPeople() {
		return matchPeople;
	}

	public void setMatchPeople(String[] matchPeople) {
		this.matchPeople = matchPeople;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "TeamSearchCondition [offset=" + offset + ", sports=" + Arrays.toString(sports) + ", gender=" + gender
				+ ", days=" + Arrays.toString(days) + ", skills=" + Arrays.toString(skills) + ", regions="
				+ Arrays.toString(regions) + ", keyword=" + keyword + ", sort=" + sort + ", ages="
				+ Arrays.toString(ages) + ", matchPeople=" + Arrays.toString(matchPeople) + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", userId=" + userId + ", SearchType=" + SearchType + "]";
	}

	public TeamSearchCondition(int offset, String[] sports, String gender, String[] days, String[] skills,
			String[] regions, String keyword, String sort, String[] ages, String[] matchPeople, String startDate,
			String endDate, Long userId, String searchType) {
		super();
		this.offset = offset;
		this.sports = sports;
		this.gender = gender;
		this.days = days;
		this.skills = skills;
		this.regions = regions;
		this.keyword = keyword;
		this.sort = sort;
		this.ages = ages;
		this.matchPeople = matchPeople;
		this.startDate = startDate;
		this.endDate = endDate;
		this.userId = userId;
		SearchType = searchType;
	}

	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public String[] getSports() {
		return sports;
	}
	public void setSports(String[] sports) {
		this.sports = sports;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String[] getDays() {
		return days;
	}
	public void setDays(String[] days) {
		this.days = days;
	}
	public String[] getSkills() {
		return skills;
	}
	public void setSkills(String[] skills) {
		this.skills = skills;
	}
	public String[] getRegions() {
		return regions;
	}
	public void setRegions(String[] regions) {
		this.regions = regions;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getSearchType() {
		return SearchType;
	}
	public void setSearchType(String searchType) {
		SearchType = searchType;
	}
	
	
	
    
}
