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
<main class="page">
  <div class="container">
    <nav class="breadcrumb"><a href="${ctx}/member/mypage/view">마이페이지</a><span class="sep">›</span><a href="${ctx}/support/report/list">이용지원</a><span class="sep">›</span><span>신고 상세</span></nav>
    <div class="page-head"><h1 class="page-title">신고 상세</h1><p class="page-desc">접수한 신고 내용과 처리 상태를 확인합니다.</p></div>
    <section class="detail-card" style="width:840px;max-width:100%">
      <div class="head"><h2>${report.title}</h2>
        <span class="t-12 ${report.status eq '처리완료' ? 't-success' : 't-danger'}" style="margin-right:100px">${report.status eq '처리완료' ? '처리 완료' : '처리 중'}</span></div>
      <dl class="kv"><dt>${report.status eq '처리완료' ? '처리완료일' : '접수일'}</dt><dd>${report.status eq '처리완료' ? report.answered_at : report.created_at}</dd></dl>
      <h3>내용</h3>
      <p class="body">${report.content}</p>
      <c:if test="${report.status eq '처리완료'}">
        <h3>처리 결과</h3>
        <p class="body">${report.answer}</p>
      </c:if>
    </section>
    <div class="mt-32"><a class="btn btn-outline btn-sm" href="${ctx}/support/report/list" style="width:115px">목록으로</a></div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
