<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀 경기 후 관리 조회 (teamMatchResultDetail.jsp) - 담당: 하준수
  피그마: Club Match / Postgame Rating / View / Desktop
  팀 단위로 출석 상태를 확인하고 상대 팀의 경기 매너를 평가합니다. (팀 단위 출석만, 개인 평가 없음)
--%>
<c:set var="pageTitle" value="팀 경기 후 관리" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="teamMatch" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="container">
    <nav class="breadcrumb"><a href="${ctx}/jsp/mypage/myPageTeamMatch.jsp">팀 경기</a><span class="sep">›</span><span>경기 후 관리</span></nav>
    <div class="page-head"><h1 class="page-title">팀 경기 후 관리</h1></div>
    <div class="info-banner">양 팀의 출석 상태를 확인하고 상대 팀의 경기 매너만 평가합니다.<small>팀 단위 출석 정보만 제공하며 우리 팀과 개인 평가는 제공하지 않습니다.</small></div>
    <div class="postgame-card">
      <div class="match-summary">
        <div><p class="tags"><span class="sport-tag neutral" style="background:var(--ds-brand-subtle);color:var(--ds-brand)">풋살</span>경기 종료</p>
          <strong>서울 풋살 크루 vs 망원 FC</strong><p class="meta"><span>9/27 (일) 17:00 - 19:00</span><span>서울 마포구 · 난지 풋살장</span></p></div>
        <div class="target">평가 대상<b>1팀</b></div>
      </div>
      <div class="eval-head"><h3>출석 · 참가 팀 평가</h3><p>양 팀의 출석 상태를 확인하고 상대 팀의 경기 매너를 평가해주세요.</p></div>
      <div class="eval-row"><div class="who"><span class="avatar sm default"></span><div>서울 풋살 크루<small>우리 팀</small></div></div><div><span class="att-badge">출석</span></div><div></div></div>
      <div class="eval-row"><div class="who"><span class="avatar sm default"></span><div>망원 FC<small>상대 팀</small></div></div><div><span class="att-badge">출석</span></div><div class="rate"><span class="rating">4.5</span></div></div>
      <div class="form-actions" style="margin-right:20px"><a class="btn btn-primary" href="${ctx}/jsp/team/teamMatchResultEdit.jsp">정보 수정</a></div>
    </div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
