package dto;
import java.time.LocalDate;
import java.time.LocalDateTime;

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
}
