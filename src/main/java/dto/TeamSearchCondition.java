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
	public TeamSearchCondition() {
		super();
		// TODO Auto-generated constructor stub
	}
	public TeamSearchCondition(int offset, String[] sports, String gender, String[] days, String[] skills,
			String[] regions, String keyword, String sort) {
		super();
		this.offset = offset;
		this.sports = sports;
		this.gender = gender;
		this.days = days;
		this.skills = skills;
		this.regions = regions;
		this.keyword = keyword;
		this.sort = sort;
	}
	@Override
	public String toString() {
		return "TeamSearchCondition [offset=" + offset + ", sports=" + Arrays.toString(sports) + ", gender=" + gender
				+ ", days=" + Arrays.toString(days) + ", skills=" + Arrays.toString(skills) + ", regions="
				+ Arrays.toString(regions) + ", keyword=" + keyword + ", sort=" + sort + "]";
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
	
	
    
}
