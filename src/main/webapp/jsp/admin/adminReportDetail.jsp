<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  신고 상세 (adminReportDetail.jsp) - 담당: 임태균
  피그마: Admin / Report Detail / Member · Post, Admin / Report Reject · Action / Modal
   state : member(회원 신고) | post(게시글 신고) | reject(기각 모달) | action(조치 모달)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="신고 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="report" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'member' : param.state}" />
<c:set var="isPost" value="${state eq 'post'}" />
<c:set var="demoStates" value="member:회원 신고|post:게시글 신고|reject:기각 모달|action:조치 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  <p class="eyebrow-path">관리자(사이트) › 신고 관리 › 신고 상세</p>
  <div class="page-head"><h1 class="page-title">신고 상세</h1><p class="page-desc">신고 내용을 확인하고 처리합니다.</p></div>
  <section class="admin-card" style="width:760px;max-width:100%">
    <p class="t-11 t-2">R-1024</p>
    <h2 style="margin:8px 0 12px">${isPost ? '부적절한 글' : '비매너 행동'}</h2>
    <p class="t-11 t-2">신고자 &nbsp;풋살초보</p>
    <p class="t-11 t-2 mt-8">${isPost ? '대상 게시글' : '대상자'} &nbsp;<c:choose><c:when test="${isPost}"><a class="t-brand" href="${ctx}/jsp/match/personalMatchDetail.jsp">“토요일 저녁 풋살 한 판!”</a></c:when><c:otherwise>서울킥</c:otherwise></c:choose></p>
    <hr class="divider" style="width:300px">
    <p class="t-12">${isPost ? '모집글에 특정 회원을 비방하는 문구가 포함되어 있습니다.' : '경기 중 반복적인 욕설 및 비매너 행동이 있었습니다.'}</p>
    <div class="btn-group" style="justify-content:center;margin-top:48px">
      <button type="button" class="btn btn-outline btn-sm" data-modal-open="rejectModal" style="width:70px">기각</button>
      <button type="button" class="btn btn-primary btn-sm" data-modal-open="actionModal" style="width:70px">조치</button>
    </div>
  </section>
  <a class="btn btn-outline btn-sm mt-24" href="${ctx}/jsp/admin/adminReport.jsp${isPost ? '?state=post' : ''}">목록으로</a>
</div>
</main></div>
<div class="modal ${state eq 'reject' ? 'is-open' : ''}" id="rejectModal" role="dialog" aria-modal="true"><div class="modal-card">
  <h2 class="modal-title">신고 기각</h2><p class="modal-desc">기각 사유를 입력하면 신고가 처리 완료 상태로 변경됩니다.</p>
  <div class="field modal-body"><label class="field-label">기각 사유</label><textarea class="textarea soft" rows="3" placeholder="예: 증빙 부족 / 신고 기준 미충족"></textarea></div>
  <div class="modal-actions split"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-danger" data-toast="신고를 기각 처리했어요.">기각 처리</button></div></div></div>
<div class="modal ${state eq 'action' ? 'is-open' : ''}" id="actionModal" role="dialog" aria-modal="true"><div class="modal-card">
  <h2 class="modal-title">신고 조치</h2><p class="modal-desc">대상에게 적용할 조치를 선택하세요. 패널티 점수는 회원 누적 점수에 반영됩니다.</p>
  <div class="modal-body">
    <div class="field"><span class="field-label">조치</span><div class="chip-group" data-select="single"><button type="button" class="chip is-selected">경고</button><button type="button" class="chip">패널티 +3점</button><button type="button" class="chip">패널티 +5점</button><button type="button" class="chip">게시글 비공개</button></div></div>
    <div class="field mt-16"><label class="field-label">처리 메모</label><textarea class="textarea soft" rows="3" placeholder="처리 내용을 기록해주세요."></textarea></div>
  </div>
  <div class="modal-actions split"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-primary" data-toast="조치를 완료했어요.">조치 완료</button></div></div></div>
<%@ include file="/jsp/common/footer.jsp" %>
