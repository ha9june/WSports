<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  신고 관리 (adminReport.jsp) - 담당: 임태균
  피그마: Admin / Reports / Member Tab · Post Tab
   state : member(회원 신고 탭) | post(게시글 신고 탭)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="신고 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="report" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'member' : param.state}" />
<c:set var="demoStates" value="member:회원 신고|post:게시글 신고" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  <p class="eyebrow-path">관리자(사이트)</p>
  <div class="page-head"><h1 class="page-title">신고 관리</h1><p class="page-desc">회원 신고와 게시글 신고를 탭으로 구분해 확인하고 처리합니다.</p></div>
  <div class="seg pill success" style="margin-bottom:24px"><a class="seg-item ${state ne 'post' ? 'is-active' : ''}" href="?state=member">회원 신고</a><a class="seg-item ${state eq 'post' ? 'is-active' : ''}" href="?state=post">게시글 신고</a></div>
  <div style="width:940px;max-width:100%">
    <div class="tbl-head" style="grid-template-columns:100px 150px 1fr 150px 130px 40px"><span>신고 유형</span><span>신고일</span><span>${state eq 'post' ? '대상 게시글' : '신고자 → 대상'}</span><span>신고 사유</span><span>상태</span><span></span></div>
    <div class="tbl-body">
      <c:choose>
        <c:when test="${state eq 'post'}">
          <a class="tbl-row" href="${ctx}/jsp/admin/adminReportDetail.jsp?state=post" style="grid-template-columns:100px 150px 1fr 150px 130px 40px"><span class="t-2">게시글 신고</span><b>9/18</b><span>“토요일 저녁 풋살 한 판!”</span><span>부적절한 글</span><span class="pill pill-warning bd">처리 대기</span><span class="t-2">›</span></a>
          <a class="tbl-row" href="${ctx}/jsp/admin/adminReportDetail.jsp?state=post" style="grid-template-columns:100px 150px 1fr 150px 130px 40px"><span class="t-2">후기 신고</span><b>8/28</b><span>“실내 농구 첫 참가”</span><span>비방·욕설</span><span class="pill pill-neutral">처리 완료</span><span class="t-2">›</span></a>
        </c:when>
        <c:otherwise>
          <a class="tbl-row" href="${ctx}/jsp/admin/adminReportDetail.jsp?state=member" style="grid-template-columns:100px 150px 1fr 150px 130px 40px"><span class="t-2">회원 신고</span><b>9/19</b><span>풋살초보 → 서울킥</span><span>비매너 행동</span><span class="pill pill-warning bd">처리 대기</span><span class="t-2">›</span></a>
          <a class="tbl-row" href="${ctx}/jsp/admin/adminReportDetail.jsp?state=member" style="grid-template-columns:100px 150px 1fr 150px 130px 40px"><span class="t-2">회원 신고</span><b>9/12</b><span>주말러너 → 노쇼반복</span><span>노쇼(불참)</span><span class="pill pill-neutral">처리 완료</span><span class="t-2">›</span></a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
