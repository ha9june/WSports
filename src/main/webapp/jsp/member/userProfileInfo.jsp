<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  사용자 공개 프로필 (userProfileInfo.jsp) - 담당: 박우리
  피그마: Profile / Public / Desktop
  TODO: ?userNo= 로 조회한 회원 정보(${profile})로 값 교체
--%>
<c:set var="pageTitle" value="사용자 프로필" />
<c:set var="pageCss" value="auth" />
<%@ include file="/jsp/common/header.jsp" %>

<main class="page">
  <div class="container">
    <nav class="breadcrumb"><span>사용자 프로필</span></nav>
    <section class="profile-top">
      <span class="avatar lg default"></span>
      <div>
        <h1>풋살초보</h1>
        <p class="meta">서울 마포구 · 축구/풋살</p>
        <p class="score">받은 평점 <span class="stars">★★★★<span class="off">★</span></span><b>4.6</b> · 12개 평가</p>
      </div>
    </section>
    <section class="profile-card">
      <h2>프로필 정보</h2>
      <dl>
        <div class="info-row"><dt>한 줄 소개</dt><dd>즐겁게 운동하고 좋은 사람들과 꾸준히 함께하고 싶어요.</dd></div>
        <div class="info-row"><dt>종목별 실력</dt><dd><div class="level-list"><span>축구/풋살</span><b>초급</b><span>농구</span><b>중급</b><span>테니스</span><b>입문</b><span>배드민턴</span><b>초급</b></div></dd></div>
        <div class="info-row"><dt>선호 지역</dt><dd>서울 마포구 · 서울 영등포구</dd></div>
        <div class="info-row"><dt>소속팀</dt><dd><a class="team-inline" href="${ctx}/jsp/team/teamDetail.jsp"><img src="${ctx}/img/team-football.png" alt="">서울 풋살 크루</a></dd></div>
      </dl>
    </section>
    <c:if test="${role ne 'guest'}">
      <div class="form-actions"><a class="btn btn-outline btn-sm" href="${ctx}/jsp/support/reportWrite.jsp?state=member">회원 신고</a></div>
    </c:if>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
