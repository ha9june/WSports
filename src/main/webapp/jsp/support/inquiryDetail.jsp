<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
문의 상세 (inquiryDetail.jsp) - 담당: 박우리
피그마: Inquiry / Detail / Desktop
레이아웃: 문의 목록·작성과 같은 .mp-body 틀 사용 (폭·제목·설명·카드 통일)
상태 색: 목록과 동일 (답변 대기 = pill-neutral / 답변 완료 = pill-success)
스타일: mypage.css 의 "신고·문의 작성/상세" 구역 (.inq-*)
--%>
<c:set var="pageTitle" value="문의 상세" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="support" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="answered:답변 완료|waiting:답변 대기" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<c:set var="isDone" value="${inquiry.answer_status eq '답변완료'}" />

<div class="work-inner mp-body inq-page">
	<h1 class="section-title">문의 상세</h1>
	<p class="section-desc">내 문의 내용과 처리 상태, 관리자 답변을 확인할 수 있어요.</p>

	<section class="form-card inq-card">
		<div class="inq-head">
			<div class="inq-head-text">
				<p class="inq-meta">문의 제목</p>
				<h2 class="inq-title"><c:out value="${inquiry.title}" /></h2>
			</div>
			<span class="pill ${isDone ? 'pill-success' : 'pill-neutral'} inq-status">${isDone ? '답변 완료' : '답변 대기'}</span>
		</div>

		<dl class="inq-info">
			<div class="cell">
				<dt>접수일</dt>
				<dd><c:out value="${inquiry.created_at}" /></dd>
			</div>
			<div class="cell">
				<dt>답변완료일</dt>
				<dd>${isDone ? inquiry.answered_at : '-'}</dd>
			</div>
		</dl>

		<div class="field">
			<p class="field-label">문의 내용</p>
			<div class="inq-box"><c:out value="${inquiry.content}" /></div>
		</div>

		<div class="field">
			<p class="field-label ${isDone ? 'inq-answer-label' : ''}">문의 답변</p>
			<c:choose>
				<c:when test="${isDone}">
					<div class="inq-box answer"><c:out value="${inquiry.answer}" /></div>
				</c:when>
				<c:otherwise>
					<div class="inq-box empty">아직 답변이 등록되지 않았어요.<br>답변이 등록되면 이곳에서 확인할 수 있어요.</div>
				</c:otherwise>
			</c:choose>
		</div>
	</section>

	<div class="form-actions">
		<a class="btn btn-outline" href="${ctx}/support/inquiry/list">
			<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M15 18l-6-6 6-6" /></svg>
			목록으로
		</a>
	</div>
</div>
</main>
</div>
<%@ include file="/jsp/common/footer.jsp"%>
