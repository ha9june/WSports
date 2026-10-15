<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  메인 (main.jsp) - 담당: 변재언
  피그마: Main / Landing / Desktop
  권한별 차이 : 비회원은 추천 대신 인기 경기 기준 문구, 헤더 로그인 버튼
--%>
<c:set var="pageTitle" value="메인" />
<c:set var="pageCss" value="home,team" />
<c:set var="pageJs" value="" />
<c:set var="showFooter" value="true" />
<%@ include file="/jsp/common/header.jsp"%>
<style>
.review-mini .top {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.review-mini .top .date {
	font-size: 12px;
	color: #94a3b8;
	white-space: nowrap;
}

/* 후기 내용: 두 줄 넘으면 ... */
.review-mini p {
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	word-break: break-all;
}

.review-mini .sport-tag {
	display: inline-flex;
	align-items: center;
	height: 24px;
	padding: 0 12px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 700;
}

.review-mini .foot {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 16px;
	padding-top: 14px;
	border-top: 1px solid #eef0f3;
}

.review-mini .sport-tag.football {
	background: #e0edff;
	color: #1a6bff;
}

.review-mini .sport-tag.basketball {
	background: #ffeadb;
	color: #c2410c;
}

.review-mini .sport-tag.tennis {
	background: #d6f5f2;
	color: #0f766e;
}

.review-mini .sport-tag.badminton {
	background: #e8e5ff;
	color: #5b4bd6;
}

.review-mini .who {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	min-width: 0;
	font-size: 13px;
	font-weight: 700;
	color: #111;
}

.review-mini .who img {
	width: 28px;
	height: 28px;
	border-radius: 50%;
	object-fit: cover;
}

.review-mini .more {
	flex-shrink: 0;
	font-size: 13px;
	font-weight: 700;
	color: #1a6bff;
}


</style>
<script>
	$(function() {

		$(document).on("click", ".fav-btn", function(e) {
			e.preventDefault();
			e.stopPropagation();
			const $btn = $(this);

			$.ajax({
				url : "${ctx}/mypage/matches/saved",
				type : "post",
				dataType : "text",
				data : {
					matchId : $btn.data("id"),
					matchType : "PERSONAL"
				},
				success : function(res) {
					if (res === "insert")
						$btn.addClass("is-on");
					else if (res === "delete")
						$btn.removeClass("is-on");
				},
				error : function(xhr) {
					if (xhr.status == 401)
						alert("로그인이 필요합니다.");
					else
						alert("오류가 생겼습니다.");
				}
			});
		});

	});
</script>
<section class="hero">
	<div class="container">
		<p class="eyebrow">혼자여도, 팀이어도, 매치온에서</p>
		<h1>
			경기를 찾고, 팀에 들어가고,<br>뛴 후엔 후기를 남겨보세요
		</h1>
		<p>경기 찾기, 팀, 후기까지 · 매치온 하나로 축구·농구·테니스·배드민턴을 즐겨보세요.</p>
		<a class="btn btn-primary" href="${ctx}/match/list">경기 찾아보기</a>
	</div>
</section>

<main class="page">
	<div class="container">
		<section>
			<div class="section-head">
				<div>
					<h2 class="section-title">경기 찾기</h2>
					<p class="section-desc">지금 열려있는 경기를 둘러보세요.</p>
				</div>
				<a class="t-brand t-13" href="${ctx}/match/list"
					style="font-weight: 500">전체보기 →</a>
			</div>


			<div id="recomandMatchListDiv" class="feature-row">
				<c:forEach var="match" items="${nMList}">
					<c:set var="sportClass"
						value="${match.sport eq '축구/풋살' ? 'football' :
    		    match.sport eq '농구' ? 'basketball' :	
                match.sport eq '테니스' ? 'tennis' :
                match.sport eq '배드민턴' ? 'badminton' : ''}" />
					<a class="match-card ${sportClass}"
						href="${ctx}/match/detail/view?personalMatchId=${match.personalMatchId}">
						<img class="art" src="${ctx}/img/art-${sportClass}.png" alt="">
						<span class="sport-tag ${sportClass}">${match.sport}</span>
						<button type="button"
							class="fav-btn bare ${match.favorite ? 'is-on' : ''}" data-fav
							data-auth data-id="${match.personalMatchId}" aria-label="관심 경기">${heart}</button>
						<span class="signal"><img src="${ctx}/img/icon-pin-14.svg"
							alt="">${sessionScope.user == null  ? '인기 경기' : '지역 · 실력 일치'}</span>
						<div class="body">
							<p class="title">${match.title}</p>
							<p class="when">
								<img src="${ctx}/img/icon-calendar-14.svg" alt="">${match.startTime}
								· ${match.region}
							</p>
							<p class="price"><fmt:formatNumber value="${match.participationFee}" pattern="#,###" />원</p>
						</div>
						<p class="count">${match.currentPeople}명<small>/ 정원
								${match.maxPeople}명</small>
						</p>
						<div class="bar">
							<i style="width:${match.currentPeople * 100 / match.maxPeople}%"></i>
						</div>
					</a>
				</c:forEach>
			</div>

		</section>

		<section class="landing-section">
			<div class="section-head">
				<div>
					<h2 class="section-title">팀</h2>
					<p class="section-desc">꾸준히 함께 뛸 사람들을 팀에서 만나보세요.</p>
				</div>
				<a href="${ctx}/team/list">전체보기 →</a>
			</div>
			<div id="recomandTeamListDiv" class="team-mini-row">
				<c:forEach var="team" items="${nTList}">
					<c:set var="sportClass"
						value="${team.sport eq '축구/풋살' ? 'football' :
			    		    team.sport eq '축구' ? 'football' :	
			    		    team.sport eq '농구' ? 'basketball' :	
			                team.sport eq '테니스' ? 'tennis' :
			                team.sport eq '배드민턴' ? 'badminton' : ''}" />
					<a class="team-mini"
						href="${ctx}/team/detail/view?teamId=${team.teamId}">
						<div class="top">
							<span class="logo-ph" id="profileImg">
								<c:choose>
									<c:when test="${not empty team.profileImage}"> 
										<img src="${ctx}/uploads/<c:out value='${team.profileImage}'/>" style="border-radius:50%;" alt="">
									</c:when>
									<c:otherwise>
										<img src="${ctx}/img/team-${sportClass}.png" alt="">
									</c:otherwise>
								</c:choose>
							</span>

							
							<div>
								<strong>${team.teamName}</strong>
								<p class="meta">${team.sport}</p>
								<p class="sub">
									<span><img src="${ctx}/img/icon-user-12.svg" alt="">${team.currentPeople}</span>
									<span><img src="${ctx}/img/icon-pin-12.svg" alt="">${team.region1}</span>
								</p>
							</div>
						</div>
						<div class="foot">
							<span class="sport-tag ${sportClass }">${team.sport}</span>
						</div>
					</a>
				</c:forEach>
			</div>
		</section>
		<section class="landing-section">
			<div class="section-head">
				<div>
					<h2 class="section-title">후기</h2>
					<p class="section-desc">먼저 뛰어본 사람들의 이야기를 들어보세요.</p>
				</div>
				<a href="${ctx}/review/list">전체보기 →</a>
			</div>

			<div class="review-mini-row">
				<c:forEach var="review" items="${nRList}">
					<c:set var="rSport"
						value="${review.sport eq '축구/풋살' or review.sport eq '축구' ? 'football' :
				review.sport eq '농구' ? 'basketball' :
				review.sport eq '테니스' ? 'tennis' :
				review.sport eq '배드민턴' ? 'badminton' : ''}" />
					<c:set var="rProfile"
						value="${not empty review.profileImage ? ctx.concat('/uploads/').concat(review.profileImage) : ctx.concat('/img/default-profile.svg')}" />
					<a class="review-mini"
						href="${ctx}/review/detail?reviewId=${review.reviewId}">
						<div class="top">
							<span class="sport-tag ${rSport}">${review.sport}</span> <span
								class="date">${fn:replace(fn:substring(review.createdAt, 0, 10), '-', '.')}</span>
						</div> <strong><c:out value="${review.title}" /></strong>
						<p>
							<c:out value="${review.content}" />
						</p>
						<div class="foot">
							<span class="who"> <img src="${rProfile}" alt=""> <c:out
									value="${review.nickname}" />
							</span> <span class="more">후기 보기 →</span>
						</div>
					</a>
				</c:forEach>
			</div>
		</section>
	</div>
</main>

<%@ include file="/jsp/common/footer.jsp"%>
