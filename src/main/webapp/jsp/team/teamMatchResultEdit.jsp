<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 경기 후 관리 (teamMatchResultEdit.jsp) - 담당: 하준수
  팀 단위로 출석 상태를 확인하고 상대 팀의 경기 매너를 평가합니다. (팀 단위 출석만, 개인 평가 없음)
  서블릿에서 넘기는 값
    teamMatch : 경기 정보
    hostTeam  : 모집 팀 (작성자 팀)
    guestTeam : 참가 팀 (신청 팀)
    ourTeam   : "host" | "guest"  (로그인 유저가 속한 쪽)
--%>
<c:set var="pageTitle" value="팀 경기 후 관리" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="teamMatch" />
<c:set var="hostIsOur" value="${ourTeam eq 'host'}" />
<c:choose>
	<c:when test="${not empty hostTeam.profileImage}">
		<c:set var="hostImg" value="${ctx}/uploads/${hostTeam.profileImage}" />
	</c:when>
	<c:otherwise>
		<c:set var="hostImg" value="${ctx}/img/default-profile.svg" />
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${not empty guestTeam.profileImage}">
		<c:set var="guestImg" value="${ctx}/uploads/${guestTeam.profileImage}" />
	</c:when>
	<c:otherwise>
		<c:set var="guestImg" value="${ctx}/img/default-profile.svg" />
	</c:otherwise>
</c:choose>
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container narrow-rail">
		<nav class="breadcrumb">
			<a href="${ctx}/team-match/list">팀 경기</a><span class="sep">›</span><span>경기 후 관리</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">팀 경기 후 관리</h1>
		</div>
		<div class="info-banner">
			양 팀의 출석 상태를 확인하고 상대 팀의 경기 매너만 평가합니다.<small>팀 단위 출석 정보만 제공하며
				우리 팀과 개인 평가는 제공하지 않습니다.</small>
		</div>

		<form class="postgame-card" action="${ctx}/team-match/result/edit" method="post">
			<input type="hidden" name="teamMatchId" value="${teamMatch.teamMatchId}">
			<input type="hidden" name="targetTeamId" value="${hostIsOur ? guestTeam.teamId : hostTeam.teamId}">

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
				<p>양 팀의 출석 상태를 확인하고 상대 팀의 경기 매너를 평가해주세요.</p>
			</div>

			<%-- 모집 팀 (항상 위) --%>
			<div class="eval-row">
				<div class="who">
					<span class="avatar sm">
						<img alt="" src="${hostImg}">
					</span>
					<div>
						<c:out value="${hostTeam.teamName}" /><small>모집 팀${hostIsOur ? ' · 우리 팀' : ''}</small>
					</div>
				</div>
				<c:choose>
					<c:when test="${hostIsOur}">
						<div class="chip-group att-toggle" data-select="single" data-name="attendHost">
							<button type="button" class="chip ${hostP.attendance ne false ? 'is-selected' : ''}" data-value="true">출석</button>
							<button type="button" class="chip ${hostP.attendance eq false ? 'is-selected' : ''}" data-value="false">미출석</button>
						</div>
					</c:when>
					<c:otherwise>
						<div class="att-view">
							<span class="pill ${hostP.attendance ? 'pill-success' : 'pill-danger'} bd">
								${hostP.attendance ? '출석' : '미출석'}
							</span>
						</div>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${not hostIsOur}">
					<div class="rate star-input">
						<c:forEach var="i" begin="1" end="5">
							<button type="button" aria-label="${i}점" class="${not empty score and score >= i ? 'is-on' : ''}">★</button>
						</c:forEach>
						<span class="score"><c:out value="${empty score ? '-' : score}" /></span><input type="hidden" name="score" value="${score}">
					</div>
					</c:when>
					<c:otherwise><div></div></c:otherwise>
				</c:choose>
			</div>

			<%-- 참가 팀 (항상 아래) --%>
			<div class="eval-row">
				<div class="who">
					<span class="avatar sm">
						<img alt="" src="${guestImg}">
					</span>
					<div>
						<c:out value="${guestTeam.teamName}" /><small>참가 팀${hostIsOur ? '' : ' · 우리 팀'}</small>
					</div>
				</div>
				<c:choose>
					<c:when test="${hostIsOur}">
						<div class="chip-group att-toggle" data-select="single" data-name="attendGuest">
							<button type="button" class="chip ${guestP.attendance ne false ? 'is-selected' : ''}" data-value="true">출석</button>
							<button type="button" class="chip ${guestP.attendance eq false ? 'is-selected' : ''}" data-value="false">미출석</button>
						</div>
					</c:when>
					<c:otherwise>
						<div class="att-view">
							<span class="pill ${hostP.attendance ? 'pill-success' : 'pill-danger'} bd">
								${hostP.attendance ? '출석' : '미출석'}
							</span>
						</div>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${hostIsOur}">
						<div class="rate star-input">
							<c:forEach var="i" begin="1" end="5">
								<button type="button" aria-label="${i}점" class="${not empty score and score >= i ? 'is-on' : ''}">★</button>
							</c:forEach>
							<span class="score"><c:out value="${empty score ? '-' : score}" /></span><input type="hidden" name="score" value="${score}">
						</div>
					</c:when>
					<c:otherwise><div></div></c:otherwise>
				</c:choose>
			</div>

			<div class="form-actions">
				<button type="submit" class="btn btn-primary">정보 저장</button>
			</div>
		</form>
	</div>
</main>
<script>
$('.postgame-card').on('submit', function (e) {
	if ($('input[name="score"]').length && !$('input[name="score"]').val()) {
		e.preventDefault();
		showToast('상대 팀의 경기 매너 점수를 선택해 주세요.');
	}
});
</script>
<%@ include file="/jsp/common/footer.jsp"%>