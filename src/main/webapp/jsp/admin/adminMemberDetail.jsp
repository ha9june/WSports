<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  회원 상세 (adminMemberDetail.jsp) - 담당: 임태균
  피그마: Admin / Member Detail / Desktop, Admin / Sanction / Modal
   state : suspended(정지 회원 - 제재 변경) | normal(정상 회원 - 제재 부여) | sanction(제재 모달 열림)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="회원 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="member" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'suspended' : param.state}" />
<c:set var="isNormal" value="${state eq 'normal'}" />
<c:set var="demoStates" value="suspended:정지 회원|normal:정상 회원|sanction:제재 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  <nav class="breadcrumb"><a href="${ctx}/jsp/admin/adminMember.jsp">회원 관리</a><span class="sep">›</span><span>회원 상세</span></nav>
  <div class="page-head"><h1 class="page-title">회원 상세</h1></div>
  <div style="width:760px;max-width:100%">
    <section class="admin-card">
      <div style="display:flex;align-items:center;gap:12px;margin-bottom:20px"><span class="avatar default"></span><strong style="font-size:18px">${isNormal ? 'player22' : 'baduser7'}</strong></div>
      <dl class="kv1">
        <dt>닉네임</dt><dd>${isNormal ? '풋살초보' : '노쇼반복'}</dd>
        <dt>이메일</dt><dd>${isNormal ? 'player22' : 'baduser7'}@example.com</dd>
        <dt>상태</dt><dd class="${isNormal ? '' : 't-danger'}">${isNormal ? '정상' : '정지'}</dd>
        <dt>패널티 점수</dt><dd>${isNormal ? '2점' : '12점'}</dd>
      </dl>
      <h3 class="t-13 t-bold mt-32">최근 제재 이력</h3>
      <p class="t-12 mt-8" style="line-height:1.8">${isNormal ? '9/03 · 경기 당일 취소 · +2점' : '9/10 · 노쇼 신고 확정 · +5점<br>9/02 · 결제 후 24시간 이내 취소 · +2점'}</p>
    </section>
    <section class="admin-card">
      <h2>제재 관리</h2>
      <p class="t-13 t-bold">${isNormal ? '현재 제재 없음' : '현재 정지 30일'}</p>
      <p class="t-11 t-2 mt-16">정지 기간 변경 또는 해제는 관리자(사이트) 판단으로 처리합니다.</p>
      <button type="button" class="btn btn-success-outline btn-sm mt-24" data-modal-open="sanctionModal">${isNormal ? '제재 부여' : '제재 변경'}</button>
    </section>
  </div>
</div>
</main></div>
<div class="modal ${state eq 'sanction' ? 'is-open' : ''}" id="sanctionModal" role="dialog" aria-modal="true"><div class="modal-card md">
  <h2 class="modal-title">회원 제재</h2><p class="modal-desc">제재 유형과 기간, 사유를 입력하면 회원에게 알림이 발송됩니다.</p>
  <div class="modal-body">
    <div class="field"><span class="field-label">제재 유형</span><div class="chip-group" data-select="single" data-name="sanctionType"><button type="button" class="chip">경고</button><button type="button" class="chip is-selected">기간 정지</button><button type="button" class="chip">영구 정지</button><button type="button" class="chip">제재 해제</button></div></div>
    <div class="field mt-16"><label class="field-label">정지 기간</label><select class="select"><option>7일</option><option>14일</option><option selected>30일</option><option>90일</option></select></div>
    <div class="field mt-16"><label class="field-label">사유</label><textarea class="textarea soft" rows="3" placeholder="예: 노쇼 신고 확정 3회"></textarea></div>
  </div>
  <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-danger" data-toast="제재를 적용했어요.">적용</button></div></div></div>
<%@ include file="/jsp/common/footer.jsp" %>
