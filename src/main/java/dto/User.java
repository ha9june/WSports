package dto;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalDateTime;

import dao.UserDao;

/** 회원 */
public class User {

    private Long userId;                     // 회원 ID (PK)
    private String loginId;                  // 로그인 아이디
    private String password;                 // 비밀번호 (암호화)
    private String name;                     // 이름
    private LocalDate birthDate;             // 생년월일
    private String nickname;                 // 닉네임
    private String phone;                    // 전화번호
    private String email;                    // 이메일
    private String gender;                   // 성별
    private LocalDateTime createdAt;         // 가입 일시
    private LocalDateTime updatedAt;         // 수정 일시
    private LocalDateTime lastLoginAt;       // 마지막 로그인 일시
    private String grade;                    // 회원 등급
    private LocalDateTime withdrawalAt;      // 탈퇴 일시
    private Boolean suspended;               // 정지 여부
    private String profileImage;             // 프로필 이미지
    private String bio;                      // 자기소개
    private String soccerSkill;              // 축구 실력
    private String basketballSkill;          // 농구 실력
    private String tennisSkill;              // 테니스 실력
    private String badmintonSkill;           // 배드민턴 실력
    private LocalDateTime profileUpdatedAt;  // 프로필 수정 일시
    private String preferredRegion1;         // 선호 지역 1
    private String preferredRegion2;         // 선호 지역 2
    private String preferredRegion3;         // 선호 지역 3
    private String preferredSport1;          // 선호 종목 1
    private String preferredSport2;          // 선호 종목 2
    private String preferredSport3;          // 선호 종목 3
    private String bankName;                 // 은행명
    private String accountNumber;            // 계좌번호
    private String accountHolder;            // 예금주
    private LocalDateTime accountCreatedAt;  // 계좌 등록 일시
    private LocalDateTime accountUpdatedAt;  // 계좌 수정 일시
    

    
    
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}


	public User(Long userId, String loginId, String password, String name, LocalDate birthDate, String nickname,
			String phone, String email, String gender, LocalDateTime createdAt, LocalDateTime updatedAt,
			LocalDateTime lastLoginAt, String grade, LocalDateTime withdrawalAt, Boolean suspended, String profileImage,
			String bio, String soccerSkill, String basketballSkill, String tennisSkill, String badmintonSkill,
			LocalDateTime profileUpdatedAt, String preferredRegion1, String preferredRegion2, String preferredRegion3,
			String preferredSport1, String preferredSport2, String preferredSport3, String bankName,
			String accountNumber, String accountHolder, LocalDateTime accountCreatedAt,
			LocalDateTime accountUpdatedAt) {
		super();
		this.userId = userId;
		this.loginId = loginId;
		this.password = password;
		this.name = name;
		this.birthDate = birthDate;
		this.nickname = nickname;
		this.phone = phone;
		this.email = email;
		this.gender = gender;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.lastLoginAt = lastLoginAt;
		this.grade = grade;
		this.withdrawalAt = withdrawalAt;
		this.suspended = suspended;
		this.profileImage = profileImage;
		this.bio = bio;
		this.soccerSkill = soccerSkill;
		this.basketballSkill = basketballSkill;
		this.tennisSkill = tennisSkill;
		this.badmintonSkill = badmintonSkill;
		this.profileUpdatedAt = profileUpdatedAt;
		this.preferredRegion1 = preferredRegion1;
		this.preferredRegion2 = preferredRegion2;
		this.preferredRegion3 = preferredRegion3;
		this.preferredSport1 = preferredSport1;
		this.preferredSport2 = preferredSport2;
		this.preferredSport3 = preferredSport3;
		this.bankName = bankName;
		this.accountNumber = accountNumber;
		this.accountHolder = accountHolder;
		this.accountCreatedAt = accountCreatedAt;
		this.accountUpdatedAt = accountUpdatedAt;
	}
	
	
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public LocalDate getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(LocalDate birthDate) {
		this.birthDate = birthDate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
	public LocalDateTime getLastLoginAt() {
		return lastLoginAt;
	}
	public void setLastLoginAt(LocalDateTime lastLoginAt) {
		this.lastLoginAt = lastLoginAt;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public LocalDateTime getWithdrawalAt() {
		return withdrawalAt;
	}
	public void setWithdrawalAt(LocalDateTime withdrawalAt) {
		this.withdrawalAt = withdrawalAt;
	}
	public Boolean getSuspended() {
		return suspended;
	}
	public void setSuspended(Boolean suspended) {
		this.suspended = suspended;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	public String getBio() {
		return bio;
	}
	public void setBio(String bio) {
		this.bio = bio;
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
	public LocalDateTime getProfileUpdatedAt() {
		return profileUpdatedAt;
	}
	public void setProfileUpdatedAt(LocalDateTime profileUpdatedAt) {
		this.profileUpdatedAt = profileUpdatedAt;
	}
	public String getPreferredRegion1() {
		return preferredRegion1;
	}
	public void setPreferredRegion1(String preferredRegion1) {
		this.preferredRegion1 = preferredRegion1;
	}
	public String getPreferredRegion2() {
		return preferredRegion2;
	}
	public void setPreferredRegion2(String preferredRegion2) {
		this.preferredRegion2 = preferredRegion2;
	}
	public String getPreferredRegion3() {
		return preferredRegion3;
	}
	public void setPreferredRegion3(String preferredRegion3) {
		this.preferredRegion3 = preferredRegion3;
	}
	public String getPreferredSport1() {
		return preferredSport1;
	}
	public void setPreferredSport1(String preferredSport1) {
		this.preferredSport1 = preferredSport1;
	}
	public String getPreferredSport2() {
		return preferredSport2;
	}
	public void setPreferredSport2(String preferredSport2) {
		this.preferredSport2 = preferredSport2;
	}
	public String getPreferredSport3() {
		return preferredSport3;
	}
	public void setPreferredSport3(String preferredSport3) {
		this.preferredSport3 = preferredSport3;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	public String getAccountHolder() {
		return accountHolder;
	}
	public void setAccountHolder(String accountHolder) {
		this.accountHolder = accountHolder;
	}
	public LocalDateTime getAccountCreatedAt() {
		return accountCreatedAt;
	}
	public void setAccountCreatedAt(LocalDateTime accountCreatedAt) {
		this.accountCreatedAt = accountCreatedAt;
	}
	public LocalDateTime getAccountUpdatedAt() {
		return accountUpdatedAt;
	}
	public void setAccountUpdatedAt(LocalDateTime accountUpdatedAt) {
		this.accountUpdatedAt = accountUpdatedAt;
	}


	@Override
	public String toString() {
		return "User [userId=" + userId + ", loginId=" + loginId + ", password=" + password + ", name=" + name
				+ ", birthDate=" + birthDate + ", nickname=" + nickname + ", phone=" + phone + ", email=" + email
				+ ", gender=" + gender + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", lastLoginAt="
				+ lastLoginAt + ", grade=" + grade + ", withdrawalAt=" + withdrawalAt + ", suspended=" + suspended
				+ ", profileImage=" + profileImage + ", bio=" + bio + ", soccerSkill=" + soccerSkill
				+ ", basketballSkill=" + basketballSkill + ", tennisSkill=" + tennisSkill + ", badmintonSkill="
				+ badmintonSkill + ", profileUpdatedAt=" + profileUpdatedAt + ", preferredRegion1=" + preferredRegion1
				+ ", preferredRegion2=" + preferredRegion2 + ", preferredRegion3=" + preferredRegion3
				+ ", preferredSport1=" + preferredSport1 + ", preferredSport2=" + preferredSport2 + ", preferredSport3="
				+ preferredSport3 + ", bankName=" + bankName + ", accountNumber=" + accountNumber + ", accountHolder="
				+ accountHolder + ", accountCreatedAt=" + accountCreatedAt + ", accountUpdatedAt=" + accountUpdatedAt
				+ "]";
	}
    
    
    
    
}
