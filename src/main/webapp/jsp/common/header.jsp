<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  공통 헤더 (header.jsp)
  페이지에서 include 전에 지정하는 값
   - pageTitle : 브라우저 탭 제목
   - pageCss   : 추가 css 파일명(콤마 구분, 확장자 제외)  예) "match,payment"
   - activeNav : match | teamMatch | review | team | notice | admin  (GNB 활성 메뉴)
  권한(role)에 따라 헤더가 3종(Guest / 로그인 / Admin)으로 바뀝니다.
--%>
<!DOCTYPE html>
<style>
/* 1. [공통] 알림 목록 li 태그: 기존 스타일과 위치를 완벽하게 유지합니다 */
li.unread, li {
    display: list-item !important;       /* 원래 가지고 있던 리스트 형태 유지 */
    list-style-type: none !important;    /* 기본으로 생기는 못생긴 검은색 점 제거 */
    padding: 14px 0 !important;          /* 위아래 간격 */
    position: relative !important;       /* 파란색 점과 시간 배치를 위한 기준점 */
    margin-left: 15px !important;        /* 👈 점과 글자 전체 레이아웃을 왼쪽으로 약간 당김 */
}

/* [추가] 파란색 점 도형: 위치를 우측으로 당겨 글자 바로 옆에 붙임 */
li::before {
    content: "" !important;              /* 문자를 비워두고 도형으로 채움 */
    position: absolute !important;
    left: -10px !important;              /* 👈 기존 -16px에서 -10px로 수정하여 글자 옆으로 바짝 붙였습니다 */
    top: 21px !important;                /* 타이틀(strong) 첫 줄 텍스트와 정중앙 높이 맞춤 */
    width: 6px !important;               /* 점의 가로 크기 */
    height: 6px !important;              /* 점의 세로 크기 */
    background-color: #3182CE !important;/* 예쁜 파란색(#3182CE) 지정 */
    border-radius: 50% !important;       /* 완벽한 동그라미로 만듦 */
}

/* 2. ⭐️ [핵심!] common.css의 img {display:block} 간섭을 깨부수고 글자 바로 옆에 붙임 */
.Alarm.link.btn img.bell {
    display: inline-block !important;    
    width: 16px !important;              
    height: 16px !important;             
    margin-right: 6px !important;        
    vertical-align: middle !important;   
    filter: invert(47%) sepia(85%) saturate(1917%) hue-rotate(185deg) brightness(91%) contrast(92%) !important;
}

/* 3. ⭐️ 안 읽은 알림(unread)일 때만 파란색 종 아이콘이 노출되도록 세팅 */
li:not(.unread) .Alarm.link.btn img.bell {
    filter: grayscale(100%) brightness(140%) !important; 
}

/* 알림 0개일때 숨김처리 */
.badge-count.hidden{
	display:none;
}

/* 토글용 숨김 처리 */
.acts.hidden{
	display:none;
}


/* 4. 알림 내용(a태그) 내부 레이아웃 */
.Alarm.link.btn {
    display: inline-flex !important;     /* block 속성을 완벽 차단하고 inline-flex로 안착 */
    flex-direction: column !important;   /* 타이틀과 내용을 위아래(세로)로 배치 */
    align-items: flex-start !important;
    text-decoration: none !important;    /* 링크 특유의 밑줄 제거 */
    color: inherit;
    width: calc(100% - 20px) !important; /* 점 영역을 제외한 너비 채우기 */
    padding-right: 60px !important;      /* 오른쪽에 배치할 시간과 글자가 절대 겹치지 않게 공간 확보 */
    vertical-align: top !important;      /* 리스트 점과 첫 줄 타이틀의 가로 수평 높낮이 맞춤 */
    
    /* 👈 기본 점과의 간격을 조절하는 핵심 속성입니다 */
    margin-left: -10px !important;       /* 음수 마진을 주어 글자 전체를 왼쪽 기본 점 방향으로 바짝 당깁니다 */
}

/* 5. 타이틀과 설명글 내부 기본 마진(벌어짐) 제거 */
.Alarm.link.btn strong,
.Alarm.link.btn p {
    margin: 0 !important;
    padding: 0 !important;
    line-height: 1.4 !important;
}

/* 타이틀과 설명글 글씨 크기 및 간격 미세 조정 */
.Alarm.link.btn strong {
    font-size: 14px;
    color: #111111;
}
.Alarm.link.btn p {
    font-size: 13px;
    color: #666666;                     
    margin-top: 3px !important;         
}

