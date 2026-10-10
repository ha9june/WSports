<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 관리 - 팀원 관리 (teamManageMembers.jsp) - 담당: 하준수
  피그마: Club / Manage / Members, Club / Manage / Members — 역할 관리 흐름
          (Vice Captain Grant / Vice Revoked Toast / Member Kick / Member Action Menu / Inline Profile Hover)
   state : default | vice(부팀장 지정 모달) | viceRevoked(해제 완료 토스트) | kick(강퇴 모달)
  닉네임에 마우스를 올리면 프로필 호버 카드, ⋮ 메뉴로 역할 변경·강퇴
--%>
<c:set var="state"
	value="${empty param.state ? 'default' : param.state}" />
<c:set var="manageTab" value="members" />
<c:set var="pageTitle" value="팀원 관리" />
<c:set var="pageCss" value="match,team" />
<c:set var="pageJs" value="team" />
<c:set var="activeNav" value="team" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates"
	value="default:기본|vice:부팀장 지정 모달|viceRevoked:부팀장 해제 토스트|kick:강퇴 모달" />
<%@ include file="/jsp/common/header.jsp"%>
<script type="text/javascript">
	$(function() {
		// ⋮ 메뉴에서 대상 팀원을 고르면, 열리는 모달의 hidden userId를 채움
		$(document).on(
				'click',
				'[data-modal-open]',
				function() {
					var modalId = $(this).data('modal-open');
					$('#' + modalId + ' input[name=userId]').val(
							$(this).data('user-id'));
				});
	});
</script>
<main class="page">
	<div class="container">
		<%--
  팀 관리 공통 상단 (가입 신청 / 팀원 관리 / 팀 작성글 관리 탭)
   - manageTab : application | members | posts
   - infoMode  : true 면 팀원용 조회 화면(팀원 보기 / 팀 작성글 보기) 탭으로 표시
--%>
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span><a
				href="${ctx}/team/detail/view?teamId=${teamId}">${team.teamName }</a><span
				class="sep">›</span><span>관리</span>
		</nav>
		<div class="page-head" style="margin-bottom: 24px">
			<h1 class="page-title">팀 관리</h1>
			<p class="page-desc">가입 신청, 팀원, 팀 작성글 관리를 한 화면에서 전환합니다.</p>
		</div>
		<nav class="tabs">
			<a class="tab ${manageTab eq 'application' ? 'is-active' : ''}"
				href="${ctx}/team/manage/applications?teamId=${teamId}">가입 신청</a> <a
				class="tab ${manageTab eq 'members' ? 'is-active' : ''}"
				href="${ctx}/team/manage/members?teamId=${teamId}">팀원 관리</a> <a
				class="tab ${manageTab eq 'posts' ? 'is-active' : ''}"
				href="${ctx}/team/manage/posts?teamId=${teamId}">팀 작성글 관리</a>
		</nav>
		<h2 class="sub-title">팀원 ${team.currentPeople }명</h2>
		<p class="section-desc" style="margin-bottom: 24px">팀원의 역할을 확인하고
			관리할 수 있어요.</p>
		<%-- TODO: <c:forEach var="m" items="${memberList}"> 팀장 본인은 메뉴 없음 --%>
		<div class="member-grid">
			<c:forEach var="m" items="${userList}">
				<div class="member-card">
					<c:choose>
						<c:when test="${not empty m.profileImage}">
							<span class="avatar"><img
								src="${ctx}/uploads/${m.profileImage}" alt=""></span>
						</c:when>
						<c:otherwise>
							<span class="avatar"><img
								src="${ctx}/img/default-profile.svg" alt=""></span>
						</c:otherwise>
					</c:choose>
					<div class="info">
						<strong><c:out value="${m.nickname}" /></strong>
						<c:if test="${m.teamRole eq 'CAPTAIN'}">
							<span class="pill pill-brand role">주장</span>
						</c:if>
						<c:if test="${m.teamRole eq 'VICE_CAPTAIN'}">
							<span class="pill pill-brand role">부주장</span>
						</c:if>
						<p class="meta">
							<c:out
								value="${empty m.preferredRegion1 ? '지역 미설정' : m.preferredRegion1}" />
							·
							<c:choose>
								<c:when test="${team.sport eq '축구/풋살'}">
									<c:out
										value="${empty m.soccerSkill ? '실력 미설정' : m.soccerSkill}" />
								</c:when>
								<c:when test="${team.sport eq '농구'}">
									<c:out
										value="${empty m.basketballSkill ? '실력 미설정' : m.basketballSkill}" />
								</c:when>
								<c:when test="${team.sport eq '테니스'}">
									<c:out
										value="${empty m.tennisSkill ? '실력 미설정' : m.tennisSkill}" />
								</c:when>
								<c:when test="${team.sport eq '배드민턴'}">
									<c:out
										value="${empty m.badmintonSkill ? '실력 미설정' : m.badmintonSkill}" />
								</c:when>
								<c:otherwise>실력 미설정</c:otherwise>
							</c:choose>
						</p>
					</div>

					<%-- 팀장 카드에는 메뉴 없음 --%>
					<c:if test="${m.teamRole ne 'CAPTAIN'}">
						<div class="dropdown">
							<button type="button" class="icon-btn" data-dropdown-toggle
								aria-label="팀원 메뉴">⋮</button>
							<div class="dropdown-menu">
								<%-- 부팀장 지정/해제는 로그인한 사람이 팀장일 때만 --%>
								<c:if test="${teamRole eq 'CAPTAIN'}">
									<c:choose>
										<c:when test="${m.teamRole eq 'VICE_CAPTAIN'}">
											<button type="button" data-member-name="${m.nickname}"
												data-user-id="${m.userId}" data-modal-open="viceRevokeModal">부팀장
												해제</button>
										</c:when>
										<c:otherwise>
											<button type="button" data-member-name="${m.nickname}"
												data-user-id="${m.userId}" data-modal-open="viceModal">부팀장으로
												지정</button>
										</c:otherwise>
									</c:choose>
									<hr>
								</c:if>
								<button type="button" class="danger"
									data-member-name="${m.nickname}" data-user-id="${m.userId}"
									data-modal-open="kickModal">강퇴하기</button>
							</div>
						</div>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>
