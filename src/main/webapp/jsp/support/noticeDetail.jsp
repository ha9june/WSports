<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  공지사항 상세 (noticeDetail.jsp) - 담당: 박우리
  피그마: Notice / Detail / Desktop  (관리자는 수정/삭제 버튼 노출)
--%>
<c:set var="pageTitle" value="공지사항" />
<c:set var="pageCss" value="mypage" />
<c:set var="activeNav" value="notice" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="rail">
    <nav class="breadcrumb"><a href="${ctx}/jsp/support/noticeList.jsp">공지사항</a><span class="sep">›</span><span>상세</span></nav>
    <div class="page-head"><h1 class="page-title">공지사항</h1><p class="page-desc">서비스 운영 안내와 변경 내용을 확인합니다.</p></div>
    <h2 class="section-title" style="font-size:22px">[안내] 9월 서비스 운영 안내</h2>
    <p class="t-11 t-2 mt-16">2026.09.12 · 운영팀</p>
    <div class="detail-card mt-24" style="padding:24px 24px 28px">
      <p class="body" style="margin:0;font-size:13px">안녕하세요, 매치온입니다.<br>9월 서비스 운영 일정과 일부 기능 변경 내용을 안내드립니다.<br><br>
        • 경기 취소 및 환불 정책 안내 문구가 개선됩니다.<br>• 팀 경기 관리 화면의 신청 상태 표시가 정리됩니다.<br>• 점검 시간에는 결제 및 환불 기능이 일시 중단될 수 있습니다.</p>
    </div>
    <div class="form-actions" style="justify-content:space-between">
      <a class="btn btn-outline btn-sm" href="${ctx}/jsp/support/noticeList.jsp" style="width:92px">목록으로</a>
      <c:if test="${role eq 'admin'}">
        <div class="btn-group"><a class="btn btn-outline btn-sm" href="${ctx}/jsp/admin/adminNoticeModify.jsp">수정</a><a class="btn btn-danger btn-sm" href="${ctx}/jsp/admin/adminNotice.jsp?state=deleteModal">삭제</a></div>
      </c:if>
    </div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
