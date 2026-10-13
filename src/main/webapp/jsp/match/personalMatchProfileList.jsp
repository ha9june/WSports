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
<style>
/* 경기 정보 박스: 참가자 박스와 같은 톤 */
.match-summary {
	position: relative;
	background: #fff !important;
	border: 1px solid #e5e7eb;
	border-radius: 12px;
	padding: 20px 24px;
	margin-bottom: 24px;
}
.match-summary .meta span {
	display: inline-flex;
	align-items: center;
	gap: 6px;
}
.match-summary .meta span img {
	flex-shrink: 0;
}
.match-summary .target {
	margin-top: 28px;
}
.match-summary .target small {
	color: #1a6bff;
	font-weight: 600;
}

/* 경기 상세 보기: 박스 오른쪽 위 (참가자 인원 위) */
.match-detail-link {
	position: absolute;
	top: 20px;
	right: 24px;
	color: #1a6bff;
	font-size: 14px;
	font-weight: 600;
	text-decoration: none;
}
.match-detail-link:hover {
	text-decoration: underline;
}

/* 왼쪽: 제목, 경기 정보 키우기 */
.match-summary > div:first-of-type strong {
	font-size: 21px;
	line-height: 1.4;
	margin: 6px 0 10px;
}
.match-summary .meta {
	font-size: 15px;
	gap: 28px;
}
.match-summary .meta span {
	font-size: 13px;
	gap: 8px;
}
.match-summary .meta span img {
	width: 18px;
	height: 18px;
}

/* 오른쪽: 경기 상세 보기, 참가자 인원 줄이기 */
.match-detail-link {
	font-size: 12px;
	top: 18px;
	right: 22px;
}
.match-summary .target {
	margin-top: 22px;
	font-size: 11px;
}
.match-summary .target b {
	font-size: 18px;
}
.match-summary .target small {
	font-size: 11px;
}
</style>

<main class="page">
  <div class="container">
    <nav class="breadcrumb"><a href="${ctx}/jsp/mypage/myPagePersonalMatch.jsp">마이페이지 내 경기</a><span class="sep">›</span><span>참가자 프로필</span></nav>
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
                     onerror="this.onerror=null;this.src='${ctx}/img/default-profile.svg';"
                     style="width:100%;height:100%;border-radius:50%;object-fit:cover;display:block;">
              </c:when>
              <c:otherwise>
                <img src="${ctx}/img/default-profile.svg" alt=""
                     style="width:100%;height:100%;border-radius:50%;object-fit:cover;display:block;">
              </c:otherwise>
            </c:choose>
          </span>
          <strong><c:out value="${user.nickname}" /></strong>
          <c:choose>
            <c:when test="${not empty user.avgRatingScore and user.avgRatingScore > 0}">
              <span class="rating">${user.avgRatingScore}</span>
            </c:when>
            <c:otherwise>
              <span class="t-11 t-2">평가 없음</span>
            </c:otherwise>
          </c:choose>
        </a>
      </c:forEach>
    </div>

    <%-- <div class="form-actions"><a class="btn btn-primary btn-sm" href="${ctx}/jsp/mypage/myPagePersonalMatch.jsp">마이페이지 내 경기로</a></div> --%>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>