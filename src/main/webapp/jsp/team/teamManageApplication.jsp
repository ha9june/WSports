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
<%-- <c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="default:기본|reject:거절 모달|rejectFilled:거절 사유 작성" /> --%>
<%@ include file="/jsp/common/header.jsp"%>
<main class="page">
	<div class="container">
		<%--
  팀 관리 공통 상단 (가입 신청 / 팀원 관리 / 팀 작성글 관리 탭)
   - manageTab : application | members | posts
   - infoMode  : true 면 팀원용 조회 화면(팀원 보기 / 팀 작성글 보기) 탭으로 표시
--%>
		<nav class="breadcrumb">
			<a href="${ctx}/jsp/team/teamList.jsp">팀</a><span class="sep">›</span><a
				href="${ctx}/jsp/team/teamDetail.jsp?state=${infoMode ? 'member' : 'manager'}">서울
				풋살 크루</a><span class="sep">›</span><span>${infoMode ? '팀 정보' : '관리'}</span>
		</nav>
		<div class="page-head" style="margin-bottom: 24px">
			<h1 class="page-title">${infoMode ? '서울 풋살 크루' : '팀 관리'}</h1>
			<p class="page-desc">${infoMode ? '팀원과 팀 작성글을 확인할 수 있어요.' : '가입 신청, 팀원, 팀 작성글 관리를 한 화면에서 전환합니다.'}</p>
		</div>
		<nav class="tabs">
			<c:choose>
				<c:when test="${infoMode}">
					<a class="tab ${manageTab eq 'members' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamInfoMembers.jsp">팀원</a>
					<a class="tab ${manageTab eq 'posts' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamInfoPosts.jsp">팀 작성글</a>
				</c:when>
				<c:otherwise>
					<a class="tab ${manageTab eq 'application' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamManageApplication.jsp">가입 신청</a>
					<a class="tab ${manageTab eq 'members' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamManageMembers.jsp">팀원 관리</a>
					<a class="tab ${manageTab eq 'posts' ? 'is-active' : ''}"
						href="${ctx}/jsp/team/teamManagePosts.jsp">팀 작성글 관리</a>
				</c:otherwise>
			</c:choose>
		</nav>
		<h2 class="sub-title" style="margin-bottom: 16px">가입 신청 ${applicationCnt }건</h2>
		<div class="manage-grid">
			<section>
				<%-- TODO: <c:forEach var="a" items="${applicationList}"> 승인/거절은 POST (applyNo) --%>
				<c:forEach var="a" items="${teamApplicationList }">
					<div class="apply-row">
						<span class="avatar default"></span>
							<div class="info">
								<strong><c:out value="${a.nickname}" /></strong>
								<p class="apply-meta"><c:out value="${a.preferredRegion1}" default="지역 미설정" /> · <c:out value="${a.skill}" default="실력 미설정" /></p>
								<p class="apply-msg-text"><c:out value="${a.message}" /></p>
							</div>
						<button type="button" class="btn btn-primary btn-sm"
							data-toast="${a.nickname} 님의 가입을 승인했어요.">승인</button>
						<button type="button" class="btn btn-danger btn-sm"
							data-modal-open="rejectModal">거절</button>
					</div>
				</c:forEach>
			</section>
			<aside class="status-card">
				<h3>팀 현황</h3>
				<div class="kv">
					팀원 <b>${team.currentPeople }명</b>
				</div>
				<div class="kv">
					가입 신청 <b>${applicationCnt }건</b>
				</div>
				<div class="kv">
					팀 패널티 점수 <b class="warn">2점</b>
				</div>
				<div class="kv">
					예정 매칭 <b>2건</b>
				</div>
				<a class="btn btn-outline btn-sm" href="${ctx}/team/edit">팀 정보
					수정</a>
			</aside>
		</div>
	</div>
</main>

<div
	class="modal ${state eq 'reject' or state eq 'rejectFilled' ? 'is-open' : ''}"
	id="rejectModal" role="dialog" aria-modal="true">
	<div class="modal-card">
		<h2 class="modal-title">가입 신청 거절</h2>
		<p class="modal-desc">거절 사유를 작성하면 신청자에게 함께 안내됩니다.</p>
		<div class="field modal-body">
			<label class="field-label" for="rejectReason">거절 사유</label>
			<textarea class="textarea soft" id="rejectReason" name="reason"
				rows="3" data-require-for="rejectBtn"
				placeholder="예: 현재 모집 인원이 마감되어 이번 신청은 승인하기 어렵습니다.">${state eq 'rejectFilled' ? '현재 모집 인원이 마감되어 이번 신청은 승인하기 어렵습니다.' : ''}</textarea>
		</div>
		<div class="modal-actions split">
			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
			<button type="button" class="btn btn-danger" id="rejectBtn"
				data-toast="가입 신청을 거절했어요."
				${state eq 'rejectFilled' ? '' : 'disabled'}>거절하기</button>
		</div>
	</div>
</div>
<%@ include file="/jsp/common/footer.jsp"%>
