<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  문의 관리 (adminInquiry.jsp) - 담당: 임태균
  피그마: Admin / Inquiries / Desktop
  TODO: <c:forEach var="q" items="${inquiryList}">, 탭은 ?status=
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="문의 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="inquiry" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  <p class="eyebrow-path">관리자(사이트)</p>
  <div class="page-head"><h1 class="page-title">문의 관리</h1><p class="page-desc">회원 문의를 확인하고 답변 상태를 관리합니다.</p></div>
  <div style="width:860px;max-width:100%">
    <nav class="tabs dark"><a class="tab is-active" href="?">전체</a><a class="tab" href="?status=WAIT">답변 대기</a><a class="tab" href="?status=DONE">답변 완료</a></nav>
    <div class="row-list">
      <a class="row-card" href="${ctx}/jsp/admin/adminInquiryDetail.jsp?state=waiting"><span class="t-11 t-2" style="width:50px">Q-204</span><div style="flex:1"><p class="title">결제 후 참가 확정이 되지 않아요</p><p class="meta">매치온 회원 · 결제/신청 · 2026.09.14</p></div><span class="pill pill-outline">답변 대기</span></a>
      <a class="row-card" href="${ctx}/jsp/admin/adminInquiryDetail.jsp?state=answered"><span class="t-11 t-2" style="width:50px">Q-203</span><div style="flex:1"><p class="title">팀 가입 신청 상태가 궁금해요</p><p class="meta">풋살초보 · 팀/가입 · 2026.09.12</p></div><span class="pill pill-success">답변 완료</span></a>
      <a class="row-card" href="${ctx}/jsp/admin/adminInquiryDetail.jsp?state=answered"><span class="t-11 t-2" style="width:50px">Q-202</span><div style="flex:1"><p class="title">경기 장소가 지도에서 다르게 보여요</p><p class="meta">서울킥 · 오류/지도 · 2026.09.10</p></div><span class="pill pill-success">답변 완료</span></a>
    </div>
  </div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
