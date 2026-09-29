<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  참가 팀 확인 (teamMatchParticipants.jsp) - 담당: 하준수
  피그마: Club Match / Participants / Desktop
  우리 팀 / 상대 팀의 팀 프로필을 나란히 보여줍니다.
--%>
<c:set var="pageTitle" value="참가 팀 확인" />
<c:set var="pageCss" value="team" />
<c:set var="activeNav" value="teamMatch" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="container">
    <nav class="breadcrumb"><a href="${ctx}/jsp/team/teamMatchList.jsp">팀 매칭</a><span class="sep">›</span><span>참가 팀 확인</span></nav>
    <div class="page-head"><h1 class="page-title">참가 팀 확인</h1><p class="page-desc">경기에 참가한 우리 팀과 상대 팀의 프로필을 확인합니다.</p></div>
    <div class="vs-grid">
      <section class="vs-card"><h2>서울 풋살 크루</h2><p class="who">우리 팀</p>
        <div class="body"><img src="${ctx}/img/team-football.png" alt=""><dl><dt>활동 지역</dt><dd>서울 마포구 · 서울 영등포구</dd><dt>인원</dt><dd>18명</dd><dt>종목</dt><dd>축구/풋살</dd><dt>실력</dt><dd>중급</dd><dt>팀 평점</dt><dd><span class="rating" style="color:#e0901a">4.7</span></dd></dl></div></section>
      <section class="vs-card"><h2>마포 유나이티드</h2><p class="who">상대 팀</p>
        <div class="body"><img src="${ctx}/img/team-football.png" alt=""><dl><dt>활동 지역</dt><dd>서울 마포구 · 서울 서대문구</dd><dt>인원</dt><dd>21명</dd><dt>종목</dt><dd>축구/풋살</dd><dt>실력</dt><dd>중급</dd><dt>팀 평점</dt><dd><span class="rating" style="color:#e0901a">4.6</span></dd></dl></div></section>
    </div>
    <div class="form-actions"><a class="btn btn-outline" href="${ctx}/jsp/team/teamMatchDetail.jsp?state=hostMatched">경기 상세로</a></div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
