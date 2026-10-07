<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="정산 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="settlement" />
<c:set var="demoRoles" value="admin" />
<c:set var="demoStates" value="match:개인 경기|teamMatch:팀 경기" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="page-head">
	<h1 class="page-title">정산 상세</h1>
</div>
<c:if test="${not empty err}">
	<p class="t-12" style="color:red;margin-bottom:12px">${err}</p>
</c:if>
<div style="width:800px;max-width:100%">
	<section class="admin-card" style="display:flex;justify-content:space-between;align-items:center">
    	<div>
      		<p class="t-11 t-2">관련 경기</p>
      		<p class="t-bold" style="font-size:15px;margin-top:6px">${detail.title}</p>
      		<p class="t-11 t-2" style="margin-top:4px">${detail.sport} / 
      		<fmt:formatDate value="${detail.match_date}" pattern="yyyy.MM.dd"/>
      		</p>
      	</div>
		<c:choose>
      		<c:when test="${param.matchType eq 'team'}">
      			<a class="btn btn-primary btn-sm" href="${ctx}/team/detail/view?teamMatchId = ${matchId}">경기보기
      			</a>
      		</c:when>
      		<c:otherwise>
      			<a class="btn btn-primary btn-sm" href="${ctx}/personal/detail/view?personalMatchId = ${matchId}">경기보기
      			</a>
      		</c:otherwise>
      	</c:choose>
      
    </section>
    
    <h2 class="sub-title mt-32">정산 대상</h2>
    <p class="section-desc" style="margin-bottom:12px">작성자 정산 내역을 확인하고 지급 상태를 처리합니다.</p>
    <div class="tbl-head" style="grid-template-columns:90px 70px 100px 100px 120px 90px 100px">
    	<span>경기번호</span>
    	<span>닉네임</span>
    	<span>예금주명</span>
    	<span>은행</span>
    	<span>계좌번호</span>
    	<span>지급액</span>
    	<span>정산</span>
    </div>
    <div class="tbl-body">
    	<div class="tbl-row" style="grid-template-columns:90px 70px 100px 100px 120px 90px 100px">
    	<b>${matchId }</b>
      	<span>${detail.nickname }</span>
      	<span>${detail.account_holder }</span>
      	<span>${detail.bank_name }</span>
      	<b>${detail.account_number }</b>
      	<b><fmt:formatNumber value="${detail.amount}"/>원</b>
      	<c:choose>
      		<c:when test="${detail.settlement_status eq '지급완료' }">
      			<span class="pill pill-info">지급 완료</span>
      		</c:when>
      		<c:otherwise>
      			<button type="button" class="btn btn-primary btn-xs" data-modal-open="settleModal">정산하기</button>
      		</c:otherwise>	
      	</c:choose>
      </div>
  </div>
</div>
<div class="modal" id="settleModal" role="dialog" aria-modal="true">
	<div class="modal-card md">
  		<h2 class="modal-title">정산을 완료 처리할까요?</h2>
  		<p class="modal-desc">등록 계좌로 지급한 뒤 완료 처리해주세요. 처리 후에는 되돌릴 수 없습니다.</p>
  		<form method="post" action="${ctx}/admin/settlement/detail">
  			<input type="hidden" name="settlementId" value="${detail.settlement_id }">
  			<input type="hidden" name="matchId" value="${matchId}">
  			<input type="hidden" name="matchType" value="${isTeam ? 'team' : 'personal' }">
  			<div class="modal-actions">
  			<button type="submit" class="btn btn-primary" >지급 완료 처리</button>
  			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
  			</div>
  		</form>
  	</div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
