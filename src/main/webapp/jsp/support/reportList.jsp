<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  신고 목록 (reportList.jsp) - 담당: 박우리
  피그마: Reports / List / Desktop  (신고 / 문의사항 탭으로 reportList ↔ inquiryList 이동)
  TODO: <c:forEach var="r" items="${list}">, 상태 필터는 ?status=
--%>
<c:set var="pageTitle" value="신고・문의사항" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="support" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner" style="width:860px">
  <h1 class="section-title">신고・문의사항</h1>
  <p class="section-desc">신고 접수 내역과 문의사항을 한 곳에서 확인합니다.</p>
  <div class="seg" style="margin-bottom:12px">
    <a class="seg-item is-active" href="${ctx}/jsp/support/reportList.jsp">신고</a>
    <a class="seg-item " href="${ctx}/jsp/support/inquiryList.jsp">문의사항</a>
  </div>
  <div class="seg pill neutral" style="margin-bottom:32px"><a class="seg-item is-active" href="?">전체</a><a class="seg-item" href="?status=RECEIVED">접수</a><a class="seg-item" href="?status=DONE">처리 완료</a></div>
  <div class="row-list">
    <a class="row-card" href="${ctx}/jsp/support/reportDetail.jsp?state=processing" style="padding:18px 24px"><div><p class="title">경기 중 비매너 신고</p><p class="meta">경기 신고 · 9/12</p></div><span class="status"><span class="pill pill-brand">접수</span></span></a>
    <a class="row-card" href="${ctx}/jsp/support/reportDetail.jsp?state=done" style="padding:18px 24px"><div><p class="title">부적절한 후기 신고</p><p class="meta">콘텐츠 신고 · 8/28</p></div><span class="status"><span class="pill pill-neutral">처리 완료</span></span></a>
  </div>
  <nav class="pagination"><a href="#">‹</a><a href="#" class="is-active">1</a><a href="#">2</a><a href="#">3</a><a href="#">›</a></nav>
</div>
</main></div>
<a class="fab" href="${ctx}/jsp/support/reportWrite.jsp"><span class="fab-label">신고 접수</span><span class="fab-btn" aria-hidden="true"></span></a>
<%@ include file="/jsp/common/footer.jsp" %>
