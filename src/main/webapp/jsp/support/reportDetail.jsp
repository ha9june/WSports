<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
신고 상세 (reportDetail.jsp) - 담당: 박우리
피그마: Report / Detail / Desktop
state : processing(처리 중) | done(처리 완료 - 처리 결과 노출)
--%>
<c:set var="state" value="${empty param.state ? 'processing' : param.state}" />
<c:set var="pageTitle" value="신고 상세" />
<c:set var="pageCss" value="mypage" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="processing:처리 중|done:처리 완료" />
<%@ include file="/jsp/common/header.jsp" %>

<%-- 처리 완료 여부 / 진행 단계 (2: 처리 중, 3: 처리 완료) --%>
<c:set var="isDone" value="${report.status eq '처리완료'}" />
<c:set var="step" value="${isDone ? 3 : 2}" />

<%-- ※ 아래 스타일은 mypage.css 로 옮겨도 됩니다 --%>
<style>
  .rpt { --accent:#2f5bea; --ink:#12151c; --muted:#6b7280; --line:#e6e8ec; }

  /* 상단 */
  .rpt .page-head { margin-bottom: 28px; }
  .rpt .page-title { font-size: 32px; font-weight: 800; letter-spacing: -0.02em; color: var(--ink); }
  .rpt .page-desc { color: var(--muted); }

  /* 카드 */
  .rpt .detail-card {
    width: 100%; max-width: 840px; box-sizing: border-box; padding: 0; overflow: hidden;
    background: #fff; border: 1px solid var(--line); border-radius: 20px;
    box-shadow: 0 4px 24px rgba(18,21,28,.05);
  }
  .rpt .detail-card .head {
    display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between;
    gap: 12px; padding: 28px 32px 20px; margin: 0; border: 0;
  }
  .rpt .detail-card .head .eyebrow { display: block; font-size: 13px; color: var(--muted); margin-bottom: 6px; }
  .rpt .detail-card .head h2 { margin: 0; font-size: 22px; font-weight: 700; color: var(--ink); word-break: break-all; }

  /* 상태 뱃지 */
  .rpt-badge {
    display: inline-flex; align-items: center; gap: 8px; flex-shrink: 0;
    height: 34px; padding: 0 14px; border-radius: 999px; font-size: 14px; font-weight: 700;
  }
.rpt-badge.ing  { background:#fdeeee; color:#d6303a; border-color:#e8878b; }
.rpt-badge.done { background:#e3f6ea; color:#17673a; border-color:#9fd8b3; } 

  /* 진행 단계 */
  .rpt-steps { display:flex; align-items:center; gap:12px; padding: 0 32px 28px; }
  .rpt-step { display:flex; align-items:center; gap:8px; font-size:14px; color:var(--muted); white-space:nowrap; }
  .rpt-dot {
    width:28px; height:28px; border-radius:50%; box-sizing:border-box;
    border:2px solid #d5d9e0; background:#fff; display:flex; align-items:center; justify-content:center;
  }
  .rpt-step.done .rpt-dot { background:var(--accent); border-color:var(--accent); }
  .rpt-step.done .rpt-dot::after {
    content:""; width:6px; height:11px; border:solid #fff; border-width:0 2px 2px 0;
    transform: translateY(-1px) rotate(45deg);
  }
  .rpt-step.now { color:var(--ink); font-weight:700; }
  .rpt-step.now .rpt-dot { border-color:var(--accent); }
  .rpt-step.now .rpt-dot::after { content:""; width:10px; height:10px; border-radius:50%; background:var(--accent); }
  .rpt-bar { flex:1; min-width:16px; height:2px; background:#e3e6eb; }
  .rpt-bar.done { background:var(--accent); }

  /* 본문 */
  .rpt-body { border-top:1px solid var(--line); padding: 28px 32px 32px; display:flex; flex-direction:column; gap:24px; }
  .rpt .kv { display:flex; flex-wrap:wrap; gap: 12px 40px; margin:0; }
  .rpt .kv .item { display:flex; align-items:center; gap:16px; }
  .rpt .kv dt { font-size:14px; color:var(--muted); margin:0; }
  .rpt .kv dd { font-size:15px; font-weight:700; color:var(--ink); margin:0; }
  .rpt-sec h3 { margin: 0 0 10px; font-size:14px; font-weight:700; color:var(--ink); }
  .rpt-sec .body {
    margin:0; padding:20px; min-height:80px; box-sizing:border-box;
    background:#f8f9fb; border:1px solid #eef0f3; border-radius:12px;
    font-size:15px; line-height:1.7; color:var(--ink);
    white-space:pre-wrap; word-break:break-all;
  }
  .rpt-sec.result .body { background:#f1faf4; border-color:#d3eedc; }
  .rpt-sec.result h3 { color:#17673a; }

  /* 버튼 */
  .rpt .rpt-back {
    display:inline-flex; align-items:center; gap:8px; width:auto; height:48px; padding:0 22px;
    border-radius:12px; font-size:15px; font-weight:700; transition: background .15s, border-color .15s;
  }
  .rpt .rpt-back:hover { background:#f0f2f5; border-color:#d5d9e0; }

  @media (max-width:560px) {
    .rpt .page-title { font-size:26px; }
    .rpt .detail-card .head, .rpt-body { padding-left:20px; padding-right:20px; }
    .rpt-steps { padding: 0 20px 24px; gap:8px; }
    .rpt-step { font-size:13px; }
  }
</style>

<main class="page">
<div class="container rpt">
<nav class="breadcrumb"><a href="${ctx}/member/mypage/view">마이페이지</a><span class="sep">›</span><a href="${ctx}/support/report/list">이용지원</a><span class="sep">›</span><span>신고 상세</span></nav>
<div class="page-head"><h1 class="page-title">신고 상세</h1><p class="page-desc">접수한 신고 내용과 처리 상태를 확인합니다.</p></div>

<section class="detail-card">
  <div class="head">
    <div>
      <span class="eyebrow">신고 제목</span>
      <h2><c:out value="${report.title}"/></h2>
    </div>
    <span class="rpt-badge ${isDone ? 'done' : 'ing'}">${isDone ? '처리 완료' : '처리중'}</span>
  </div>

  <%-- 진행 단계 --%>
  <div class="rpt-steps">
    <div class="rpt-step done"><span class="rpt-dot"></span><span>접수</span></div>
    <div class="rpt-bar done"></div>
    <div class="rpt-step ${isDone ? 'done' : 'now'}"><span class="rpt-dot"></span><span>처리 중</span></div>
    <div class="rpt-bar ${isDone ? 'done' : ''}"></div>
    <div class="rpt-step ${isDone ? 'now' : ''}"><span class="rpt-dot"></span><span>처리 완료</span></div>
  </div>

  <div class="rpt-body">
    <dl class="kv">
      <div class="item"><dt>접수일</dt><dd>${report.created_at}</dd></div>
      <c:if test="${isDone}">
        <div class="item"><dt>처리완료일</dt><dd>${report.answered_at}</dd></div>
      </c:if>
    </dl>

    <div class="rpt-sec">
      <h3>내용</h3>
      <p class="body"><c:out value="${report.content}"/></p>
    </div>

    <c:if test="${isDone}">
      <div class="rpt-sec result">
        <h3>처리 결과</h3>
        <p class="body"><c:out value="${report.answer}"/></p>
      </div>
    </c:if>
  </div>
</section>

<div class="mt-32">
  <a class="btn btn-outline btn-sm rpt-back" href="${ctx}/support/report/list">
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
         stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
      <path d="M15 18l-6-6 6-6"/>
    </svg>
    목록으로
  </a>
</div>
</div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>