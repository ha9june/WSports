<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<div class="page-head"><h1 class="page-title">정산 관리</h1>
  		<p class="page-desc">정산할 금액을 확인하고 지급 완료 상태로 처리합니다.</p>
  	</div>
  	<nav class="tabs big">
		<a class="tab" href="${ctx}/admin/settlement/person">개인 경기 정산 관리</a>
  		<a class="tab is-active" href="${ctx}/admin/settlement/team">팀 경기 정산 관리</a>
  	</nav>
  	<div class="kpi-grid two">
  		<div class="kpi">
  			<p>정산 대기</p>
  			<b>${teamwait}건</b>
    	</div>

		<div class="kpi">
			<p>지급 예정 금액</p>
			<b><fmt:formatNumber value="${teamwaitmoney}" pattern="#,###" /></b>
		</div>
	</div>
  	<div class="list-toolbar" style="margin:24px 0 16px">
    	<div class="seg pill success">
    		<a class="seg-item ${state ne 'completed' and state ne 'date' ? 'is-active' : ''}" href="?state=all">정산 대기</a>
    		<a class="seg-item ${state eq 'completed' ? 'is-active' : ''}" href="?state=completed">지급 완료</a>
    		<a class="seg-item ${state eq 'date' ? 'is-active' : ''}" href="?state=date">날짜별</a>
    	</div>
    	<c:if test="${state eq 'date'}">
    		<form class="date-stepper" method="get" action="">
    			<input type="hidden" name="state" value="date">
    			<a href="?state=date&amp;date=${prevDate}"></a>
    			<input type="date" name="date" value="${date}" onchange="this.form.submit()" class="date-input" required>
    			<a href="?state=date&amp;date=${nextDate}"></a>
    		</form>
    	</c:if>
  	</div>
  	<h2 class="sub-title">${state eq 'completed' ? '지급 완료 경기' : state eq 'date' ? '날짜별 정산 목록' : '정산 대상 경기'}</h2>
  	<p class="section-desc" style="margin-bottom:16px">경기 날짜 기준</p>
	<c:choose>
    	<c:when test="${state eq 'completed'}">
        	<c:set var="displayList" value="${teamfinish}" />
    	</c:when>
    	<c:when test="${state eq 'date'}">
        	<c:set var="displayList" value="${teamday}" />
    	</c:when>
    	<c:otherwise>
        	<c:set var="displayList" value="${teamwaitlist}" />
    	</c:otherwise>
	</c:choose>
  	<c:forEach var="s" items="${displayList}">
  		<div class="settle-row">
    		<span class="t-2"><fmt:formatDate value="${s.match_date}" pattern="M/d"/></span>
    		<div>
      		<strong>${s.title}</strong>
      		<p>${s.sport}</p>
    	</div>
    	<span class="amt"><fmt:formatNumber value="${s.amount}"/>원</span>
    	<c:choose>
      		<c:when test="${s.settlement_status eq '지급완료'}">
        		<span class="pill pill-info">지급 완료</span>
      		</c:when>
      		<c:otherwise>
        		<button type="button" class="pill pill-warning" data-modal-open="settleConfirmModal">정산 대기</button>
      		</c:otherwise>
    	</c:choose>
    	<a class="btn btn-outline btn-xs t-brand"
       href="${ctx}/jsp/admin/adminSettlementDetail.jsp?matchId=${s.matchId}&amp;matchType=personal">보기</a>
  		</div>
	</c:forEach>

<c:if test="${empty displayList}">
  <p class="section-desc">표시할 경기가 없습니다.</p>
</c:if>
</div>

<%@ include file="/jsp/common/footer.jsp" %>
