<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  내 팀 (myPageMyTeam.jsp) - 담당: 강신우
  state : joined(가입한 팀) | applications(가입 신청 현황)
--%>
<c:set var="state" value="${empty param.state ? 'joined' : param.state}" />
<c:set var="pageTitle" value="내 팀" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="myTeam" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates"
	value="joined:가입한 팀|applications:가입 신청|leave:탈퇴 모달" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<style>
.btn-cancel-apply:hover {
	background-color: #fef2f2 !important; /* 연한 빨간색 배경 */
	border-color: #fca5a5 !important; /* 빨간색 테두리 */
	color: #ef4444 !important; /* 진한 빨간색 글자 */
}

.role-pill.pill-blue {
	color: #1a6bff !important;
	background-color: #eff6ff !important; /* 연한 파란색 배경 */
	background: #eff6ff !important;
	border: none !important; /* 테두리 제거 */
	font-weight: 600 !important;
	padding: 4px 12px !important;
	/* 왼쪽 이미지 여백 적용 */
	border-radius: 9999px !important;
	display: inline-block !important;
	padding: 4px 12px !important; /* 왼쪽 이미지 여백 적용 */
	border-radius: 9999px !important;
	display: inline-block !important;
	font-size: 12px !important;
}

.myteam-card {
	position: relative;
}

.card-right {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	gap: 14px; /* 알약과 ⋮ 사이 간격 */
	flex-shrink: 0;
	min-width: 56px; /* 팀장/부팀장/팀원 알약 폭이 달라도 ⋮ 위치 고정 */
	margin-left: 12px;
}

/* 2. 기존의 회색 배경(background: #f3f4f6) 속성들을 전부 삭제하여 겉도는 회색을 제거했습니다 */
.card-right .role-pill {
	font-size: 11px;
	font-weight: 700;
	white-space: nowrap;
}

.dropdown {
	position: relative;
}

.role-badge {
	display: inline-block;
	margin-left: 6px;
	padding: 2px 8px;
	border-radius: 999px;
	font-size: 11px;
	font-weight: 700;
	vertical-align: middle;
}

.role-badge.leader {
	background: #fff1e6;
	color: #e0600f;
}

.role-badge.sub {
	background: #e8f0ff;
	color: #1a6bff;
}

/* 3. 여기에서도 겉돌던 회색 배경 속성을 제거했습니다 */
.dropdown .role-pill {
	font-size: 11px;
	font-weight: 700;
	white-space: nowrap;
}

.dropdown .icon-btn {
	width: 32px;
	height: 32px;
	border: 0;
	background: transparent;
	font-size: 20px;
	line-height: 1;
	cursor: pointer;
	border-radius: 8px;
}

.dropdown .icon-btn:hover {
	background: #f3f4f6;
}

