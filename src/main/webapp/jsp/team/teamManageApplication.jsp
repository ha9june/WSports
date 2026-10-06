<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  팀 관리 - 가입 신청 (teamManageApplication.jsp) - 담당: 하준수
  피그마: Club / Manage / Desktop, Club / Join Request Reject / Modal (빈 상태 · 작성 상태)
   state : default | reject(거절 사유 모달 - 비어 있음) | rejectFilled(거절 사유 작성됨)
  거절 사유를 입력해야 [거절하기] 버튼이 활성화됩니다. (team.js)
--%>
<%-- <c:set var="state" value="${empty param.state ? 'default' : param.state}" /> --%>
<c:set var="manageTab" value="application" />
<c:set var="pageTitle" value="팀 관리" />
<c:set var="pageCss" value="match,team" />
<c:set var="pageJs" value="team" />
<c:set var="activeNav" value="team" />
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container">
		<%--
  팀 관리 공통 상단 (가입 신청 / 팀원 관리 / 팀 작성글 관리 탭)
   - manageTab : application | members | posts
   - infoMode  : true 면 팀원용 조회 화면(팀원 보기 / 팀 작성글 보기) 탭으로 표시
--%>
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span>
			<a href="${ctx}/team/detail/view?teamId=${team.teamId}"><c:out value="${team.teamName}" /></a><span class="sep">›</span>
			<span>관리</span>
		</nav>
		<div class="page-head" style="margin-bottom: 24px">
			<h1 class="page-title">팀 관리</h1>
			<p class="page-desc">가입 신청, 팀원, 팀 작성글 관리를 한 화면에서 전환합니다.</p>
		</div>
		<nav class="tabs">
			<a class="tab ${manageTab eq 'application' ? 'is-active' : ''}"
				href="${ctx}/team/manage/applications?teamId=${team.teamId}">가입 신청</a>
			<a class="tab ${manageTab eq 'members' ? 'is-active' : ''}"
				href="${ctx}/team/manage/members?teamId=${team.teamId}">팀원 관리</a>
			<a class="tab ${manageTab eq 'posts' ? 'is-active' : ''}"
				href="${ctx}/team/manage/posts?teamId=${team.teamId}">팀 작성글 관리</a>
		</nav>
		<h2 class="sub-title" style="margin-bottom: 16px">가입 신청
			${applicationCnt }건</h2>
		<div class="manage-grid">
			<section>
				<%-- TODO: <c:forEach var="a" items="${applicationList}"> 승인/거절은 POST (applyNo) --%>
				<c:forEach var="a" items="${teamApplicationList }">
					<div class="apply-row">
						<div class="info">
							<div class="apply-head">
								<c:choose>
									<c:when test="${not empty a.profileImage}">
										<span class="avatar sm"><img
											src="${ctx}/uploads/${a.profileImage}" alt=""></span>
									</c:when>
									<c:otherwise>
										<span class="avatar default sm"></span>
									</c:otherwise>
								</c:choose>
								<strong><c:out value="${a.nickname}" /></strong>
							</div>
							<p class="apply-meta">
								<c:out value="${a.preferredRegion1}" default="지역 미설정" />
								·
								<c:out value="${a.skill}" default="실력 미설정" />
							</p>
							<p class="apply-msg-text"><c:out value="${a.message}" /></p>
						</div>
						<button type="button" class="btn btn-primary btn-sm"
							data-modal-open="approveModal"
							data-application-id="${a.applicationId}"
							data-nickname="<c:out value='${a.nickname}' />">승인</button>
						<button type="button" class="btn btn-danger btn-sm"
							data-modal-open="rejectModal"
							data-application-id="${a.applicationId}">거절</button>
					</div>
				</c:forEach>
			</section>
			<aside class="status-card">
				<h3>팀 현황</h3>
				<div class="kv">
					팀원 <b><c:out value="${team.currentPeople }"></c:out>명</b>
				</div>
				<div class="kv">
					가입 신청 <b><c:out value="${applicationCnt }"></c:out>건</b>
				</div>
				<div class="kv">
					팀 패널티 점수 <b class="warn"><c:out value="${teamPenaltyScore}"></c:out>점</b>
				</div>
				<div class="kv">
					예정 매칭 <b><c:out value="${expectedTeamMatchCnt }"></c:out>건</b>
				</div>
				<c:url var="editUrl" value="/team/edit">
					<c:param name="teamId" value="${team.teamId }"></c:param>
				</c:url>
				<a class="btn btn-outline btn-sm" href="${editUrl }">팀 정보
					수정</a>
			</aside>
		</div>
	</div>
</main>

<div class="modal" id="rejectModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">가입 신청 거절</h2>
		<p class="modal-desc">거절 사유를 작성하면 신청자에게 함께 안내됩니다.</p>
		<form id="rejectForm" action="${ctx}/team/application/reject" method="post">
			<input type="hidden" name="teamId" value="${team.teamId}">
			<input type="hidden" name="applicationId" id="rejectApplicationId">
			<div class="field modal-body">
				<label class="field-label" for="rejectReason">거절 사유</label>
				<textarea class="textarea soft" id="rejectReason" name="reason" rows="3"
					maxlength="200" data-require-for="rejectBtn"
					placeholder="예: 현재 모집 인원이 마감되어 이번 신청은 승인하기 어렵습니다."></textarea>
			</div>
			<div class="modal-actions split">
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
				<button type="submit" class="btn btn-danger" id="rejectBtn" disabled>거절하기</button>
			</div>
		</form>
	</div>
</div>
<div class="modal" id="approveModal" role="dialog" aria-modal="true">
	<div class="modal-card sm" style="text-align: center">
		<h2 class="modal-title">가입을 승인할까요?</h2>
		<p class="modal-desc">
			<b id="approveNickname"></b>님이 팀원으로 추가되고, 신청자에게 승인 알림이 전송돼요.
		</p>
		<form id="approveForm"
			action="${ctx}/team/application/approve" method="post">
			<input type="hidden" name="teamId" value="${team.teamId}"> <input
				type="hidden" name="applicationId" id="approveApplicationId">
			<div class="modal-actions" style="justify-content: center">
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
				<button type="submit" class="btn btn-primary" id="approveBtn">승인하기</button>
			</div>
		</form>
	</div>
</div>
<script>
	$(function() {
		$(document).on('click', '[data-modal-open="approveModal"]', function() {
			$('#approveApplicationId').val($(this).data('application-id'));
			$('#approveNickname').text($(this).data('nickname'));
		});

		$('#approveForm').on('submit', function() {
			$('#approveBtn').prop('disabled', true).text('승인 중...'); // 중복 클릭 방지
		});
	});
	
	$(document).on('click', '[data-modal-open="rejectModal"]', function () {
		$('#rejectApplicationId').val($(this).data('application-id'));
		$('#rejectReason').val('');          // 이전 입력 초기화
		$('#rejectBtn').prop('disabled', true);
	});

	$('#rejectForm').on('submit', function (e) {
		if (!$.trim($('#rejectReason').val())) { e.preventDefault(); return; }   // 공백만 입력 방지
		$('#rejectBtn').prop('disabled', true).text('처리 중...');
	});
</script>
<%@ include file="/jsp/common/footer.jsp"%>
