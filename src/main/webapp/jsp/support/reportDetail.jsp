<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
신고 상세 (reportDetail.jsp) - 담당: 박우리
피그마: Report / Detail / Desktop
state : processing(처리 중) | done(처리 완료 - 처리 결과 노출)
레이아웃: 문의 상세와 같은 .mp-body + .form-card 틀 사용 (진행 단계만 신고 전용)
신고 대상: report.post_type / post_id 가 있을 때만 표시
          이름은 SupportReportDetail 에서 넘겨주는 reportTarget 사용 (작성 화면과 같은 키)
스타일: mypage.css 의 "신고·문의 작성/상세" 구역 (.inq-*, .rpt-*)
--%>
<c:set var="state" value="${empty param.state ? 'processing' : param.state}" />
<c:set var="pageTitle" value="신고 상세" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="support" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="processing:처리 중|done:처리 완료" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<c:set var="isDone" value="${report.status eq '처리완료'}" />

<%-- 신고 대상 종류 / 이름 --%>
<c:set var="targetType" value="${report.post_type}" />
<c:set var="hasTarget" value="${not empty targetType and not empty report.post_id}" />
<c:choose>
	<c:when test="${targetType eq 'user'}">
		<c:set var="targetLabel" value="회원" />
		<c:set var="targetName" value="${reportTarget.userNickname}" />
	</c:when>
	<c:when test="${targetType eq 'team'}">
		<c:set var="targetLabel" value="팀" />
		<c:set var="targetName" value="${reportTarget.teamName}" />
	</c:when>
	<c:when test="${targetType eq 'personalMatch'}">
		<c:set var="targetLabel" value="개인경기 게시글" />
		<c:set var="targetName" value="${reportTarget.personalMatchTitle}" />
	</c:when>
	<c:when test="${targetType eq 'teamMatch'}">
		<c:set var="targetLabel" value="팀경기 게시글" />
		<c:set var="targetName" value="${reportTarget.teamMatchTitle}" />
	</c:when>
	<c:when test="${targetType eq 'review'}">
		<c:set var="targetLabel" value="후기 게시글" />
		<c:set var="targetName" value="${reportTarget.reviewTitle}" />
	</c:when>
</c:choose>

<div class="work-inner mp-body inq-page">
	<h1 class="section-title">신고 상세</h1>
	<p class="section-desc">접수한 신고 내용과 처리 상태를 확인할 수 있어요.</p>

	<section class="form-card inq-card">
		<div class="inq-head">
			<div class="inq-head-text">
				<p class="inq-meta">신고 제목</p>
				<h2 class="inq-title"><c:out value="${report.title}" /></h2>
			</div>
			<span class="pill ${isDone ? 'pill-info' : 'pill-neutral'} inq-status">${isDone ? '처리 완료' : '처리 중'}</span>
		</div>

		<%-- 진행 단계 --%>
		<div class="rpt-steps">
			<div class="rpt-step done"><span class="rpt-dot"></span><span>접수</span></div>
			<div class="rpt-bar done"></div>
			<div class="rpt-step ${isDone ? 'done' : 'now'}"><span class="rpt-dot"></span><span>처리 중</span></div>
			<div class="rpt-bar ${isDone ? 'done' : ''}"></div>
			<div class="rpt-step ${isDone ? 'done' : ''}"><span class="rpt-dot"></span><span>처리 완료</span></div>
		</div>

		<%-- 신고 대상 (회원·팀·게시글에서 신고한 경우만) --%>
		<c:if test="${hasTarget}">
			<div class="field">
				<p class="field-label danger">신고 대상</p>
				<div class="inq-box rpt-target">
					<span class="rpt-target-tag">${targetLabel}</span>
					<c:choose>
						<c:when test="${not empty targetName}">
							<span class="rpt-target-name"><c:out value="${targetName}" /></span>
						</c:when>
						<c:otherwise>
							<span class="rpt-target-name is-gone">삭제되었거나 찾을 수 없는 대상이에요</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</c:if>

		<dl class="inq-info">
			<div class="cell">
				<dt>접수일</dt>
				<dd><c:out value="${report.created_at}" /></dd>
			</div>
			<div class="cell">
				<dt>처리완료일</dt>
				<dd>${isDone ? report.answered_at : '-'}</dd>
			</div>
		</dl>

		<div class="field">
			<p class="field-label">신고 내용</p>
			<div class="inq-box"><c:out value="${report.content}" /></div>
		</div>

		<div class="field">
			<p class="field-label ${isDone ? 'inq-answer-label' : ''}">처리 결과</p>
			<c:choose>
				<c:when test="${isDone}">
					<div class="inq-box answer"><c:out value="${report.answer}" /></div>
				</c:when>
				<c:otherwise>
					<div class="inq-box empty">아직 처리 결과가 등록되지 않았어요.<br>처리가 완료되면 이곳에서 확인할 수 있어요.</div>
				</c:otherwise>
			</c:choose>
		</div>
	</section>

	<div class="form-actions">
		<a class="btn btn-outline" href="${ctx}/support/report/list">
			<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M15 18l-6-6 6-6" /></svg>
			목록으로
		</a>
	</div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
