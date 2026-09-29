package dto;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

/** 개인 매치 */
public class PersonalMatch {

    private Long personalMatchId;       // 개인 매치 ID (PK)
    private String title;               // 제목
    private String content;             // 내용
    private String image;               // 대표 이미지
    private Long userId;                // 작성자 회원 ID
    private LocalDateTime createdAt;    // 작성 일시
    private LocalDate matchDate;        // 경기 날짜
    private String sport;               // 종목
    private LocalTime startTime;        // 시작 시간
    private LocalTime endTime;          // 종료 시간
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
    private Integer minPeople;          // 최소 인원
    private Integer maxPeople;          // 최대 인원
    private Boolean deleted;            // 삭제 여부
    private LocalDateTime updatedAt;    // 수정 일시
    private LocalDateTime deletedAt;    // 삭제 일시
    private String image1;              // 이미지 1
    private String image2;              // 이미지 2
    private String image3;              // 이미지 3
    private String image4;              // 이미지 4
    private String image5;              // 이미지 5
    private String status;              // 매치 상태
    private String placeName;           // 장소명
    private String address;             // 주소
    private String region;              // 지역
}
