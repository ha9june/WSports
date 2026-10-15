<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  사용자 공개 프로필 (userProfileInfo.jsp) - 담당: 박우리
  피그마: Profile / Public / Desktop
--%>
<c:set var="pageTitle" value="사용자 프로필" />
<c:set var="pageCss" value="auth,mypage" />
<%@ include file="/jsp/common/header.jsp" %>
<style>
.team-inline:hover {
	text-decoration: underline;
}
</style>

<main class="page">
  <div class="container">
    <nav class="breadcrumb"><span>사용자 프로필</span></nav>

    <div class="pf-page">
      <div class="pf-head">
        <h1 class="section-title"><c:out value="${publicProfile.nickname}" /></h1>
        <p class="section-desc">다른 사용자에게 보여지는 프로필입니다.</p>
      </div>

      <%-- 프로필 사진 + 한 줄 소개 + 소속팀/평점 --%>
      <section class="pf-card">
        <h2 class="sub-title">프로필</h2>
        <div class="pf-intro">
          <c:choose>
            <c:when test="${not empty publicProfile.profile_image}">
              <img class="avatar lg" src="${ctx}${profilePath}/${publicProfile.profile_image}" alt="프로필 사진">
            </c:when>
            <c:otherwise>
              <img class="avatar lg" src="${ctx}/img/default-profile.svg" alt="기본 프로필 사진">
            </c:otherwise>
          </c:choose>
          <div class="pf-intro-body">
            <p class="pf-intro-label">한 줄 소개</p>
            <c:choose>
              <c:when test="${not empty publicProfile.bio}">
                <p class="pf-bio">"<c:out value="${publicProfile.bio}" />"</p>
              </c:when>
              <c:otherwise>
                <p class="pf-bio is-empty">작성한 한 줄 소개가 없습니다.</p>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </section>

      <%-- 소속팀 / 받은 평점 --%>
      <section class="pf-card">
        <h2 class="sub-title">활동 정보</h2>
        <dl class="pf-rows">
          <div class="pf-row">
            <dt>소속팀</dt>
            <dd>
              <c:choose>
                <c:when test="${not empty teamList}">
                  <c:forEach var="t" items="${teamList}">
                    <a class="team-inline" href="${ctx}/team/detail/view?teamId=${t.team_id}">
                      <c:choose>
                        <c:when test="${not empty t.team_image}"><img src="${ctx}/uploads/${t.team_image}" alt=""></c:when>
                        <c:when test="${t.team_sport eq '농구'}"><img src="${ctx}/img/team-basketball.png" alt=""></c:when>
                        <c:when test="${t.team_sport eq '테니스'}"><img src="${ctx}/img/team-tennis.png" alt=""></c:when>
                        <c:when test="${t.team_sport eq '배드민턴'}"><img src="${ctx}/img/team-badminton.png" alt=""></c:when>
                        <c:otherwise><img src="${ctx}/img/team-football.png" alt=""></c:otherwise>
                      </c:choose>
                      <c:out value="${t.team_name}" />
                    </a>
                  </c:forEach>
                </c:when>
                <c:otherwise><span class="pf-empty-text">소속팀이 없습니다.</span></c:otherwise>
              </c:choose>
            </dd>
          </div>
          <div class="pf-row">
            <dt>받은 평점</dt>
            <dd>
              <span class="stars">
                <c:forEach begin="1" end="5" var="i">
                  <c:choose>
                    <c:when test="${i <= publicProfile.score}">★</c:when>
                    <c:otherwise><span class="off">★</span></c:otherwise>
                  </c:choose>
                </c:forEach>
              </span>
              <b>${publicProfile.score}</b> <span class="pf-empty-text">· ${publicProfile.rating_cnt}개 평가</span>
            </dd>
          </div>
          <div class="pf-row">
            <dt>관심 종목</dt>
            <dd>
              <c:if test="${not empty publicProfile.preferred_sport1}"><span class="pill pill-brand">${publicProfile.preferred_sport1}</span></c:if>
              <c:if test="${not empty publicProfile.preferred_sport2}"><span class="pill pill-brand">${publicProfile.preferred_sport2}</span></c:if>
              <c:if test="${not empty publicProfile.preferred_sport3}"><span class="pill pill-brand">${publicProfile.preferred_sport3}</span></c:if>
              <c:if test="${empty publicProfile.preferred_sport1 and empty publicProfile.preferred_sport2 and empty publicProfile.preferred_sport3}">
                <span class="pf-empty-text">선택한 관심 종목이 없습니다.</span>
              </c:if>
            </dd>
          </div>
          <div class="pf-row">
            <dt>주 활동 지역</dt>
            <dd>
              <c:if test="${not empty publicProfile.preferred_region1}"><span class="pill pill-outline">${publicProfile.preferred_region1}</span></c:if>
              <c:if test="${not empty publicProfile.preferred_region2}"><span class="pill pill-outline">${publicProfile.preferred_region2}</span></c:if>
              <c:if test="${not empty publicProfile.preferred_region3}"><span class="pill pill-outline">${publicProfile.preferred_region3}</span></c:if>
              <c:if test="${empty publicProfile.preferred_region1 and empty publicProfile.preferred_region2 and empty publicProfile.preferred_region3}">
                <span class="pf-empty-text">선택한 활동 지역이 없습니다.</span>
              </c:if>
            </dd>
          </div>
        </dl>
      </section>

      <%-- 종목별 프로필 --%>
      <section class="pf-card">
        <h2 class="sub-title">종목별 프로필</h2>
        <div class="pf-tiles">
          <div class="pf-tile ${empty publicProfile.soccer_skill ? 'is-empty' : ''}">
            <small>축구/풋살</small>
            <b><c:out value="${empty publicProfile.soccer_skill ? '미설정' : publicProfile.soccer_skill}" /></b>
          </div>
          <div class="pf-tile ${empty publicProfile.basketball_skill ? 'is-empty' : ''}">
            <small>농구</small>
            <b><c:out value="${empty publicProfile.basketball_skill ? '미설정' : publicProfile.basketball_skill}" /></b>
          </div>
          <div class="pf-tile ${empty publicProfile.tennis_skill ? 'is-empty' : ''}">
            <small>테니스</small>
            <b><c:out value="${empty publicProfile.tennis_skill ? '미설정' : publicProfile.tennis_skill}" /></b>
          </div>
          <div class="pf-tile ${empty publicProfile.badminton_skill ? 'is-empty' : ''}">
            <small>배드민턴</small>
            <b><c:out value="${empty publicProfile.badminton_skill ? '미설정' : publicProfile.badminton_skill}" /></b>
          </div>
        </div>
      </section>

      <c:if test="${role ne 'guest'}">
        <div class="form-actions"><a class="btn btn-outline btn-sm" href="${ctx}/support/report/create?targetType=user&targetNo=${publicProfile.user_id}">회원 신고</a></div>
      </c:if>
    </div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>