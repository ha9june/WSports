<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 후 관리 조회 (personalMatchAfterMatchDetail.jsp) - 담당: 변재언
  피그마: Postgame / Rating / View / Desktop, Postgame / Rating / View / Participant / Desktop
  ─ 하나의 JSP 로 처리 ─
   state : host(작성자) | participant(참가자)
--%>
<c:set var="state" value="${empty param.state ? 'host' : param.state}" />
<c:set var="isHost" value="${sessionScope.user.userId eq personalMatch.userId}" />
<c:set var="pageTitle" value="경기 후 관리" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="match" />
<style>
.eval-row .who a:hover {
	text-decoration: underline;
}
</style>
<%@ include file="/jsp/common/header.jsp" %>

<main class="page">
  <div class="container narrow-rail">
    <nav class="breadcrumb"><span>${isHost ? '내 경기' : '참가 경기'}</span><span class="sep">›</span><span>경기 후 관리</span></nav>
    <div class="page-head">
      <h1 class="page-title">경기 후 관리</h1>
    </div>
    <div class="info-banner">
      본인을 제외한 참가자의 출석 여부를 확인하고 경기 매너를 평가합니다.<small>출석은 호스트만 체크할 수 있고, 본인에게는 평가를 남길 수 없어요.</small>
    </div>

    <div class="postgame-card">
      <div class="match-summary">
        <div>
          <c:choose>
            <c:when test="${personalMatch.sport eq '축구/풋살'}"><c:set var="sportCls" value="football" /></c:when>
            <c:when test="${personalMatch.sport eq '농구'}"><c:set var="sportCls" value="basketball" /></c:when>
            <c:when test="${personalMatch.sport eq '테니스'}"><c:set var="sportCls" value="tennis" /></c:when>
            <c:when test="${personalMatch.sport eq '배드민턴'}"><c:set var="sportCls" value="badminton" /></c:when>
          </c:choose>
          <p class="tags">
            <span class="sport-chip ${sportCls}"><c:out value="${personalMatch.sport}" /></span>
            <span class="pill pill-info bd"><c:out value="${personalMatch.status}" /></span>
          </p>
          <strong><c:out value="${personalMatch.title}" /></strong>
          <p class="meta">
            <span><img src="${ctx}/img/icon-calendar-14.svg" alt="">${personalMatch.matchDate} (${personalMatch.dayOfWeekKorean})</span>
            <span><img src="${ctx}/img/icon-clock-16.svg" alt="">${fn:substring(personalMatch.startTime, 0, 5)} ~ ${fn:substring(personalMatch.endTime, 0, 5)}</span>
            <span><img src="${ctx}/img/icon-pin-14.svg" alt=""><c:out value="${personalMatch.region}" /> · <c:out value="${personalMatch.placeName}" /></span>
          </p>
        </div>
        <div class="target">평가 대상<b>${userList.size()}명</b></div>
      </div>

      <div class="eval-head">
        <h3>출석 · 참가자 평가</h3>
        <p>참가자의 출석 상태와 평가 점수를 확인하세요.</p>
      </div>
      
      <c:if test="${not empty me}">
      <div class="eval-row">
        <div class="who">
          <span class="avatar sm">
            <c:choose>
              <c:when test="${not empty me.profileImage}">
                <img alt="" src="${ctx}${profilePath}/${me.profileImage}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;">
              </c:when>
              <c:otherwise>
                <img alt="" src="${ctx}/img/default-profile.svg" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;">
              </c:otherwise>
            </c:choose>
          </span>
          <div>
            <a href="${ctx}/member/publicProfile/view?userId=${me.userId}"><c:out value="${me.nickname}" /></a>
            <small>${isHost ? '호스트 · 나' : '나'}</small>
          </div>
        </div>
        <div class="att-view">
          <span class="pill ${me.attendance ? 'pill-success' : 'pill-danger'} bd">${me.attendance ? '출석' : '미출석'}</span>
        </div>
        <div class="rate"></div>
      </div>
      </c:if>

      <c:if test="${empty userList}">
        <p class="t-11 t-2" style="padding:20px 0;text-align:center">평가할 참가자가 없어요.</p>
      </c:if>

      <c:forEach var="u" items="${userList}">
        <div class="eval-row">
          <div class="who">
            <span class="avatar sm">
              <c:choose>
                <c:when test="${not empty u.profileImage}">
                  <img alt="" src="${ctx}${profilePath}/${u.profileImage}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;">
                </c:when>
                <c:otherwise>
                  <img alt="" src="${ctx}/img/default-profile.svg" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;">
                </c:otherwise>
              </c:choose>
            </span>
            <div>
              <a href="${ctx}/member/publicProfile/view?userId=${u.userId}"><c:out value="${u.nickname}" /></a>
              <c:if test="${u.userId eq personalMatch.userId}"><small>호스트</small></c:if>
            </div>
          </div>
          <div class="att-view">
            <span class="pill ${u.attendance ? 'pill-success' : 'pill-danger'} bd">${u.attendance ? '출석' : '미출석'}</span>
          </div>
			<div class="rate">
			  <c:if test="${not empty u.myScore and u.myScore gt 0}">
			    <span class="rating">${u.myScore}</span>
			  </c:if>
			</div>
        </div>
      </c:forEach>

      <div class="form-actions" style="margin-right:20px">
        <a class="btn btn-primary" href="${ctx}/match/after/profile/list/edit?personalMatchId=${personalMatch.personalMatchId}">정보 수정</a>
      </div>
    </div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>