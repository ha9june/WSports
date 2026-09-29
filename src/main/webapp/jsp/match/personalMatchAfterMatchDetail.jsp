<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 후 관리 조회 (personalMatchAfterMatchDetail.jsp) - 담당: 변재언
  피그마: Postgame / Rating / View / Desktop, Postgame / Rating / View / Participant / Desktop
  ─ 하나의 JSP 로 처리 ─
   state : host(작성자) | participant(참가자)
--%>
<c:set var="state" value="${empty param.state ? 'host' : param.state}" />
<c:set var="isHost" value="${state eq 'host'}" />
<c:set var="pageTitle" value="경기 후 관리" />
<c:set var="pageCss" value="match" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="host:작성자|participant:참가자" />
<%@ include file="/jsp/common/header.jsp" %>

<main class="page">
  <div class="container">
    <nav class="breadcrumb"><span>${isHost ? '내 경기' : '참가 경기'}</span><span class="sep">›</span><span>경기 후 관리</span></nav>
    <div class="page-head">
      <h1 class="page-title">경기 후 관리</h1>
      <p class="page-desc">본인을 제외한 참가자의 출석 여부와 평가 결과를 확인합니다.</p>
    </div>
    <div class="tabs dark"><span class="tab is-active">출석 · 참가자 평가</span></div>

    <div class="postgame-card">
      <div class="match-summary">
        <div>
          <p class="tags"><span class="sport-tag neutral" style="background:var(--ds-brand-subtle);color:var(--ds-brand)">풋살</span>경기 종료</p>
          <strong>토요일 저녁 풋살 한 판!</strong>
          <p class="meta"><span>9/19 (토) 19:00 - 21:00</span><span>서울 마포구 · 망원 풋살장</span></p>
        </div>
        <div class="target">평가 대상<b>2명</b></div>
      </div>
      <div class="eval-head">
        <h3>출석 · 참가자 평가</h3>
        <p>본인을 제외한 참가자의 출석 상태와 평가 점수를 확인할 수 있어요.</p>
      </div>
      <%-- TODO: <c:forEach var="p" items="${ratingList}"> --%>
      <div class="eval-row"><div class="who"><span class="avatar sm default"></span>서울킥</div><div><span class="att-badge">출석</span></div><div class="rate"></div></div>
      <div class="eval-row"><div class="who"><span class="avatar sm default"></span>공차는날</div><div><span class="att-badge">출석</span></div><div class="rate"><span class="rating">4.5</span></div></div>
      <div class="eval-row"><div class="who"><span class="avatar sm default"></span>운동하자</div><div><span class="att-badge">미출석</span></div><div class="rate"><span class="rating">4.5</span></div></div>
      <div class="form-actions" style="margin-right:20px">
        <a class="btn btn-primary" href="${ctx}/jsp/match/personalMatchAfterMatchEdit.jsp?state=${state}">정보 수정</a>
      </div>
    </div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
