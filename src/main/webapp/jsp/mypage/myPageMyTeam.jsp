
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
.myteam-card .left {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
    width: 70px;          /* 왼쪽 영역 폭 고정 */
}
.team-logo-wrap .left img {
    width: 170px;
    height: 100px;
    object-fit: contain;  /* 비율 유지하면서 칸에 맞춤 */
    flex-shrink: 0;
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
					<div class="myteam-card"
						style="display: flex; align-items: center; padding: 16px; border: 1px solid #e5e7eb; border-radius: 16px; background-color: #fff; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02); position: relative; height: 110px; box-sizing: border-box;">

						<div class="team-logo-wrap"
							style="width: 56px; height: 56px; border-radius: 50%; background-color: #e0e0ff; display: flex; align-items: center; justify-content: center; margin-left: 6px; margin-right: 20px; flex-shrink: 0;">
							<img
								src="${ctx}/img/sport-icon-${m.sport eq '축구/풋살' ? 'football' : (m.sport eq '농구' ? 'basketball' : (m.sport eq '테니스' ? 'tennis' : 'badminton'))}.png"
								alt=""
								style="width: 34px; height: 34px; object-fit: contain; display: block;">
						</div>

						<div class="main-info"
							style="flex: 1; min-width: 0; padding-right: 12px;">
							<strong
								style="display: block; font-size: 16px; font-weight: 700; color: #111827; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${m.teamName}</strong>
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
							style="display: flex; flex-direction: column; align-items: flex-end; justify-content: center; gap: 6px; flex-shrink: 0; width: 80px;">
							<span class="status-txt"
								style="font-size: 12px; color: #6b7280; font-weight: 500; margin-right: 4px; white-space: nowrap;">${m.status}</span>
							<button type="button" class="btn-cancel"
								data-id="${m.applicationId}"
								style="width: 100%; background-color: #fff; border: 1px solid #d1d5db; color: #1f2937; font-size: 12px; font-weight: 600; padding: 6px 0; text-align: center; border-radius: 8px; cursor: pointer; white-space: nowrap;">신청
								취소</button> 
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
					<div class="myteam-card"
						data-href="${ctx}/jsp/team/teamDetail.jsp?teamId=${m.teamId}"
						style="display: flex; align-items: center; padding: 20px; border: 1px solid #e5e7eb; border-radius: 12px; background: #fff;">
						<img
							src="${ctx}/img/team-${m.sport eq '축구/풋살' ? 'football' : (m.sport eq '농구' ? 'basketball' : 'badminton')}.png"
							alt="" style="width: 50px; height: 50px; margin-right: 16px;">

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

						<div class="aside"
							style="display: flex; flex-direction: column; align-items: flex-end; justify-content: space-between; height: 48px;">
							<span class="pill pill-neutral">${m.role eq 'MEMBER' ? '팀원' : m.role}</span>
							<div class="dropdown">
								<button type="button" class="icon-btn" data-dropdown-toggle
									aria-label="팀 메뉴">⋮</button>
								<div class="dropdown-menu">
									<a
										href="${ctx}/jsp/team/teamInfoMembers.jsp?teamId=${m.teamId}">팀원
										보기</a> <a
										href="${ctx}/jsp/team/teamInfoPosts.jsp?teamId=${m.teamId}">팀
										작성글 보기</a>
									<c:if test="${m.role ne 'MEMBER'}">
										<a
											href="${ctx}/jsp/team/teamManageApplication.jsp?teamId=${m.teamId}">팀
											관리</a>
									</c:if>
									<hr>
									<button type="button" class="danger btn-leave"
										data-team-id="${m.teamId}">탈퇴하기</button>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:otherwise>
	</c:choose>
</div>

<!-- 탈퇴 모달 -->
<div class="modal" id="leaveModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">팀에서 탈퇴할까요?</h2>
		<p class="modal-desc">탈퇴 후에는 팀 경기 신청과 팀원 전용 기능을 이용할 수 없습니다. 다시
			활동하려면 가입 신청을 다시 해야 해요.</p>
		<div class="modal-actions">
			<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
			<button type="button" class="btn btn-danger" id="confirmLeave">탈퇴</button>
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
		// 팀 탈퇴
		$('.btn-leave').on('click', function(e) {
			e.stopPropagation();
			targetId = $(this).data('team-id');
			$('#leaveModal').addClass('is-open');
		});
		$('#confirmLeave').on('click', function() {
			$.post('${ctx}/mypage/clubs/leave', {
				teamId : targetId
			}, function(res) {
				res = res.trim();
				if (res === 'ok') {
					showToast('팀에서 탈퇴했어요.');
					location.reload();
				} else if (res === 'login') {
					showToast('로그인이 필요합니다.');
				} else {
					showToast('탈퇴할 수 없어요. 팀장은 탈퇴할 수 없습니다.');
				}
			});
		});
	});
</script>
<%@ include file="/jsp/common/footer.jsp"%>