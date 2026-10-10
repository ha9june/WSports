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
      <span class="avatar lg default">
      	<c:choose>
  			<c:when test="${not empty publicProfile.profile_image }">
  				<img class="avatar lg"
  					src="${ctx}${profilePath}/${publicProfile.profile_image}"
  					alt="프로필 사진">
			</c:when>
			<c:otherwise>
				<img class="avatar lg"
					src="${ctx }/img/profile-default.png"
					alt="기본 프로필 사진">
			</c:otherwise>
		</c:choose>
      </span>
      <div>
        <h1><c:out value="${publicProfile.nickname }" /></h1>
        <div class="meta teams">
          <c:choose>
            <c:when test="${not empty teamList }">
              <c:forEach var="t" items="${teamList }">
                <a class="team-inline" href="${ctx}/team/detail/view?teamId=${t.team_id}">
                  <c:choose>
                    <c:when test="${not empty t.team_image}">
                      <img src="${ctx}/uploads/${t.team_image}" alt="">
                    </c:when>
                    <c:when test="${t.team_sport eq '농구'}">
                      <img src="${ctx}/img/team-basketball.png" alt="">
                    </c:when>
                    <c:when test="${t.team_sport eq '테니스'}">
                      <img src="${ctx}/img/team-tennis.png" alt="">
                    </c:when>
                    <c:when test="${t.team_sport eq '배드민턴'}">
                      <img src="${ctx}/img/team-badminton.png" alt="">
                    </c:when>
                    <c:otherwise>
                      <img src="${ctx}/img/team-football.png" alt="">
                    </c:otherwise>
                  </c:choose>
                <c:out value="${t.team_name}" />
                </a>
              </c:forEach>
            </c:when>
            <c:otherwise>소속팀 없음</c:otherwise>
          </c:choose>
        </div>
        <p class="score">받은 평점 
          <span class="stars">
            <c:forEach begin="1" end="5" var="i">
              <c:choose>
                <c:when test="${i <= publicProfile.score }">★</c:when>
                <c:otherwise><span class="off">★</span></c:otherwise>
              </c:choose>
            </c:forEach>
          </span><b>${publicProfile.score}</b> · ${publicProfile.rating_cnt}개 평가
         </p>
      </div>
    </section>
    <section class="profile-card">
      <h2>프로필 정보</h2>
      <dl>
        <div class="info-row"><dt>한 줄 소개</dt><dd><c:out value="${empty publicProfile.bio ? '-' : publicProfile.bio}" /></dd></div>
        <div class="info-row"><dt>종목별 실력</dt><dd>
        <div class="level-list">
        <span>축구/풋살</span><b>${empty publicProfile.soccer_skill ? '-' : publicProfile.soccer_skill}</b>
        <span>농구</span><b>${empty publicProfile.basketball_skill ? '-' : publicProfile.basketball_skill}</b>
        <span>테니스</span><b>${empty publicProfile.tennis_skill ? '-' : publicProfile.tennis_skill}</b>
        <span>배드민턴</span><b>${empty publicProfile.badminton_skill ? '-' : publicProfile.badminton_skill}</b></div></dd></div>
        <div class="info-row"><dt>선호 지역</dt><dd>
          <c:choose>
            <c:when test="${empty publicProfile.preferred_region1}">-</c:when>
            <c:otherwise>${publicProfile.preferred_region1}<c:if test="${not empty publicProfile.preferred_region2}"> · ${publicProfile.preferred_region2}</c:if><c:if test="${not empty publicProfile.preferred_region3}"> · ${publicProfile.preferred_region3}</c:if></c:otherwise>
          </c:choose>
        </dd></div>
        <div class="info-row"><dt>선호 종목</dt><dd>
		  <c:choose>
            <c:when test="${empty publicProfile.preferred_sport1}">-</c:when>
            <c:otherwise>${publicProfile.preferred_sport1}<c:if test="${not empty publicProfile.preferred_sport2}"> · ${publicProfile.preferred_sport2}</c:if><c:if test="${not empty publicProfile.preferred_sport3}"> · ${publicProfile.preferred_sport3}</c:if></c:otherwise>
          </c:choose>
        </dd></div>
      </dl>
    </section>
    <c:if test="${role ne 'guest'}">
      <div class="form-actions"><a class="btn btn-outline btn-sm" href="${ctx}/support/report/create?targetType=member&targetNo=${publicProfile.user_id}">회원 신고</a></div>
    </c:if>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
