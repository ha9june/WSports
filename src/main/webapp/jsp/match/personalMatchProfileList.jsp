<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  참가자 프로필 목록 (personalMatchProfileList.jsp) - 담당: 변재언
  피그마: Participants / Profile / Desktop
  경기 참가자(신청 완료자)와 작성자만 볼 수 있는 화면입니다.
--%>
<c:set var="pageTitle" value="참가자 프로필" />
<c:set var="pageCss" value="match" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>

<main class="page">
  <div class="container narrow-rail">
    <nav class="breadcrumb"><a href="${ctx}/mypage/matches/participating">마이페이지 내 경기</a><span class="sep">›</span><span>참가자 프로필</span></nav>
    <div class="page-head">
      <h1 class="page-title">참가자 프로필</h1>
    </div>

    <%-- ===== 경기 정보 ===== --%>
    <div class="match-summary">
      <a class="match-detail-link" href="${ctx}/match/detail/view?personalMatchId=${personalMatch.personalMatchId}">경기 상세 보기 →</a>
      <div>
        <c:choose>
          <c:when test="${personalMatch.sport eq '축구/풋살'}"><c:set var="sportCls" value="football" /></c:when>
          <c:when test="${personalMatch.sport eq '농구'}"><c:set var="sportCls" value="basketball" /></c:when>
          <c:when test="${personalMatch.sport eq '테니스'}"><c:set var="sportCls" value="tennis" /></c:when>
          <c:when test="${personalMatch.sport eq '배드민턴'}"><c:set var="sportCls" value="badminton" /></c:when>
        </c:choose>
        <p class="tags">
          <span class="sport-chip ${sportCls}"><c:out value="${personalMatch.sport}" /></span>
          <span class="pill ${personalMatch.status eq '모집중' ? 'pill-success' : 'pill-info'} bd"><c:out value="${personalMatch.status}" /></span>
        </p>
        <strong><c:out value="${personalMatch.title}" /></strong>
        <p class="meta">
          <span><img src="${ctx}/img/icon-calendar-14.svg" alt="">${personalMatch.matchDate} (${personalMatch.dayOfWeekKorean})</span>
          <span><img src="${ctx}/img/icon-clock-16.svg" alt="">${fn:substring(personalMatch.startTime, 0, 5)} ~ ${fn:substring(personalMatch.endTime, 0, 5)}</span>
          <span><img src="${ctx}/img/icon-pin-14.svg" alt=""><c:out value="${personalMatch.placeName}" /></span>
        </p>
      </div>
      <div class="target">
        참가자<b>${personalMatch.currentPeople} / ${personalMatch.maxPeople}명</b>
        <small>최소 ${personalMatch.minPeople}명</small>
      </div>
    </div>

    <%-- ===== 참가자 목록 ===== --%>
    <div class="people-grid">
      <c:forEach var="user" items="${userList}">
        <a class="person-row"
           href="${ctx}/member/publicProfile/view?userId=${user.userId}">
          <span class="avatar sm">
            <c:choose>
              <c:when test="${not empty user.profileImage}">
                <img src="${ctx}/profiles/<c:out value='${user.profileImage}' />" alt=""
                     onerror="this.onerror=null;this.src='${ctx}/img/default-profile.svg';">
              </c:when>
              <c:otherwise>
                <img src="${ctx}/img/default-profile.svg" alt="">
              </c:otherwise>
            </c:choose>
          </span>
			<c:choose>
				<c:when test="${personalMatch.sport eq '축구/풋살'}"><c:set var="userSkill" value="${user.soccerSkill}" /></c:when>
				<c:when test="${personalMatch.sport eq '농구'}"><c:set var="userSkill" value="${user.basketballSkill}" /></c:when>
				<c:when test="${personalMatch.sport eq '테니스'}"><c:set var="userSkill" value="${user.tennisSkill}" /></c:when>
				<c:otherwise><c:set var="userSkill" value="${user.badmintonSkill}" /></c:otherwise>
			</c:choose>
			<div class="info">
				<strong>
					<c:out value="${user.nickname}" />
					<c:if test="${user.userId eq personalMatch.userId}">
						<span class="host-badge">호스트</span>
					</c:if>
				</strong>
				<p class="meta">
					<c:out value="${user.preferredRegion1}" default="지역 미설정" /> ·
					<c:out value="${userSkill}" default="실력 미설정" />
				</p>
			</div>
        </a>
      </c:forEach> 
    </div>

    <%-- <div class="form-actions"><a class="btn btn-primary btn-sm" href="${ctx}/jsp/mypage/myPagePersonalMatch.jsp">마이페이지 내 경기로</a></div> --%>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>