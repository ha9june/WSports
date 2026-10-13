<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 경기 후 관리 조회 (teamMatchResultDetail.jsp) - 담당: 하준수
  서블릿에서 넘기는 값
    teamMatch : 경기 정보
    hostTeam / guestTeam : 모집 팀 / 참가 팀
    hostP / guestP       : 각 팀의 참가 정보 (attendance)
    ourTeam   : "host" | "guest"
    score     : 내가 상대 팀에 준 점수 (없으면 null)
--%>
<c:set var="pageTitle" value="팀 경기 후 관리" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="teamMatch" />
<c:set var="demoRoles" value="member" />
<c:set var="hostIsOur" value="${ourTeam eq 'host'}" />
<style>
.eval-row .who a:hover {
	text-decoration: underline;
}
</style>
<c:choose>
	<c:when test="${not empty hostTeam.profileImage}"><c:set var="hostImg" value="${ctx}/uploads/${hostTeam.profileImage}" /></c:when>
	<c:otherwise><c:set var="hostImg" value="${ctx}/img/default-profile.svg" /></c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty guestTeam.profileImage}"><c:set var="guestImg" value="${ctx}/uploads/${guestTeam.profileImage}" /></c:when>
	<c:otherwise><c:set var="guestImg" value="${ctx}/img/default-profile.svg" /></c:otherwise>
</c:choose>
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container">
		<nav class="breadcrumb">
			<a href="${ctx}/mypage/matches/team">팀 경기</a><span class="sep">›</span><span>경기 후 관리</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">팀 경기 후 관리</h1>
		</div>
		<div class="info-banner">
			양 팀의 출석 상태를 확인하고 상대 팀의 경기 매너만 평가합니다.<small>팀 단위 출석 정보만 제공하며
				우리 팀과 개인 평가는 제공하지 않습니다.</small>
		</div>

		<div class="postgame-card">
			<div class="match-summary">
				<div>
					<c:choose>
						<c:when test="${teamMatch.sport eq '축구/풋살'}"><c:set var="sportCls" value="football" /></c:when>
						<c:when test="${teamMatch.sport eq '농구'}"><c:set var="sportCls" value="basketball" /></c:when>
						<c:when test="${teamMatch.sport eq '테니스'}"><c:set var="sportCls" value="tennis" /></c:when>
						<c:when test="${teamMatch.sport eq '배드민턴'}"><c:set var="sportCls" value="badminton" /></c:when>
					</c:choose>
					<p class="tags">
						<span class="sport-chip ${sportCls}"><c:out value="${teamMatch.sport}" /></span>
						<span class="pill pill-info bd">경기 종료</span>
					</p>
					<strong><c:out value="${teamMatch.title}" /></strong>
					<p class="meta">
						<span><img src="${ctx}/img/icon-calendar-14.svg" alt="">${teamMatch.matchDate} (${teamMatch.dayOfWeekKorean})</span>
						<span><img src="${ctx}/img/icon-clock-16.svg" alt="">${fn:substring(teamMatch.startTime, 0, 5)} ~ ${fn:substring(teamMatch.endTime, 0, 5)}</span>
						<span><img src="${ctx}/img/icon-pin-14.svg" alt=""><c:out value="${teamMatch.placeName}" /></span>
					</p>
				</div>
				<div class="target">
					평가 대상<b>1팀</b>
				</div>
			</div>

			<div class="eval-head">
				<h3>출석 · 참가 팀 평가</h3>
				<p>양 팀의 출석 상태와 내가 남긴 상대 팀 평가를 확인하세요.</p>
			</div>

			<%-- 모집 팀 (항상 위) --%>
			<div class="eval-row">
				<div class="who">
					<span class="avatar sm">
						<img alt="" src="${hostImg}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;">
					</span>
					<div>
						<a href="${ctx}/team/detail/view?teamId=${hostTeam.teamId}"><c:out value="${hostTeam.teamName}" /></a><small>모집 팀${hostIsOur ? ' · 우리 팀' : ''}</small>
					</div>
				</div>
				<div class="att-view">
					<span class="pill ${hostP.attendance ? 'pill-success' : 'pill-danger'} bd">${hostP.attendance ? '출석' : '미출석'}</span>
				</div>
				<c:choose>
					<c:when test="${not hostIsOur}">
						<div class="rate">
							<c:choose>
								<c:when test="${empty score}"><span class="t-11 t-2">평가 전</span></c:when>
								<c:otherwise><span class="rating">${score}</span></c:otherwise>
							</c:choose>
						</div>
					</c:when>
					<c:otherwise><div></div></c:otherwise>
				</c:choose>
			</div>

			<%-- 참가 팀 (항상 아래) --%>
			<div class="eval-row">
				<div class="who">
					<span class="avatar sm">
						<img alt="" src="${guestImg}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;">
					</span>
					<div>
						<a href="${ctx}/team/detail/view?teamId=${guestTeam.teamId}"><c:out value="${guestTeam.teamName}" /></a><small>참가 팀${hostIsOur ? '' : ' · 우리 팀'}</small>
					</div>
				</div>
				<div class="att-view">
					<span class="pill ${guestP.attendance ? 'pill-success' : 'pill-danger'} bd">${guestP.attendance ? '출석' : '미출석'}</span>
				</div>
				<c:choose>
					<c:when test="${hostIsOur}">
						<div class="rate">
							<c:choose>
								<c:when test="${empty score}"><span class="t-11 t-2">평가 전</span></c:when>
								<c:otherwise><span class="rating">${score}</span></c:otherwise>
							</c:choose>
						</div>
					</c:when>
					<c:otherwise><div></div></c:otherwise>
				</c:choose>
			</div>

			<div class="form-actions" style="margin-right: 20px">
				<c:if test="${hostIsOur or empty score}">
					<a class="btn btn-primary" href="${ctx}/team-match/result/edit?teamMatchId=${teamMatch.teamMatchId}">${empty score ? '평가하기' : '정보 수정'}</a>
				</c:if>
			</div>
		</div>
	</div>
</main>
<%@ include file="/jsp/common/footer.jsp"%>