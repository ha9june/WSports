<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
문의 상세 (inquiryDetail.jsp) - 담당: 박우리
피그마: Inquiry / Detail / Desktop
state : answered(답변 완료) | waiting(답변 대기 - 답변 영역 대신 안내 문구)
--%>
<c:set var="state"
	value="${empty param.state ? 'answered' : param.state}" />
<c:set var="pageTitle" value="문의 상세" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="support" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="answered:답변 완료|waiting:답변 대기" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<c:set var="isDone" value="${inquiry.answer_status eq '답변완료'}" />
<%-- ※ 아래 스타일은 mypage.css 로 옮겨도 됩니다 --%>
<style>
.inq-sec {
	display: block !important;
	width: 100% !important;
	text-align: left !important;  /* 상자와 글자 모두 왼쪽으로 밀착 */
}

.inq { 
	--ink: #12151c; 
	--muted: #6b7280; 
	--line: #e6e8ec; 
	--accent: #2f5bea;
	align-items: stretch !important; 
}
/* 상단 */
.inq .page-head {
	margin-bottom: 22px;
}

.inq .page-title {
	font-size: 28px;
	font-weight: 800;
	letter-spacing: -0.02em;
	color: var(--ink);
}

.inq .page-desc {
	font-size: 15px;
	color: var(--muted);
}

/* 카드 */
.inq .detail-card {
	width: 100%;
	max-width: none;
	margin: 0;
	box-sizing: border-box;
	padding: 28px 32px 32px;
	background: #fff;
	border: 1px solid var(--line);
	border-radius: 16px;
	box-shadow: 0 2px 16px rgba(18, 21, 28, .04);
	display: flex;
	flex-direction: column;
	gap: 22px;
}

/* 제목 + 상태 */
.inq .detail-card .head {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 12px;
	margin: 0;
	padding: 0;
	border: 0;
}

.inq .detail-card .head .eyebrow {
	display: block;
	font-size: 12px;
	color: var(--muted);
	margin-bottom: 4px;
}

.inq .detail-card .head h2 {
	margin: 0;
	font-size: 21px;
	font-weight: 700;
	color: var(--ink);
	word-break: break-all;
}

.inq-badge {
	display: inline-flex;
	align-items: center;
	flex-shrink: 0;
	height: 34px;
	padding: 0 18px;
	border-radius: 999px;
	box-sizing: border-box;
	font-size: 14px;
	font-weight: 700;
	border: 1px solid transparent;
}

.inq-badge.wait {
	background: #fdeeee;
	color: #d6303a;
	border-color: #e8878b;
} /* 답변 대기 */
.inq-badge.done {
	background: #eaf0ff;
	color: #2f5bea;
	border-color: #a9bdf7;
} /* 답변 완료 */

/* 가로 정보 띠 */
.inq-info {
	display: flex;
	margin: 0;
	background: #f8f9fb;
	border: 1px solid #eef0f3;
	border-radius: 12px;
}

.inq-info .cell {
	flex: 1;
	padding: 14px 20px;
}

.inq-info .cell+.cell {
	border-left: 1px solid #e9ecf0;
}

.inq-info dt {
	margin: 0 0 4px;
	font-size: 12px;
	color: var(--muted);
}

.inq-info dd {
	margin: 0;
	font-size: 15px;
	font-weight: 700;
	color: var(--ink);
}

.inq-sec h3 {
	margin: 0 0 10px;
	font-size: 14px;
	font-weight: 700;
	color: var(--ink);
	text-align: left !important;  /* '내용' 타이틀도 왼쪽 */
}

.inq-sec .body {
	margin: 0 !important;
	padding: 18px 20px;
	min-height: 90px;
	box-sizing: border-box;
	background: #f8f9fb;          /* 연한 회색 배경 */
	border: 1px solid #eef0f3;
	border-radius: 12px;
	font-size: 15px;
	line-height: 1.7;
	color: var(--ink);
	white-space: pre-line;
	word-break: break-all;
	
	display: block !important;    /* 중앙 정렬 차단 */
	text-align: left !important;  /* 글씨 왼쪽 정렬 */
	width: 100% !important;       /* 가로로 길게 채우기 */
}

.inq-sec.answer h3 {
	color: var(--accent);
}

.inq-sec.answer .body {
	background: #f4f7ff;
	border-color: #dbe4fb;
}

.inq-sec.answer .empty {
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	min-height: 90px;
	padding: 18px;
	box-sizing: border-box;
	border: 1.5px dashed #d5d9e0;
	border-radius: 12px;
	background: #fcfcfd;
	font-size: 14px;
	line-height: 1.7;
	color: var(--muted);
}

/* 버튼 */
.inq .form-actions {
	margin: 18px 0 0;
	display: flex;
	justify-content: flex-end;
}

.inq .inq-back {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	width: auto;
	height: 42px;
	padding: 0 20px;
	border-radius: 10px;
	font-size: 14px;
	font-weight: 700;
	transition: background .15s, border-color .15s;
}

.inq .inq-back svg {
	width: 14px;
	height: 14px;
}

.inq .inq-back:hover {
	background: #f0f2f5;
	border-color: #d5d9e0;
}

@media ( max-width : 640px) {
	.inq .page-title {
		font-size: 24px;
	}
	.inq .detail-card {
		padding: 20px 18px 24px;
	}
	.inq .detail-card .head {
		flex-wrap: wrap;
	}
	.inq .detail-card .head h2 {
		font-size: 19px;
	}
	.inq-info {
		flex-direction: column;
	}
	.inq-info .cell+.cell {
		border-left: 0;
		border-top: 1px solid #e9ecf0;
	}
}
</style>

<div class="work-inner inq" style="width: 900px; max-width: 100%">
	<div class="page-head">
		<h1 class="page-title">문의 내용 상세확인</h1>
		<p class="page-desc">내 문의 내용과 처리 상태, 관리자(사이트) 답변을 확인할 수 있어요.</p>
	</div>

	<section class="detail-card">
		<div class="head">
			<div>
				<span class="eyebrow">문의 제목</span>
				<h2>
					<c:out value="${inquiry.title}" />
				</h2>
			</div>
			<span class="inq-badge ${isDone ? 'done' : 'wait'}">${isDone ? '답변 완료' : '답변 대기'}</span>
		</div>

		<dl class="inq-info">
			<div class="cell">
				<dt>접수일</dt>
				<dd>${inquiry.created_at}</dd>
			</div>
			<div class="cell">
				<dt>답변완료일</dt>
				<dd>${isDone ? inquiry.answered_at : '-'}</dd>
			</div>
		</dl>

		<div class="inq-sec">
			<h3>내용</h3>
			<p class="body"><c:out value="${inquiry.content}" /></p>
		</div>

		<div class="inq-sec answer">
			<h3>답변</h3>
			<c:choose>
				<c:when test="${isDone}">
					<p class="body"><c:out value="${inquiry.answer}" /></p>
				</c:when>
				<c:otherwise>
					<div class="empty">
						아직 답변이 등록되지 않았어요.<br>답변이 등록되면 이곳에서 확인할 수 있어요.
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</section>

	<div class="form-actions">
		<a class="btn btn-outline btn-sm inq-back" href="${ctx}/support/inquiry/list"> <svg width="16" height="16"
				viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"
				aria-hidden="true">
      <path d="M15 18l-6-6 6-6" />
    </svg> 목록으로 </a>
	</div>
</div>
</main>
</div>
<%@ include file="/jsp/common/footer.jsp"%>