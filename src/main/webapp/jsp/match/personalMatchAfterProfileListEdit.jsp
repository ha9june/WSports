<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 후 관리 - 출석 체크 · 참가자 평가 (personalMatchAfterMatchEdit.jsp) - 담당: 변재언
  피그마: Postgame / Rating / Edit / Desktop, Postgame / Rating / From Participating Past Match / Desktop
  ─ 하나의 JSP 로 처리 ─
   state : host(작성자 - 출석 체크 + 평가) | participant(참가자 - 출석은 조회만, 평가만 작성)
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

    <form class="postgame-card" action="${ctx}/match/after/profile/list/edit" method="post">
      <input type="hidden" name="personalMatchId" value="${personalMatch.personalMatchId}">

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
        <p>${isHost ? '출석은 호스트만 체크할 수 있어요. 참가자의 출석 여부를 체크하고 경기 매너를 평가해주세요.' : '호스트가 체크한 출석 정보를 확인하고, 함께 뛴 참가자의 매너를 평가해주세요.'}</p>
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
        <c:choose>
          <c:when test="${isHost}">
            <div class="chip-group att-toggle" data-select="single" data-name="attendMe">
              <button type="button" class="chip ${me.attendance ne false ? 'is-selected' : ''}" data-value="Y">출석</button>
              <button type="button" class="chip ${me.attendance eq false ? 'is-selected' : ''}" data-value="N">미출석</button>
            </div>
          </c:when>
          <c:otherwise>
            <div class="att-view">
              <span class="pill ${me.attendance ? 'pill-success' : 'pill-danger'} bd">${me.attendance ? '출석' : '미출석'}</span>
            </div>
          </c:otherwise>
        </c:choose>
        <div></div>
      </div>
      </c:if>

      <c:forEach var="u" items="${userList}" varStatus="st">
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

          <c:choose>
            <c:when test="${isHost}">
              <div class="chip-group att-toggle" data-select="single" data-name="attend_${st.index}">
                <button type="button" class="chip ${u.attendance ? 'is-selected' : ''}" data-value="Y">출석</button>
                <button type="button" class="chip ${not u.attendance ? 'is-selected' : ''}" data-value="N">미출석</button>
              </div>
            </c:when>
            <c:otherwise>
              <div class="att-view">
                <span class="pill ${u.attendance ? 'pill-success' : 'pill-danger'} bd">${u.attendance ? '출석' : '미출석'}</span>
              </div>
            </c:otherwise>
          </c:choose>

          <c:set var="myScore" value="${empty u.myScore ? 0 : u.myScore}" />
          <div class="rate star-input">
            <c:forEach var="i" begin="1" end="5">
              <button type="button" aria-label="${i}점" class="${myScore >= i ? 'is-on' : ''}">★</button>
            </c:forEach>
            <span class="score"><c:out value="${myScore eq 0 ? '-' : myScore}" /></span>
            <input type="hidden" name="score_${st.index}" value="${myScore}">
          </div>

          <input type="hidden" name="userId_${st.index}" value="${u.userId}">
        </div>
      </c:forEach>

      <div class="form-actions" style="margin-right:20px">
        <button type="submit" class="btn btn-primary">정보 저장</button>
      </div>
    </form>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>