/* 기본은 숨김 */
.dropdown .kebab-menu {
	display: none;
	position: absolute;
	top: 100%;
	right: 0;
	z-index: 20;
	min-width: 160px;
	padding: 8px 0;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-radius: 12px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

/* 열렸을 때만 표시 */
.dropdown.is-open .kebab-menu {
	display: block;
}

.dropdown .kebab-menu a {
	display: block;
	padding: 10px 16px;
	font-size: 14px;
	color: #111827;
	text-decoration: none;
}

.dropdown .kebab-menu a:hover {
	background: #f3f4f6;
}

.dropdown .kebab-menu a.danger {
	color: #ef4444;
}

.dropdown .kebab-menu hr {
	margin: 6px 0;
	border: 0;
	border-top: 1px solid #e5e7eb;
}

.sport-circle {
	width: 64px;
	height: 64px;
	margin-right: 16px;
	flex-shrink: 0;
	background: none !important;
	border-radius: 0;
	display: block;
}

.sport-circle img {
	width: 100%;
	height: 100%;
	object-fit: contain;
	display: block;
}

.sc-football {
	background-color: #dcf5e7;
}

.sc-basketball {
	background-color: #ffe3d1;
}

.sc-tennis {
	background-color: #dbeafe;
}

.sc-badminton {
	background-color: #e6e0ff;
}

.sc-default {
	background-color: #e5e7eb;
}
</style>

<div class="work-inner" style="width: 100%; max-width: 1000px;">
	<h1 class="section-title">내 팀</h1>
	<p class="section-desc">${state eq 'applications' ? '가입 신청 현황을 확인하고 대기 중인 신청을 취소할 수 있어요.' : '가입한 팀을 확인하고 팀별 역할에 따라 관리하세요.'}</p>

	<!-- 상단 탭 -->
	<div class="seg"
		style="margin-bottom: 20px; display: flex; justify-content: flex-start; gap: 12px; width: max-content; padding-left: 0 !important; margin-left: 0 !important;">
		<a class="seg-item ${state ne 'applications' ? 'is-active' : ''}"
			href="?state=joined">가입한 팀</a> <a
			class="seg-item ${state eq 'applications' ? 'is-active' : ''}"
			href="?state=applications">가입 신청</a>
	</div>

	<c:choose>
		<%-- ① 가입 신청 탭 --%>
		<c:when test="${state eq 'applications'}">
			<div class="myteam-grid"
				style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; width: 100%;">
				<c:if test="${empty match}">
					<p
						style="grid-column: span 2; text-align: center; color: #9ca3af; padding: 40px 0;">신청
						중인 팀이 없습니다.</p>
				</c:if>
				<c:forEach var="m" items="${match}">
					<c:choose>
						<c:when test="${m.sport eq '축구/풋살'}">
							<c:set var="sportCls" value="sc-football" />
							<c:set var="sportImg" value="team-football.png" />
						</c:when>
						<c:when test="${m.sport eq '농구'}">
							<c:set var="sportCls" value="sc-basketball" />
							<c:set var="sportImg" value="team-basketball.png" />
						</c:when>
						<c:when test="${m.sport eq '테니스'}">
							<c:set var="sportCls" value="sc-tennis" />
							<c:set var="sportImg" value="team-tennis.png" />
						</c:when>
						<c:when test="${m.sport eq '배드민턴'}">
							<c:set var="sportCls" value="sc-badminton" />
							<c:set var="sportImg" value="team-badminton.png" />
						</c:when>
						<c:otherwise>
							<c:set var="sportCls" value="sc-default" />
							<c:set var="sportImg" value="match-default.png" />
						</c:otherwise>
					</c:choose>

					<div class="myteam-card"
						style="display: flex; align-items: center; padding: 16px; border: 1px solid #e5e7eb; border-radius: 16px; background-color: #fff; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02); position: relative; height: 110px; box-sizing: border-box;">

						<div class="sport-circle ${sportCls}">
							<img src="${ctx}/img/${sportImg}" alt="${m.sport}">
						</div>

						<div class="main-info"
							style="flex: 1; min-width: 0; padding-right: 12px;">
							<strong
								style="display: block; font-size: 16px; margin-bottom: 4px;">
								${m.teamName} <c:choose>
									<c:when test="${m.myRole eq 'LEADER'}">
										<span class="role-badge leader">주장</span>
									</c:when>
									<c:when test="${m.myRole eq 'SUB_LEADER'}">
										<span class="role-badge sub">부주장</span>
									</c:when>
								</c:choose>
							</strong>
							<p class="meta"
								style="font-size: 13px; color: #6b7280; margin: 0 0 6px 0; font-weight: 500; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${m.sport}
								· 가입 신청</p>
							<p class="sub"
								style="display: flex; gap: 6px; margin: 0; font-size: 12px; color: #9ca3af; align-items: center; font-weight: 500; white-space: nowrap;">
								<img src="${ctx}/img/icon-calendar-14.svg" alt=""
									style="width: 12px; height: 12px; opacity: 0.4;"> <span>${m.appliedAt}</span>
							</p>
						</div>
						<div class="aside-info"
							style="display: flex; flex-direction: column; align-items: center; justify-content: space-between; flex-shrink: 0; width: auto; margin-left: auto; height: 72px; margin-top: 4px; box-sizing: border-box; padding-right: 4px;">

							<span class="status-txt"
								style="display: inline-block; font-size: 11px; color: #4b5563; background-color: #f3f4f6; font-weight: 700; padding: 3px 10px; border-radius: 9999px; white-space: nowrap; line-height: 1.2; text-align: center; min-width: 56px;">
								${m.status} </span>

							<button type="button" class="btn-cancel btn-cancel-apply"
								data-id="${m.applicationId}"
								style="display: inline-block; width: auto; min-width: 80px; background-color: #fff; border: 1px solid #d1d5db; color: #1f2937; font-size: 12px; font-weight: 600; padding: 6px 14px; text-align: center; border-radius: 8px; cursor: pointer; white-space: nowrap; transition: all 0.2s ease;">
								신청 취소</button>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:when>

		<%-- ② 가입한 팀 탭 --%>
		<c:otherwise>
			<div class="myteam-grid"
				style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; width: 100%;">
				<c:if test="${empty match}">
					<p
						style="grid-column: span 2; text-align: center; color: #9ca3af; padding: 40px 0;">가입한
						팀이 없습니다.</p>
				</c:if>
				<c:forEach var="m" items="${match}">
					<c:choose>
						<c:when test="${m.sport eq '축구/풋살'}">
							<c:set var="sportCls" value="sc-football" />
							<c:set var="sportImg" value="team-football.png" />
						</c:when>
						<c:when test="${m.sport eq '농구'}">
							<c:set var="sportCls" value="sc-basketball" />
							<c:set var="sportImg" value="team-basketball.png" />
						</c:when>
						<c:when test="${m.sport eq '테니스'}">
							<c:set var="sportCls" value="sc-tennis" />
							<c:set var="sportImg" value="team-tennis.png" />
						</c:when>
						<c:when test="${m.sport eq '배드민턴'}">
							<c:set var="sportCls" value="sc-badminton" />
							<c:set var="sportImg" value="team-badminton.png" />
						</c:when>
						<c:otherwise>
							<c:set var="sportCls" value="sc-default" />
							<c:set var="sportImg" value="match-default.png" />
						</c:otherwise>
					</c:choose>

					<div class="myteam-card"
						data-href="${ctx}/team/detail/view?teamId=${m.teamId}"
						style="display: flex; align-items: center; padding: 20px; border: 1px solid #e5e7eb; border-radius: 12px; background: #fff;">

						<div class="sport-circle ${sportCls}">
							<img src="${ctx}/img/${sportImg}" alt="${m.sport}">
						</div>

						<div class="main" style="flex: 1;">
							<strong
								style="display: block; font-size: 16px; margin-bottom: 4px;">${m.teamName}</strong>
							<p class="meta"
								style="font-size: 13px; color: #666; margin-bottom: 6px; display: flex; gap: 8px;">
								<span>${m.sport}</span> <span>${m.region}</span>
							</p>
							<p class="sub" style="margin: 0; font-size: 12px; color: #888;">가입일
								${m.appliedAt}</p>
						</div>

						<%-- 기존에 예쁘게 나오던 가입한 팀 레이아웃은 일절 건드리지 않고 그대로 유지합니다 --%>
						<div class="card-right" onclick="event.stopPropagation()">
							<c:if test="${not empty m.myRole}">
								<c:choose>
									<c:when test="${m.myRole eq 'CAPTAIN' or m.myRole eq 'LEADER'}">
										<span class="role-pill pill-blue">주장</span>
									</c:when>
									<c:when
										test="${m.myRole eq 'VICE_CAPTAIN' or m.myRole eq 'SUB_LEADER'}">
										<span class="role-pill pill-blue">부주장</span>
									</c:when>
								</c:choose>
							</c:if>

							<div class="dropdown">
								<button type="button" class="icon-btn" data-dropdown-toggle
									aria-label="메뉴">⋮</button>
								<div class="kebab-menu">
									<c:choose>
										<c:when test="${m.myRole eq 'CAPTAIN'}">
											<a href="${ctx}/team/manage?teamId=${m.teamId}&tab=apply">가입신청
												관리</a>
											<a href="${ctx}/team/manage?teamId=${m.teamId}&tab=member">팀원
												관리</a>
											<a href="${ctx}/team/manage?teamId=${m.teamId}&tab=post">팀
												작성글 관리</a>
										</c:when>
										<c:when test="${m.myRole eq 'VICE_CAPTAIN'}">
											<a href="${ctx}/team/manage?teamId=${m.teamId}&tab=apply">가입신청
												관리</a>
											<a href="${ctx}/team/manage?teamId=${m.teamId}&tab=member">팀원
												관리</a>
											<a href="${ctx}/team/manage?teamId=${m.teamId}&tab=post">팀
												작성글 관리</a>
											<hr>
											<a href="#" class="danger btn-leave"
												data-team-id="${m.teamId}">탈퇴하기</a>
										</c:when>
										<c:otherwise>
											<a href="${ctx}/team/members?teamId=${m.teamId}">팀원 보기</a>
											<a href="${ctx}/team/posts?teamId=${m.teamId}">팀 작성글 보기</a>
											<hr>
											<a href="#" class="danger btn-leave"
												data-team-id="${m.teamId}">탈퇴하기</a>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>

	<!-- 탈퇴 모달 -->
	<div class="modal" id="leaveModal" role="dialog" aria-modal="true">
		<div class="modal-card">
			<h2 class="modal-title">팀에서 탈퇴할까요?</h2>
			<p class="modal-desc">탈퇴 후에는 팀 경기 신청과 팀원 전용 기능을 이용할 수 없습니다. 다시
				활동하려면 가입 신청을 다시 해야 해요.</p>
			<input type="hidden" id="leaveTeamId">
			<div class="modal-actions">
				<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
				<button type="button" class="btn btn-danger" id="confirmLeave">탈퇴</button>
			</div>
		</div>
	</div>
</div>
<!-- 신청 취소 모달 -->
<div class="modal" id="cancelApplyModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">가입 신청을 취소할까요?</h2>
		<p class="modal-desc">취소한 신청은 되돌릴 수 없어요. 다시 가입하려면 새로 신청해야 합니다.</p>
		<div class="modal-actions">
			<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
			<button type="button" class="btn btn-danger" id="confirmCancel">신청
				취소</button>
		</div>
	</div>
</div>

<script>
	$(function() {
		var targetId = null;

		// 드롭다운 토글
		$('[data-dropdown-toggle]').on('click', function(e) {
			e.stopPropagation();
			var $dd = $(this).closest('.dropdown');
			$('.dropdown').not($dd).removeClass('is-open');
			$dd.toggleClass('is-open');
		});
		$(document).on('click', function() {
			$('.dropdown').removeClass('is-open');
		});

		// 신청 취소
		$('.btn-cancel').on('click', function(e) {
			e.stopPropagation();
			targetId = $(this).data('id');
			$('#cancelApplyModal').addClass('is-open');
		});
		$('#confirmCancel').on('click', function() {
			$.post('${ctx}/mypage/clubs', {
				action : 'cancel',
				applicationId : targetId
			}, function(res) {
				res = res.trim();
				if (res === 'ok') {
					showToast('가입 신청을 취소했어요.');
					location.reload();
				} else if (res === 'login') {
					showToast('로그인이 필요합니다.');
				} else {
					showToast('취소할 수 없는 신청이에요.');
				}
			});
		});

		// 팀 탈퇴: 메뉴의 "팀 탈퇴" 클릭 시 모달 열기
		$(document).on('click', '.btn-leave', function(e) {
			e.stopPropagation();
			$('#leaveTeamId').val($(this).data('team-id'));
			$('#leaveModal').addClass('is-open');
		});

		// 팀 탈퇴: 모달의 "탈퇴" 확정
		$('#confirmLeave').on('click', function() {
			$.post('${ctx}/mypage/clubs', {
				action : 'leave',
				teamId : $('#leaveTeamId').val()
			}, function(res) {
				res = res.trim();
				if (res === 'ok') {
					showToast('팀에서 탈퇴했어요.');
					location.reload();
				} else if (res === 'login') {
					location.href = '${ctx}/login';
				} else {
					showToast('탈퇴 처리에 실패했어요.');
				}
			});
		});
	});
</script>
<%@ include file="/jsp/common/footer.jsp"%>