</main>

<c:choose>
	<c:when test="${param.result eq 'vice'}">
		<script>
			document.addEventListener('DOMContentLoaded', function() {
				showToast('부팀장으로 지정했어요.');
			});
		</script>
	</c:when>
	<c:when test="${param.result eq 'revoke'}">
		<script>
			document.addEventListener('DOMContentLoaded', function() {
				showToast('부팀장 권한을 해제했어요.');
			});
		</script>
	</c:when>
	<c:when test="${param.result eq 'kick'}">
		<script>
			document.addEventListener('DOMContentLoaded', function() {
				showToast('팀원을 강퇴했어요.');
			});
		</script>
	</c:when>
</c:choose>

<%-- 부팀장 지정 --%>
<div class="modal ${state eq 'vice' ? 'is-open' : ''}" id="viceModal"
	role="dialog" aria-modal="true">
	<form method="post" action="${ctx}/team/member/role-update">
		<input type="hidden" name="teamId" value="${teamId}"> <input
			type="hidden" name="userId" value=""> <input type="hidden"
			name="role" value="VICE_CAPTAIN">
		<div class="modal-card">
			<h2 class="modal-title">
				<span data-fill-name>풋살초보</span> 님을 부팀장으로 지정할까요?
			</h2>
			<p class="modal-desc">부팀장은 팀장과 함께 팀 운영 권한을 갖게 됩니다. 권한은 팀원 관리에서
				언제든 해제할 수 있습니다.</p>
			<div class="modal-actions">
				<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
				<button type="submit" class="btn btn-primary">지정</button>
			</div>
		</div>
	</form>
</div>

<%-- 부팀장 해제 --%>
<div class="modal" id="viceRevokeModal" role="dialog" aria-modal="true">
	<form method="post" action="${ctx}/team/member/role-update">
		<input type="hidden" name="teamId" value="${teamId}"> <input
			type="hidden" name="userId" value=""> <input type="hidden"
			name="role" value="MEMBER">
		<div class="modal-card">
			<h2 class="modal-title">
				<span data-fill-name>운동하자</span> 님의 부팀장 권한을 해제할까요?
			</h2>
			<p class="modal-desc">해제하면 일반 팀원으로 변경되고 팀 관리 메뉴를 사용할 수 없습니다.</p>
			<div class="modal-actions">
				<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
				<button type="submit" class="btn btn-primary">해제</button>
			</div>
		</div>
	</form>
</div>

<%-- 강퇴 (별도 엔드포인트) --%>
<div class="modal ${state eq 'kick' ? 'is-open' : ''}" id="kickModal"
	role="dialog" aria-modal="true">
	<form method="post" action="${ctx}/team/member/kick">
		<input type="hidden" name="teamId" value="${teamId}"> <input
			type="hidden" name="userId" value="">
		<div class="modal-card">
			<h2 class="modal-title">
				<span data-fill-name>공차는날</span> 님을 강퇴할까요?
			</h2>
			<p class="modal-desc">강퇴된 팀원은 팀 경기와 팀원 전용 정보에 접근할 수 없습니다. 이 작업은
				되돌릴 수 없어요.</p>
			<div class="modal-actions">
				<button type="button" class="btn btn-outline" data-modal-close>닫기</button>
				<button type="submit" class="btn btn-danger">강퇴</button>
			</div>
		</div>
	</form>
</div>
<c:if test="${state eq 'viceRevoked'}">
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			showToast('운동하자 님의 부팀장 권한을 해제했어요.');
		});
	</script>
</c:if>
<%@ include file="/jsp/common/footer.jsp"%>
