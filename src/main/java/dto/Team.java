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
}