/* 6. 시간(time)을 우측 끝에 완전히 고정 */
time {
    position: absolute !important;
    right: 0 !important;                 
    top: 14px !important;                
    color: #888888 !important;           
    font-size: 12px !important;          
    white-space: nowrap !important;      
}
</style>


<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><c:if test="${not empty pageTitle}">${pageTitle} | </c:if>매치온</title>
<link rel="stylesheet" href="${ctx}/css/common.css">
<link rel="stylesheet" href="${ctx}/css/layout.css">
<c:forTokens items="${pageCss}" delims="," var="cssName">
<link rel="stylesheet" href="${ctx}/css/${cssName}.css">
</c:forTokens>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body data-role="${role}">
<header class="site-header">
  <div class="inner">
    <a class="logo" href="${ctx}/home/main">매치온</a>

    <nav class="gnb" aria-label="주요 메뉴">
      <a href="${ctx}/match/list" class="${activeNav eq 'match' ? 'is-active' : ''}">경기 찾기</a>
      <a href="${ctx}/team-match/list" class="${activeNav eq 'teamMatch' ? 'is-active' : ''}">상대팀 찾기</a>
      <a href="${ctx}/review/list" class="${activeNav eq 'review' ? 'is-active' : ''}">후기</a>
      <a href="${ctx}/team/list" class="${activeNav eq 'team' ? 'is-active' : ''}">팀 찾기</a>
      <a href="${ctx}/support/notice/list" class="${activeNav eq 'notice' ? 'is-active' : ''}">공지사항</a>
      <c:if test="${role eq 'admin'}">
        <a href="${ctx}/admin/revenue/view" class="${activeNav eq 'admin' ? 'is-active' : ''}">관리자(사이트)</a>
      </c:if>
    </nav>

    <div class="header-util">
      <c:choose>
        <%-- <c:when test="${role eq 'guest'}"> 로그아웃을 해도 상단 헤더에 로그인상태 유지됨으로 수정 --%>
          <c:when test="${empty user.loginId}">
          <a class="btn-login" href="${ctx}/auth/login">로그인</a>
        </c:when>
        <c:otherwise>
          <button type="button" class="noti-trigger" data-noti-toggle aria-label="알림 열기">
            <img class="bell" src="${ctx}/img/icon-bell.svg" alt="">
            <!-- 알람 숫자 카운트 -->
            <span id="bellBadge" class="badge">0</span>
          </button>
          <a class="header-profile" href="${ctx}/member/mypage/view" title="마이페이지">
            <img src="${ctx}/img/profile-default.png" alt="내 프로필">
          </a>
        </c:otherwise>
      </c:choose>
    </div>
    <c:if test="${role ne 'guest'}">
      <%-- 알림 퀵 패널 : 벨 아이콘 클릭 시 열림 --%>
      <div class="noti-panel" id="notiPanel" role="dialog" aria-label="알림">
        <div class="head">
          <div><strong>알림</strong><small>최근 알림</small></div>
          
          <div class="acts">         
          <!-- 버튼을 눌럿을때 알람 기록 처리하는 버튼(기능) -->
          <button type="noti-button" data-toast="모든 알림을 읽음 처리했어요.">모두 읽음</button>
          
          <button type="button" data-noti-toggle aria-label="닫기">✕</button>
          </div>
        </div>
<ul>
  <li class="unread">
    <a class="Alarm link btn" href="${ctx}/jsp/match/personalMatchDetail.jsp?state=applied">
      <div>
        <strong>참가가 확정되었습니다.</strong>
        <p>토요일 저녁 풋살 한 판!</p>
      </div>
      <time>10:24</time>
    </a>
  </li>
  <li class="unread">
    <a class="Alarm link btn" href="${ctx}/jsp/match/personalMatchDetail.jsp?state=closed">
      <div>
        <strong>경기 모집이 마감되었습니다.</strong>
        <p class="brand">9/20 실내 농구</p>
      </div>
      <time>09:12</time>
    </a>
  </li>
  
  <li>
    <a class="Alarm link btn" href="${ctx}/jsp/match/personalMatchAfterMatchEdit.jsp?state=participant">
      <div>
        <strong>참가자 평가를 남겨주세요.</strong>
        <p>지난 경기 참가자를 평가할 수 있어요.</p>
      </div>
      <time>9/11</time>
    </a>
  </li> 
</ul>
        <div class="foot"><a class="btn btn-outline btn-sm" href="${ctx}/mypage/notifications">알림 전체보기</a></div>
      </div>
    </c:if>
  </div>
</header>