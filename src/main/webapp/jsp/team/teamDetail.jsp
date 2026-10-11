<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 상세 (teamDetail.jsp) - 담당: 하준수
  피그마: Club / Detail / Desktop (비가입자), Club / Detail / Member View, Club / Detail / Manager View
  ─ 하나의 JSP 로 처리 ─
   state : public(비가입자 - 팀원/작성글 잠금, 가입 신청) | member(팀원) | manager(팀장·부팀장 - 팀 관리 버튼)
   role  : guest 면 state 와 상관없이 public 화면 + 가입 신청 시 로그인 안내
   admin : 관리자는 팀 삭제 버튼 노출
  실구현 : 로그인 사용자와 팀의 관계(TEAM_MEMBER.role)로 서블릿에서 state 계산
--%>
<%-- <c:set var="state" value="${empty param.state ? 'public' : param.state}" />
<c:if test="${role eq 'guest'}">
	<c:set var="state" value="public" />
</c:if> --%>
<c:set var="isMember" value="${state eq 'member' or state eq 'manager'}" />
<c:set var="pageTitle" value="${team.teamName}" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="team" />
<%@ include file="/jsp/common/header.jsp"%>
<style>
.main-photo {
	width: 100%;
	height: 348px;
	overflow: hidden;
	border-radius: 20px;
	background: #1f2328;
}

.main-photo img {
	width: 100%;
	height: 100%;
	object-fit: contain;
	display: block;
}

.thumbs {
	display: flex;
	gap: 12px;
	margin-top: 12px;
}

.thumbs span {
	width: 120px;
	height: 90px;
	overflow: hidden;
	border-radius: 8px;
	background: #1f2328;
	flex-shrink: 0;
}

.thumbs span img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	display: block;
}

.detail-grid.no-photo .team-tabs {
	margin-top: 0;
}

.detail-grid.no-photo .team-side {
	width: 100%;
}

.intro {
    white-space: pre-line;
}



.team-tabs {
	position: sticky;
	top: var(--header-h);
	z-index: 40;
	background: #fff;
}




</style>
<script>
	$(function() {
		// ===== 탭 : 부드러운 이동 + 하이라이트 (주소에 #을 붙이지 않음) =====
		(function() {
			var ids = ['intro', 'members', 'posts'], pinned = null;

			function headerH() {
				return parseInt(getComputedStyle(document.documentElement).getPropertyValue('--header-h')) || 72;
			}
			function barBottom() {                              // 헤더 + 탭 바 높이
				var bar = document.querySelector('.team-tabs');
				return headerH() + (bar ? bar.offsetHeight : 42);
			}
			function setActive(id) {
				$('.team-tabs .tab').removeClass('is-active')
					.filter('[href="#' + id + '"]').addClass('is-active');
			}
			function update() {
				if (pinned) return;                             // 탭을 눌러 이동한 직후에는 누른 탭 유지
				var line = barBottom() + (window.innerHeight - barBottom()) * 0.5;   // 탭 바 아래 영역의 중간선
				var cur = ids[0];
				ids.forEach(function(id) {
					var s = document.getElementById(id);
					if (s && s.getBoundingClientRect().top <= line) cur = id;
				});
				var atBottom = window.innerHeight + window.scrollY >= document.documentElement.scrollHeight - 2;
				if (atBottom) cur = ids[ids.length - 1];        // 맨 아래면 마지막 탭
				setActive(cur);
			}

			$('.team-tabs .tab').on('click', function(e) {
				e.preventDefault();                             // #members 가 주소에 붙지 않음 → 뒤로가기가 목록으로
				var id = $(this).attr('href').slice(1);
				var el = document.getElementById(id);
				if (!el) return;
				pinned = id;
				setActive(id);
				window.scrollTo({
					top: el.getBoundingClientRect().top + window.scrollY - barBottom() - 16,
					behavior: 'smooth' 
				});
			});
			$(window).on('wheel touchmove keydown', function() { pinned = null; });
			$(window).on('scroll', update);
			update();
		})();
		

		const profileImage = '${team.profileImage}';
		const sport = '${team.sport}';

		let imageSrc = '';

		if (profileImage) {
			imageSrc = '${ctx}/uploads/' + profileImage;
		} else if (sport === '축구/풋살') {
			imageSrc = '${ctx}/img/team-football.png';
		} else if (sport === '농구') {
			imageSrc = '${ctx}/img/team-basketball.png';
		} else if (sport === '테니스') {
			imageSrc = '${ctx}/img/team-tennis.png';
		} else if (sport === '배드민턴') {
			imageSrc = '${ctx}/img/team-badminton.png';
		}

		$('#profileImg').html('<img src="' + imageSrc + '" alt="팀 프로필 이미지">');

		const images = [ '${team.activityImage1}', '${team.activityImage2}',
				'${team.activityImage3}', '${team.activityImage4}',
				'${team.activityImage5}' ];


		var hasImage = images.some(function(image) {
			return image;
		});

		if (!hasImage) {
			$('#activePhoto').hide();

			const $grid = $('.detail-grid').addClass('no-photo');
			const $left = $('<div class="no-photo-left"></div>');

			// 탭 + 소개글 + 팀원 + 팀 작성글을 왼쪽 칼럼으로 이동
			$left.append($('.team-tabs'), $('#intro'), $('#members'),
					$('#posts'));
			$grid.prepend($left);

			return;
		}

		let html = '';
		let mainPhoto = '<img src="${ctx}/uploads/' + images[0]	 + '" alt="활동 사진">';

		images
				.forEach(function(image, index) {
					if (image && index === 0) {
						html += '<span>'
								+ '<img class="subImg" src="${ctx}/uploads/' + image + '" alt="활동 사진" style="border: 2px solid #1677ff">'
								+ '</span>';
					} else if (image) {
						html += '<span>'
								+ '<img class="subImg" src="${ctx}/uploads/' + image + '" alt="활동 사진">'
								+ '</span>';
					}
				});

		$('#mainPhoto').html(mainPhoto);

		$('#thumbs').html(html);

		$('#thumbs').on('click', '.subImg', function() {

			// 메인 사진 변경
			$('#mainPhoto img').attr('src', $(this).attr('src'));

			// 기존 선택 표시 제거
			$('.subImg').css('border', 'none');

			// 클릭한 사진 선택 표시
			$(this).css('border', '2px solid #1677ff');
		});

	});
