<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀 상세 (adminTeamDetail.jsp) - 담당: 임태균
  피그마: Admin / Club Detail / Desktop, Admin / Club Delete / Modal
   state : default | penalty(패널티 부여/차감 모달) | delete(팀 삭제 모달)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="팀 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="team" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'default' : param.state}" />
<c:set var="demoStates" value="default:기본|penalty:패널티 모달|delete:삭제 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  <p class="eyebrow-path">관리자(사이트) › 팀 관리</p>
  <div class="page-head"><div class="admin-title-row"><h1 class="page-title">서울 풋살 크루</h1><span class="pill pill-warning">패널티 점수 2점</span><button type="button" class="btn btn-danger btn-xs" data-modal-open="teamDeleteModal">팀 삭제</button></div>
    <p class="page-desc">팀 기본 정보와 패널티 점수 이력을 관리합니다.</p></div>
  <div style="width:800px;max-width:100%">
    <section class="admin-card"><h2>팀 정보</h2>
      <dl class="kv2"><dt>주장</dt><dd>풋살초보</dd><dt>팀원</dt><dd>34명</dd><dt>주 활동 지역</dt><dd>마포구 · 서대문구</dd><dt>상태</dt><dd>정상</dd></dl></section>
    <section class="admin-card"><h2>패널티 점수 이력</h2>
      <div class="history-row"><span class="t-2">9/10</span><b>경기 당일 취소</b><b class="plus">+2점</b><span class="t-2">관리자(사이트)</span></div>
      <div class="history-row"><span class="t-2">8/03</span><b>상대 팀 신고 인정</b><b class="plus">+3점</b><span class="t-2">신고 처리</span></div>
      <div class="history-row"><span class="t-2">7/15</span><b>소명 승인</b><b class="minus">-3점</b><span class="t-2">관리자(사이트)</span></div>
    </section>
    <div class="btn-group mt-24"><button type="button" class="btn btn-danger-soft btn-sm" data-modal-open="penaltyModal">패널티 점수 부여</button><button type="button" class="btn btn-text btn-sm t-bold" style="color:var(--ds-text);padding:0 16px" data-modal-open="penaltyModal">패널티 점수 차감</button></div>
    <p class="t-11 t-2 mt-16">누적 10점 이상이면 팀 매칭 신청이 제한됩니다.</p>
  </div>
</div>
</main></div>
<div class="modal ${state eq 'penalty' ? 'is-open' : ''}" id="penaltyModal" role="dialog" aria-modal="true"><div class="modal-card md">
  <h2 class="modal-title">패널티 점수 조정</h2><p class="modal-desc">점수와 사유를 입력하면 팀 이력에 기록됩니다.</p>
  <div class="modal-body">
    <div class="field"><span class="field-label">구분</span><div class="chip-group" data-select="single"><button type="button" class="chip is-selected">부여</button><button type="button" class="chip">차감</button></div></div>
    <div class="field mt-16"><label class="field-label">점수</label><select class="select"><option>1점</option><option selected>2점</option><option>3점</option><option>5점</option></select></div>
    <div class="field mt-16"><label class="field-label">사유</label><input class="input" placeholder="예: 경기 당일 취소"></div>
  </div>
  <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-primary" data-toast="패널티 점수를 반영했어요.">반영</button></div></div></div>
<div class="modal ${state eq 'delete' ? 'is-open' : ''}" id="teamDeleteModal" role="dialog" aria-modal="true"><div class="modal-card">
  <h2 class="modal-title">팀을 삭제할까요?</h2><p class="modal-desc">팀과 팀 작성글, 예정된 팀 경기가 모두 삭제되며 복구할 수 없습니다. 팀원에게 삭제 알림이 발송됩니다.</p>
  <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-danger" data-toast="팀을 삭제했어요.">삭제</button></div></div></div>
<%@ include file="/jsp/common/footer.jsp" %>
