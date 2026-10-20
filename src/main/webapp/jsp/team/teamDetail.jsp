<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 상세 (teamDetail.jsp) - 담당: 하준수
  state : public(비가입자) | member(팀원) | manager(주장·부주장) | applicater(승인 대기)
  레이아웃 : 왼쪽 본문(.team-main = 사진 + 탭 + 섹션) + 오른쪽 팀 카드(.team-side) 2단 고정
             → 오른쪽 카드 길이(버튼 개수)와 상관없이 탭 위치가 항상 같음
--%>
<c:set var="isMember" value="${state eq 'member' or state eq 'manager'}" />
<c:set var="pageTitle" value="${team.teamName}" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="team" />
<%@ include file="/jsp/common/header.jsp"%>
<script>
	$(function() {
		// ===== 탭 : 부드러운 이동 + 하이라이트 (주소에 #을 붙이지 않음) =====
		(function() {
			var ids = [ 'intro', 'members', 'posts' ], pinned = null;

			function headerH() {
				return parseInt(getComputedStyle(document.documentElement)
						.getPropertyValue('--header-h')) || 72;
			}
			function barBottom() { // 헤더 + 탭 바 높이
				var bar = document.querySelector('.team-tabs');
				return headerH() + (bar ? bar.offsetHeight : 42);
			}
			function setActive(id) {
				$('.team-tabs .tab').removeClass('is-active').filter(
						'[href="#' + id + '"]').addClass('is-active');
			}
			function update() {
				if (pinned)
					return; // 탭을 눌러 이동한 직후에는 누른 탭 유지
				var line = barBottom() + (window.innerHeight - barBottom())
						* 0.5; // 탭 바 아래 영역의 중간선
				var cur = ids[0];
				ids.forEach(function(id) {
					var s = document.getElementById(id);
					if (s && s.getBoundingClientRect().top <= line)
						cur = id;
				});
				var atBottom = window.innerHeight + window.scrollY >= document.documentElement.scrollHeight - 2;
				if (atBottom)
					cur = ids[ids.length - 1]; // 맨 아래면 마지막 탭
				setActive(cur);
			}

			$('.team-tabs .tab[href^="#"]').on(
					'click',
					function(e) {
						e.preventDefault(); // #members 가 주소에 붙지 않음 → 뒤로가기가 목록으로
						var id = $(this).attr('href').slice(1);
						var el = document.getElementById(id);
						if (!el)
							return;
						pinned = id;
						setActive(id);
						window.scrollTo({
							top : el.getBoundingClientRect().top
									+ window.scrollY - barBottom() - 16,
							behavior : 'smooth'
						});
					});
			$(window).on('wheel touchmove keydown', function() {
				pinned = null;
			});
			$(window).on('scroll', update);
			update();
			var target = new URLSearchParams(location.search).get('tab')
					|| location.hash.slice(1);

			function goTab() {
				if (ids.indexOf(target) < 0)
					return;
				var el = document.getElementById(target);
				if (!el)
					return;
				pinned = target;
				setActive(target);
				window.scrollTo({
					top : el.getBoundingClientRect().top + window.scrollY
							- barBottom() - 16
				});
			}

			$(window).on('load', function() {
				goTab();
				setTimeout(function() {
					goTab();
					var q = new URLSearchParams(location.search);
					q.delete('tab');
					history.replaceState(null, '', location.pathname
							+ (q.toString() ? '?' + q.toString() : ''));
				}, 300);
			});
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

		// 팀 삭제 : 관리자는 삭제 사유 필수 (사진 유무와 상관없이 항상 연결되도록 위로 이동)
		var deleteForm = document.getElementById('teamDeleteForm');
		if (deleteForm) {
			deleteForm.addEventListener('submit', function(e) {
				var r = document.getElementById('deleteReason');
				if (r && !r.value.trim()) {
					e.preventDefault();
					showToast('삭제 사유를 입력해 주세요.');
				}
			});
		}

		const images = [ '${team.activityImage1}', '${team.activityImage2}',
				'${team.activityImage3}', '${team.activityImage4}',
				'${team.activityImage5}' ].filter(function(image) {
			return image && image !== 'null';
		});

		// 활동 사진이 없으면 갤러리만 숨김 (탭·섹션은 이미 왼쪽 칼럼 안에 있음)
		if (images.length === 0) {
			$('#activePhoto').hide();
			$('.detail-grid').addClass('no-photo');
			return;
		}

		let html = '';
		let mainPhoto = '<img src="${ctx}/uploads/' + images[0] + '" alt="활동 사진">';

		images.forEach(function(image, index) {
			if (index === 0) {
				html += '<span>'
						+ '<img class="subImg" src="${ctx}/uploads/' + image + '" alt="활동 사진" style="border: 2px solid #1677ff">'
						+ '</span>';
			} else {
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
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><span><c:out value="${team.teamName}" /></span>
		</nav>
		<div class="detail-grid">
			<%-- ===== 왼쪽 본문 : 활동 사진 + 탭 + 소개글 / 팀원 / 팀 작성글 ===== --%>
			<div class="team-main">
				<div class="gallery" id="activePhoto">
					<div class="main-photo" id="mainPhoto"></div>
					<div class="thumbs" id="thumbs"></div>
				</div>

				<nav class="tabs team-tabs">
					<a class="tab is-active" href="#intro">소개글</a>
					<a class="tab ${isMember ? '' : 'locked'}" href="#members">팀원</a>
					<a class="tab ${isMember ? '' : 'locked'}" href="#posts">팀 작성글</a>
					<!-- 관리자 신고상세에서 팀신고도 상세정보 확인을 위해 신고버튼 추가 -->
					<c:if test="${state ne 'manager'}">
						<a class="btn btn-outline"
							href="${ctx}/support/report/create?targetType=team&targetNo=${team.teamId}"
							data-auth>신고</a>
					</c:if>
				</nav>

				<section class="team-section" id="intro">
					<h2>팀 소개</h2>
					<p class="intro">
						<c:out value="${team.description}" />
					</p>
				</section>

				<c:choose>
					<c:when test="${isMember}">
						<section class="team-section" id="members">
							<div class="section-head">
								<div>
									<h2>팀원 ${team.currentPeople }명</h2>
									<p class="section-desc">함께 활동 중인 팀원의 역할과 프로필을 확인할 수 있어요.</p>
								</div>
								<a class="link-more"
									href="${ctx}/team/info/members?teamId=${team.teamId}">전체보기 →</a>
							</div>
							<div class="member-grid">
								<c:forEach var="user" items="${teamUserList}" end="5">
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
									<a class="member-card"
										href="${ctx}/member/publicProfile/view?userId=${user.userId}">
										<span class="avatar"> <c:choose>
												<c:when test="${not empty user.profileImage}">
													<img
														src="${ctx}${profilePath}/<c:out value='${user.profileImage}' />"
														alt=""
														onerror="this.onerror=null;this.src='${ctx}/img/default-profile.svg';">
												</c:when>
												<c:otherwise>
													<img src="${ctx}/img/default-profile.svg" alt="">
												</c:otherwise>
											</c:choose>
										</span>
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
									</a>
								</c:forEach>
							</div>
						</section>
						<section class="team-section" id="posts">
							<div class="section-head">
								<div>
									<h2>팀 작성글</h2>
									<p class="section-desc">팀이 작성한 상대 팀 모집 글이에요.</p>
								</div>
								<a class="link-more"
									href="${ctx}/team/info/posts?teamId=${team.teamId}">전체보기 →</a>
							</div>
							<div class="post-grid">
								<c:forEach var="match" items="${teamMatchList }">
									<a class="post-card"
										href="${ctx}/team-match/detail/view?teamMatchId=${match.teamMatchId}">
										<p class="ttl">
											<c:out value="${match.title }"></c:out>
											<c:choose>
												<c:when test="${match.status eq '모집중'}">
													<c:set var="stCls" value="pill-success" />
												</c:when>
												<c:when
													test="${match.status eq '모집 마감' or match.status eq '경기 종료'}">
													<c:set var="stCls" value="pill-info" />
												</c:when>
												<c:when test="${match.status eq '경기 취소'}">
													<c:set var="stCls" value="pill-danger" />
												</c:when>
												<c:otherwise>
													<c:set var="stCls" value="pill-neutral" />
												</c:otherwise>
											</c:choose>
											<span class="pill ${stCls}"><c:out
													value="${match.status}" /></span>
										</p>
										<p>
											<c:out value="${match.matchDate }"></c:out>
											(${match.dayOfWeekKorean})
											<c:out value="${match.startTime }"></c:out>
											-
											<c:out value="${match.endTime }"></c:out>
											·
											<c:out value="${match.region }"></c:out>
										</p>
									</a>
								</c:forEach>
							</div>
						</section>
					</c:when>
					<c:otherwise>
						<section class="team-section" id="members">
							<h2>팀원</h2>
							<p class="section-desc">가입한 팀원만 확인할 수 있는 정보입니다.</p>
							<div class="locked-wrap">
								<div class="member-grid blur" aria-hidden="true" id="teamUserList">
									<div class="member-card">
										<span class="avatar"><img src="${ctx}/img/default-profile.svg" alt=""></span>
										<div class="info">
											<strong>팀원</strong>
											<p class="meta">서울 · 초급</p>
										</div>
									</div>
									<div class="member-card">
										<span class="avatar"><img src="${ctx}/img/default-profile.svg" alt=""></span>
										<div class="info">
											<strong>팀원</strong>
											<p class="meta">서울 · 중급</p>
										</div>
									</div>
									<div class="member-card">
										<span class="avatar"><img src="${ctx}/img/default-profile.svg" alt=""></span>
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
						<section class="team-section" id="posts">
							<h2>팀 작성글</h2>
							<p class="section-desc">팀원에게만 공개되는 작성글입니다.</p>
							<div class="locked-wrap">
								<div class="post-grid blur" aria-hidden="true">
									<div class="post-card">
										<p class="ttl">팀 작성글</p>
										<p>일정 · 장소</p>
									</div>
									<div class="post-card">
										<p class="ttl">팀 작성글</p>
										<p>일정 · 장소</p>
									</div>
								</div>
								<div class="lock-msg">
									<strong>🔒 가입 후 확인할 수 있어요</strong>
									<p>이 팀에 가입하면 팀 작성글을 확인할 수 있습니다.</p>
								</div>
							</div>
						</section>
					</c:otherwise>
				</c:choose>
			</div>

			<%-- ===== 오른쪽 팀 카드 ===== --%>
			<aside class="team-side">
				<div class="top">
					<span class="logo-ph" id="profileImg"></span>
					<div>
						<h1>
							<c:out value="${team.teamName}" />
						</h1>
						<p>${team.sport }·팀원${team.currentPeople }</p>
						<p class="team-rating">
							<c:choose>
								<c:when test="${team.teamRating != null}">
									<span class="rating">${team.teamRating}</span>
									<span class="t-11 t-2">(${team.teamRatingCount})</span>
								</c:when>
								<c:otherwise>
									<span class="t-11 t-2">평가 없음</span>
								</c:otherwise>
							</c:choose>
						</p>
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
					<dt>활동 요일</dt>
					<dd>${team.days }</dd>
					<dt>활동 시간대</dt>
					<dd>${team.times }</dd>
					<dt>활동 지역</dt>
					<dd>${team.regions }</dd>
				</dl>
				<c:choose>
					<c:when test="${state eq 'manager'}">
						<hr>
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
						<button type="button" class="btn btn-join btn-block" disabled>승인
							대기 중</button>
					</c:when>
					<c:otherwise>
						<hr>
						<c:url var="applyUrl" value="/team/application">
							<c:param name="teamId" value="${team.teamId}" />
						</c:url>
						<a class="btn btn-join btn-block" href="${applyUrl}" data-auth>가입
							신청하기</a>
					</c:otherwise>
				</c:choose>
				<c:if test="${sessionScope.user.grade eq 'Admin' or isCaptain}">
					<button type="button"
						class="btn btn-outline btn-danger-soft btn-block"
						data-modal-open="teamDeleteModal">팀 삭제</button>
				</c:if>
			</aside>
		</div>
	</div>
</main>
<c:if test="${sessionScope.user.grade eq 'Admin' or isCaptain}">
	<div class="modal" id="teamDeleteModal" role="dialog" aria-modal="true">
		<div class="modal-card sm">
			<h2 class="modal-title">팀을 삭제할까요?</h2>
			<p class="modal-desc">팀이 삭제되고 모든 팀원이 탈퇴 처리돼요. 복구할 수 없고, 진행 중인 경기가
				있으면 삭제할 수 없어요.</p>
			<form action="${ctx}/team/delete" method="post" id="teamDeleteForm">
				<input type="hidden" name="teamId" value="${team.teamId}">
				<c:if test="${sessionScope.user.grade eq 'Admin'}">
					<div class="field">
						<label class="field-label strong" for="deleteReason">삭제 사유
							<span class="hint">팀원 전체에게 전달돼요</span>
						</label>
						<textarea class="textarea" id="deleteReason" name="reason"
							rows="3" maxlength="100" placeholder="예: 운영 정책에 맞지 않는 팀 소개"></textarea>
					</div>
				</c:if>
				<div class="modal-actions">
					<button type="button" class="btn btn-outline" data-modal-close>취소</button>
					<button type="submit" class="btn btn-danger">삭제</button>
				</div>
			</form>
		</div>
	</div>
</c:if>
<%@ include file="/jsp/common/footer.jsp"%>