</script>
<main class="page">
	<div class="container">
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><span>${team.teamName }</span>
		</nav>
		<div class="detail-grid" style="margin-top: 0">
			<div class="gallery" id="activePhoto">
				<div class="main-photo" style="height: 348px" id="mainPhoto"></div>
				<div class="thumbs" id="thumbs"></div>
			</div>
			<aside class="team-side">
				<div class="top">
					<span class="logo-ph" id="profileImg"> <%-- <img src="${ctx}/uploads/${team.profileImage }" alt="대표"> --%>
					</span>
					<div>
						<h1>${team.teamName }</h1>
						<p>${team.sport } · 팀원 ${team.currentPeople }</p>
					</div>
				</div>
				<h2>모집 조건</h2>
				<dl class="cond">
					<dt>성별</dt>
					<dd>${team.gender }</dd>
					<dt>연령대</dt>
					<dd>${team.ages }</dd>
					<dt>실력</dt>
					<dd>${team.skill }</dd>
					<dt>활동 지역</dt>
					<dd>${team.regions }</dd>
				</dl>
				<c:choose>
					<c:when test="${state eq 'manager'}">
						<hr style="margin-bottom: 0">
						<c:url var="manageUrl" value="/team/manage/applications">
						     <c:param name="teamId" value="${team.teamId}" />
						</c:url>
						<a class="btn btn-primary btn-block" href="${manageUrl}">팀 관리</a>
					</c:when>
					<c:when test="${state eq 'member'}">
						<hr>
						<p class="note">가입된 팀입니다. 팀원과 작성글을 확인할 수 있어요.</p>
					</c:when>
					<c:when test="${state eq 'applicater'}">
						<hr>
						<p class="note">가입 신청이 접수되었어요. 주장 승인을 기다리는 중이에요.</p>
						<button type="button" class="btn btn-join btn-block" disabled>승인 대기 중</button>
					</c:when>
					<c:otherwise>
						<hr>
						   <c:url var="applyUrl" value="/team/application">
						     <c:param name="teamId" value="${team.teamId}" />
						   </c:url>
						   <a class="btn btn-join btn-block" href="${applyUrl}" data-auth>가입 신청하기</a>
					</c:otherwise>
				</c:choose>
				<c:if test="${sessionScope.user.grade eq 'Admin'}">
					<button type="button" class="btn btn-danger btn-block btn-sm"
						data-modal-open="teamDeleteModal">팀 삭제</button>
				</c:if>
			</aside>
		</div>

		<nav class="tabs team-tabs">
			<a class="tab is-active" href="#intro">소개글</a> <a
				class="tab ${isMember ? '' : 'locked'}" href="#members">팀원</a> <a
				class="tab ${isMember ? '' : 'locked'}" href="#posts">팀 작성글</a>
		</nav>

		<section class="team-section" id="intro">
			<h2>팀 소개</h2>
			  <p class="intro"><c:out value="${team.description}" /></p>
		</section>

		<c:choose>
			<c:when test="${isMember}">
				<section class="team-section" id="members" style="margin-top: 56px">
					<div class="section-head">
						<div>
							<h2>팀원 ${team.currentPeople }명</h2>
							<p class="section-desc">함께 활동 중인 팀원의 역할과 프로필을 확인할 수 있어요.</p>
						</div>
						<a class="btn btn-outline btn-sm"
							href="${ctx}/jsp/team/teamInfoMembers.jsp">전체보기</a>
					</div>
					<div class="member-grid">
						<c:forEach var="user" items="${teamUserList}">
							<c:choose>
								<c:when test="${team.sport eq '축구/풋살'}">
									<c:set var="userSkill" value="${user.soccerSkill}" />
								</c:when>
								<c:when test="${team.sport eq '농구'}">
									<c:set var="userSkill" value="${user.basketballSkill}" />
								</c:when>
								<c:when test="${team.sport eq '테니스'}">
									<c:set var="userSkill" value="${user.tennisSkill}" />
								</c:when>
								<c:otherwise>
									<c:set var="userSkill" value="${user.badmintonSkill}" />
								</c:otherwise>
							</c:choose>
							<div class="member-card">
								<c:choose>
									<c:when test="${not empty user.profileImage}">
										<span class="avatar"><img
											src="${ctx}/uploads/${user.profileImage}" alt=""></span>
									</c:when>
									<c:otherwise>
										<span class="avatar default"></span>
									</c:otherwise>
								</c:choose>
								<div class="info">
									<strong><c:out value="${user.nickname}" /></strong>
									<c:if test="${user.teamRole eq 'CAPTAIN'}">
										<span class="pill pill-brand role">주장</span>
									</c:if>
									<c:if test="${user.teamRole eq 'VICE_CAPTAIN'}">
										<span class="pill pill-brand role">부주장</span>
									</c:if>
									<p class="meta">
										<c:out value="${user.preferredRegion1}" default="지역 미설정" />
										·
										<c:out value="${userSkill}" default="실력 미설정" />
									</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</section>
				<section class="team-section" id="posts" style="margin-top: 48px">
					<div class="section-head">
						<div>
							<h2>팀 작성글</h2>
							<p class="section-desc">팀이 작성한 상대 팀 모집 글이에요.</p>
						</div>
						<a class="btn btn-outline btn-sm"
							href="${ctx}/jsp/team/teamInfoPosts.jsp">전체보기</a>
					</div>
					<div class="post-grid">

						<c:forEach var="match" items="${teamMatchList }">
							<a class="post-card" href="${ctx}/team-match/detail/view?teamMatchId=${match.teamMatchId}">
								<p class="ttl" style="margin: 0">
									<c:out value="${match.title }"></c:out> 
									<span class="pill pill-success"><c:out value="${match.status }"></c:out></span>
								</p>
									<p><c:out value="${match.matchDate }"></c:out> 
									(요일) 
									<c:out value="${match.startTime }"></c:out> - 
									<c:out value="${match.endTime }"></c:out> · 
									<c:out value="${match.placeName }"></c:out> 
								</p>
							</a>
						</c:forEach>
					</div>
				</section>
			</c:when>
			<c:otherwise>
				<section class="team-section" id="members" style="margin-top: 56px">
					<h2>팀원</h2>
					<p class="section-desc">가입한 팀원만 확인할 수 있는 정보입니다.</p>
					<div class="locked-wrap">
						<div class="member-grid blur" aria-hidden="true" id="teamUserList">
							<div class="member-card">
								<span class="avatar default"></span>
								<div class="info">
									<strong>팀원</strong>
									<p class="meta">서울 · 초급</p>
								</div>
							</div>
							<div class="member-card">
								<span class="avatar default"></span>
								<div class="info">
									<strong>팀원</strong>
									<p class="meta">서울 · 중급</p>
								</div>
							</div>
							<div class="member-card">
								<span class="avatar default"></span>
								<div class="info">
									<strong>팀원</strong>
									<p class="meta">서울 · 초급</p>
								</div>
							</div>
						</div>
						<div class="lock-msg">
							<strong>🔒 가입 후 확인할 수 있어요</strong>
							<p>이 팀에 가입하면 팀원 프로필과 역할 정보를 확인할 수 있습니다.</p>
						</div>
					</div>
				</section>
				<section class="team-section" id="posts" style="margin-top: 40px">
					<h2>팀 작성글</h2>
					<p class="section-desc">팀원에게만 공개되는 작성글입니다.</p>
					<div class="locked-wrap">
						<div class="post-grid blur" aria-hidden="true">
							<div class="post-card">
								<p class="ttl" style="margin: 0">팀 작성글</p>
								<p>일정 · 장소</p>
							</div>
							<div class="post-card">
								<p class="ttl" style="margin: 0">팀 작성글</p>
								<p>일정 · 장소</p>
							</div>
						</div>
						<div class="lock-msg">
							<strong>🔒 가입 후 확인할 수 있어요</strong>
							<p>이 팀에 가입하면 팀원 프로필과 역할 정보를 확인할 수 있습니다.</p>
						</div>
					</div>
				</section>
			</c:otherwise>
		</c:choose>
	</div>
</main>
  <c:if test="${sessionScope.user.grade eq 'Admin'}">
	<div class="modal" id="teamDeleteModal" role="dialog" aria-modal="true">
		<div class="modal-card sm">
			<h2 class="modal-title">팀을 삭제할까요?</h2>
			<p class="modal-desc">팀과 팀 작성글이 모두 삭제되며 복구할 수 없습니다.</p>
			<div class="modal-actions">
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
				<button type="button" class="btn btn-danger" data-toast="팀을 삭제했어요.">삭제</button>
			</div>
		</div>
	</div>
</c:if>
<%@ include file="/jsp/common/footer.jsp"%>
