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
        <c:when test="${role eq 'guest'}">
          <a class="btn-login" href="${ctx}/auth/login">로그인</a>
        </c:when>
        <c:otherwise>
          <button type="button" class="noti-trigger" data-noti-toggle aria-label="알림 열기">
            <img class="bell" src="${ctx}/img/icon-bell.svg" alt="">
            <span class="badge">3</span>
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
          <div class="acts"><button type="button" data-toast="모든 알림을 읽음 처리했어요.">모두 읽음</button><button type="button" data-noti-toggle aria-label="닫기">✕</button></div>
        </div>
        <ul>
          <li class="unread"><strong>참가가 확정되었습니다.</strong><p>토요일 저녁 풋살 한 판!</p><time>10:24</time></li>
          <li class="unread"><strong>경기 모집이 마감되었습니다.</strong><p class="brand">9/20 실내 농구</p><time>09:12</time></li>
          <li><strong>참가자 평가를 남겨주세요.</strong><p>지난 경기 참가자를 평가할 수 있어요.</p><time>9/11</time></li>
        </ul>
        <div class="foot"><a class="btn btn-outline btn-sm" href="${ctx}/mypage/notifications">알림 전체보기</a></div>
      </div>
    </c:if>
  </div>
</header>