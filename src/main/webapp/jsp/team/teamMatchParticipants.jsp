<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  참가 팀 확인 (teamMatchParticipants.jsp) - 담당: 하준수
  피그마: Club Match / Participants / Desktop
  우리 팀 / 상대 팀의 팀 프로필을 나란히 보여줍니다.
--%>
<c:set var="pageTitle" value="참가 팀 확인" />
<c:set var="pageCss" value="team" />
<c:set var="activeNav" value="teamMatch" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container">
		<nav class="breadcrumb">
			<a href="${ctx}/team-match/list">상대팀 찾기</a><span class="sep">›</span><span>참가
				팀 확인</span>
		</nav>
		<div class="page-head">
			<h1 class="page-title">참가 팀 확인</h1>
			<p class="page-desc">경기에 참가한 우리 팀과 상대 팀의 프로필을 확인합니다.</p>
		</div>
		<div class="vs-grid">
			<section class="vs-card">
				<h2>${hostTeam.teamName}</h2>
				<a href="${ctx}/team/detail/view?teamId=${hostTeam.teamId}">팀 상세보기</a>
				<p class="who">모집 팀</p>
				<div class="body">
					<c:choose>
							<c:when test="${not empty hostTeam.profileImage}">
								<img src="${ctx}/uploads/${hostTeam.profileImage}" alt="">
							</c:when>
							<c:when test="${hostTeam.sport eq '축구/풋살' }">
								<img src="${ctx}/img/team-football.png" alt="">
							</c:when>
							<c:when test="${hostTeam.sport eq '농구' }">
								<img src="${ctx}/img/team-basketball.png" alt="">
							</c:when>
							<c:when test="${hostTeam.sport eq '테니스' }">
								<img src="${ctx}/img/team-tennis.png" alt="">
							</c:when>
							<c:when test="${hostTeam.sport eq '배드민턴' }">
								<img src="${ctx}/img/team-badminton.png" alt="">
							</c:when>
						</c:choose>
					<dl>
						<dt>활동 지역</dt>
						<dd>${hostTeam.regions}</dd>
						<dt>인원</dt>
						<dd>${hostTeam.currentPeople}명</dd>
						<dt>종목</dt>
						<dd>${hostTeam.sport}</dd>
						<dt>실력</dt>
						<dd>${hostTeam.skill}</dd>
						<dt>팀 평점</dt>
						<dd>
							<c:choose>
								<c:when test="${hostTeam.teamRating != null}">
									<span class="rating">${hostTeam.teamRating}</span>
									<span class="t-11 t-2">(${hostTeam.teamRatingCount})</span>
								</c:when>
								<c:otherwise>
									<span class="t-11 t-2">평가 없음</span>
								</c:otherwise>
							</c:choose>
						</dd>
					</dl>
				</div>
			</section>
			<section class="vs-card">
				<h2>${guestTeam.teamName}</h2>
				<a href="${ctx}/team/detail/view?teamId=${guestTeam.teamId}">팀 상세보기</a>
				<p class="who">상대 팀</p>
				<div class="body">
					<c:choose>
							<c:when test="${not empty guestTeam.profileImage}">
								<img src="${ctx}/uploads/${guestTeam.profileImage}" alt="">
							</c:when>
							<c:when test="${guestTeam.sport eq '축구/풋살' }">
								<img src="${ctx}/img/team-football.png" alt="">
							</c:when>
							<c:when test="${guestTeam.sport eq '농구' }">
								<img src="${ctx}/img/team-basketball.png" alt="">
							</c:when>
							<c:when test="${guestTeam.sport eq '테니스' }">
								<img src="${ctx}/img/team-tennis.png" alt="">
							</c:when>
							<c:when test="${guestTeam.sport eq '배드민턴' }">
								<img src="${ctx}/img/team-badminton.png" alt="">
							</c:when>
						</c:choose>
					<dl>
						<dt>활동 지역</dt>
						<dd>${guestTeam.regions}</dd>
						<dt>인원</dt>
						<dd>${guestTeam.currentPeople}명</dd>
						<dt>종목</dt>
						<dd>${guestTeam.sport}</dd>
						<dt>실력</dt>
						<dd>${guestTeam.skill}</dd>
						<dt>팀 평점</dt>
						<dd>
							<c:choose>
								<c:when test="${guestTeam.teamRating != null}">
									<span class="rating">${guestTeam.teamRating}</span>
									<span class="t-11 t-2">(${guestTeam.teamRatingCount})</span>
								</c:when>
								<c:otherwise>
									<span class="t-11 t-2">평가 없음</span>
								</c:otherwise>
							</c:choose>
						</dd>
					</dl>
				</div>
			</section>
		</div>
		<div class="form-actions">
			<a class="btn btn-outline"
				href="${ctx}/team-match/detail/view?teamMatchId=${teamMatchId}">경기
				상세로</a>
		</div>
	</div>
</main>
<%@ include file="/jsp/common/footer.jsp"%>
