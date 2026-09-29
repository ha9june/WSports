<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  정산 관리 (adminSettlement.jsp) - 담당: 임태균
  피그마: Admin / Settlement / All · Completed · Date, Admin / Settlement Confirm / Modal
   state : all(전체 정산 대기) | completed(지급 완료 목록) | date(날짜별 조회) | confirm(정산 확인 모달)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="정산 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="settlement" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'all' : param.state}" />
<c:set var="demoStates" value="all:정산 대기|completed:지급 완료|date:날짜별|confirm:정산 확인 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  <p class="eyebrow-path">관리자(사이트)</p>
  <div class="page-head"><h1 class="page-title">정산 관리</h1><p class="page-desc">정산할 금액을 확인하고 지급 완료 상태로 처리합니다.</p></div>
  <div class="kpi-grid two"><div class="kpi"><p>정산 대기</p><b>5건</b></div><div class="kpi"><p>지급 예정 금액</p><b>220,400원</b></div></div>
  <div class="list-toolbar" style="margin:24px 0 16px">
    <div class="seg pill success"><a class="seg-item ${state ne 'completed' and state ne 'date' ? 'is-active' : ''}" href="?state=all">정산 대기</a><a class="seg-item ${state eq 'completed' ? 'is-active' : ''}" href="?state=completed">지급 완료</a><a class="seg-item ${state eq 'date' ? 'is-active' : ''}" href="?state=date">날짜별</a></div>
    <c:if test="${state eq 'date'}"><span class="date-stepper"><a href="?state=date&amp;date=2026-09-18">‹</a>2026.09.19<a href="?state=date&amp;date=2026-09-20">›</a></span></c:if>
  </div>
  <h2 class="sub-title">${state eq 'completed' ? '지급 완료 경기' : '정산 대상 경기'}</h2>
  <p class="section-desc" style="margin-bottom:16px">정산이 필요한 경기를 경기 일시 기준 최신순으로 표시합니다.</p>
  <%-- TODO: <c:forEach var="s" items="${settlementList}"> --%>
  <c:forTokens var="row" delims="|" items="9/19^토요일 저녁 풋살 한 판!^축구/풋살 · 지급 2건^95,000원|9/19^주말 실내 농구^농구 · 지급 2건^68,400원|9/19^평일 저녁 테니스 랠리^테니스 · 지급 1건^57,000원|9/19^망원 배드민턴 번개^배드민턴 · 지급 3건^88,000원">
    <c:set var="s" value="${fn:split(row, '^')}" />
    <div class="settle-row">
      <span class="t-2">${s[0]}</span>
      <div><strong>${s[1]}</strong><p>${s[2]}</p></div>
      <span class="amt">${s[3]}</span>
      <c:choose>
        <c:when test="${state eq 'completed'}"><span class="pill pill-info">지급 완료</span></c:when>
        <c:otherwise><button type="button" class="pill pill-warning" data-modal-open="settleConfirmModal">정산 대기</button></c:otherwise>
      </c:choose>
      <a class="btn btn-outline btn-xs t-brand" href="${ctx}/jsp/admin/adminSettlementDetail.jsp">보기</a>
    </div>
  </c:forTokens>
</div>
</main></div>
<div class="modal ${state eq 'confirm' ? 'is-open' : ''}" id="settleConfirmModal" role="dialog" aria-modal="true"><div class="modal-card md">
  <h2 class="modal-title">정산을 완료 처리할까요?</h2>
  <p class="modal-desc">토요일 저녁 풋살 한 판! · 95,000원<br>작성자 등록 계좌로 지급한 뒤 완료 처리해주세요. 처리 후에는 되돌릴 수 없습니다.</p>
  <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-primary" data-toast="정산을 완료 처리했어요.">지급 완료 처리</button></div></div></div>
<%@ include file="/jsp/common/footer.jsp" %>
