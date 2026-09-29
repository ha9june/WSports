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
    <nav class="breadcrumb"><a href="${ctx}/jsp/mypage/myPageUser.jsp">마이페이지</a><span class="sep">›</span><a href="${ctx}/jsp/support/reportList.jsp">이용지원</a><span class="sep">›</span><span>신고 상세</span></nav>
    <div class="page-head"><h1 class="page-title">신고 상세</h1><p class="page-desc">접수한 신고 내용과 처리 상태를 확인합니다.</p></div>
    <section class="detail-card" style="width:840px;max-width:100%">
      <div class="head"><h2>${state eq 'done' ? '부적절한 후기 신고' : '경기 중 비매너 신고'}</h2>
        <span class="t-12 ${state eq 'done' ? 't-success' : 't-danger'}" style="margin-right:100px">${state eq 'done' ? '처리 완료' : '처리 중'}</span></div>
      <dl class="kv"><dt>접수일</dt><dd>${state eq 'done' ? '2026.08.28' : '2026.09.12'}</dd></dl>
      <h3>내용</h3>
      <p class="body">${state eq 'done' ? '후기 내용에 특정 회원을 비방하는 표현이 있어 신고합니다.' : '경기 중 반복적인 비매너 행동이 있어 신고합니다.<br>상황을 확인해 주세요.'}</p>
      <c:if test="${state eq 'done'}">
        <h3>처리 결과</h3>
        <p class="body">운영 정책 위반이 확인되어 해당 후기를 비공개 처리했습니다. 신고해 주셔서 감사합니다.</p>
      </c:if>
    </section>
    <div class="mt-32"><a class="btn btn-outline btn-sm" href="${ctx}/jsp/support/reportList.jsp" style="width:115px">목록으로</a></div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
