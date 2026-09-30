<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  정산 상세 (adminSettlementDetail.jsp) - 담당: 임태균
  피그마: Admin / Settlement Detail / Match · Club Match
   state : match(개인 경기 - 작성자 정산) | teamMatch(팀 경기 - 팀 대표 정산)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="정산 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="settlement" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'match' : param.state}" />
<c:set var="isTeam" value="${state eq 'teamMatch'}" />
<c:set var="demoStates" value="match:개인 경기|teamMatch:팀 경기" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">

  <div class="page-head"><h1 class="page-title">정산 상세</h1><p class="page-desc">SET-0919-001</p></div>
  <div style="width:800px;max-width:100%">
    <section class="admin-card" style="display:flex;justify-content:space-between;align-items:center">
      <div><p class="t-11 t-2">관련 경기</p><p class="t-bold" style="font-size:15px;margin-top:6px">${isTeam ? '서울 풋살 크루 vs 마포 FC' : '토요일 저녁 풋살 한 판!'}</p></div>
      <a class="t-12 t-success t-bold" href="${ctx}${isTeam ? '/jsp/team/teamMatchDetail.jsp' : '/jsp/match/personalMatchDetail.jsp'}">경기 보기 →</a>
    </section>
    
    <h2 class="sub-title mt-32">정산 대상</h2><p class="section-desc" style="margin-bottom:12px">작성자 정산 내역을 확인하고 지급 상태를 처리합니다.</p>
    <div class="tbl-head" style="grid-template-columns:90px 70px 100px 1fr 120px 90px">
    	<span>닉네임</span>
    	<span>은행</span>
    	<span>계좌번호</span>
    	<span>예금주명</span>
    	<span>지급액</span><span class="t-right">정산</span></div>
    <div class="tbl-body"><div class="tbl-row" style="grid-template-columns:90px 70px 100px 1fr 120px 90px">
      <b>풋살초보</b><span>카카오뱅크</span><span>3333-12-3456789</span><b>예금주명</b><b>${isTeam ? '47,500원' : '95,000원'}</b>
      <button type="button" class="btn btn-primary btn-xs" data-modal-open="settleModal">정산하기</button></div></div>
  </div>
</div>
<div class="modal" id="settleModal" role="dialog" aria-modal="true"><div class="modal-card md">
  <h2 class="modal-title">정산을 완료 처리할까요?</h2><p class="modal-desc">등록 계좌로 지급한 뒤 완료 처리해주세요. 처리 후에는 되돌릴 수 없습니다.</p>
  <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-primary" data-toast="정산을 완료 처리했어요.">지급 완료 처리</button></div></div></div>
<%@ include file="/jsp/common/footer.jsp" %>
