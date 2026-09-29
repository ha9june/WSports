<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  문의 목록 (inquiryList.jsp) - 담당: 박우리
  피그마: Inquiry / List / Desktop  (신고 / 문의사항 탭으로 reportList ↔ inquiryList 이동)
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
    <a class="seg-item " href="${ctx}/jsp/support/reportList.jsp">신고</a>
    <a class="seg-item is-active" href="${ctx}/jsp/support/inquiryList.jsp">문의사항</a>
  </div>
  <div class="seg pill neutral" style="margin-bottom:24px"><a class="seg-item is-active" href="?">전체</a><a class="seg-item" href="?status=WAIT">답변 대기</a><a class="seg-item" href="?status=DONE">답변 완료</a></div>
  <h2 class="sub-title" style="margin-bottom:14px">내 문의</h2>
  <div class="row-list">
    <a class="row-card" href="${ctx}/jsp/support/inquiryDetail.jsp?state=answered" style="padding:18px 24px"><div><p class="title">결제 후 참가 확정이 되지 않아요</p><p class="meta">결제 · 참가 · 2026.09.14</p></div><span class="status"><span class="pill pill-success">답변 완료</span></span></a>
    <a class="row-card" href="${ctx}/jsp/support/inquiryDetail.jsp?state=waiting" style="padding:18px 24px"><div><p class="title">팀 가입 신청 상태가 궁금해요</p><p class="meta">팀 · 가입 · 2026.09.12</p></div><span class="status"><span class="pill pill-neutral">답변 대기</span></span></a>
    <a class="row-card" href="${ctx}/jsp/support/inquiryDetail.jsp?state=answered" style="padding:18px 24px"><div><p class="title">경기 장소가 지도에서 다르게 보여요</p><p class="meta">오류 · 지도 · 2026.09.10</p></div><span class="status"><span class="pill pill-success">답변 완료</span></span></a>
  </div>
</div>
</main></div>
<a class="fab" href="${ctx}/jsp/support/inquiryWrite.jsp"><span class="fab-label">문의 작성</span><span class="fab-btn" aria-hidden="true"></span></a>
<%@ include file="/jsp/common/footer.jsp" %>
