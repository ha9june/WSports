package util;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Arrays;

public class MatchSearchInfo {
	//추천선택용
	private String SearchType;
	
	//공통
	private String[] sports;
	private String[] ages;
	private String[] skills;
	private String gender;
	
	//노말
    private String[] regions;
	private LocalDate startDate;
	private LocalDate endDate;
	private String keyword;
	private Integer startIndex;
	//지도
	private BigDecimal minLat;
	private BigDecimal maxLat;
	private BigDecimal minLng;
	private BigDecimal maxLng;
	
	//좋아요용
	private Long userId;

	
	
	
	public String getSearchType() {
		return SearchType;
	}
	public void setSearchType(String searchType) {
		SearchType = searchType;
	}
	public String[] getSports() {
		return sports;
	}
	public void setSports(String[] sports) {
		this.sports = sports;
	}
	public String[] getAges() {
		return ages;
	}
	public void setAges(String[] ages) {
		this.ages = ages;
	}
	public String[] getSkills() {
		return skills;
	}
	public void setSkills(String[] skills) {
		this.skills = skills;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String[] getRegions() {
		return regions;
	}
	public void setRegions(String[] regions) {
		this.regions = regions;
	}
	public LocalDate getStartDate() {
		return startDate;
	}
	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}
	public LocalDate getEndDate() {
		return endDate;
	}
	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Integer getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(Integer startIndex) {
		this.startIndex = startIndex;
	}
	public BigDecimal getMinLat() {
		return minLat;
	}
	public void setMinLat(BigDecimal minLat) {
		this.minLat = minLat;
	}
	public BigDecimal getMaxLat() {
		return maxLat;
	}
	public void setMaxLat(BigDecimal maxLat) {
		this.maxLat = maxLat;
	}
	public BigDecimal getMinLng() {
		return minLng;
	}
	public void setMinLng(BigDecimal minLng) {
		this.minLng = minLng;
	}
	public BigDecimal getMaxLng() {
		return maxLng;
	}
	public void setMaxLng(BigDecimal maxLng) {
		this.maxLng = maxLng;
	}
	
	
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	@Override
	public String toString() {
		return "MatchSearchInfo [SearchType=" + SearchType + ", sports=" + Arrays.toString(sports) + ", ages="
				+ Arrays.toString(ages) + ", skills=" + Arrays.toString(skills) + ", gender=" + gender + ", regions="
				+ Arrays.toString(regions) + ", startDate=" + startDate + ", endDate=" + endDate + ", keyword="
				+ keyword + ", startIndex=" + startIndex + ", minLat=" + minLat + ", maxLat=" + maxLat + ", minLng="
				+ minLng + ", maxLng=" + maxLng + "]";
	}
	

}
