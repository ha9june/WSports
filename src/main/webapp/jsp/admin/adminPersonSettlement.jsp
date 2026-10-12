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

<!-- 달력 라이브러리 불러오기 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>

<script>
	//full calender 달력 api
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        // 속성, 이벤트 등 세팅
    });
</script>
<div class="admin-inner">
	<p class="eyebrow-path">관리자(사이트)</p>
	<div class="page-head"><h1 class="page-title">정산 관리</h1>
  		<p class="page-desc">정산할 금액을 확인하고 지급 완료 상태로 처리합니다.</p>
  	</div>
  	<nav class="tabs big">
  		<a class="tab is-active" href="${ctx}/admin/settlement/person">개인 경기 정산 관리</a>
  		<a class="tab" href="${ctx}/admin/settlement/team">팀 경기 정산 관리</a>
  	</nav>
  	<div class="kpi-grid two">
  		<div class="kpi">
  			<p>정산 대기</p>
  			<b>${personwait}건</b>
    	</div>

		<div class="kpi">
			<p>지급 예정 금액</p>
			<b><fmt:formatNumber value="${personwaitmoney}" pattern="#,###" />원</b>
		</div>
	</div>
  	<div class="list-toolbar" style="margin: 20px 0 20px; padding-left: 0" >
    	<div class="seg pill success" style="padding-left: 0; margin-left: 0">
    		<a class="seg-item ${state ne 'completed' and state ne 'date' ? 'is-active' : ''}" href="?state=all">정산 대기</a>
    		<a class="seg-item ${state eq 'completed' ? 'is-active' : ''}" href="?state=completed">지급 완료</a>
    		<a class="seg-item ${state eq 'date' ? 'is-active' : ''}" href="?state=date">날짜별</a>
    	</div>
    	<c:if test="${state eq 'date'}">
    		<form class="date-stepper" method="get" id="periodForm">
				<input type="hidden" name="state" value="date">
				<input type="hidden" name="startDate" id="startDate" value="${startDate}">
				<input type="hidden" name="endDate" id="endDate" value="${endDate}">
				<input type="text" id="periodPicker" class="date-input" style="width:190px;text-align:center" readonly>
			</form>
    	</c:if>
  	</div>
  	<h2 class="sub-title">${state eq 'completed' ? '지급 완료 경기' : state eq 'date' ? '날짜별 정산 목록' : '정산 대상 경기'}</h2>
  	<p class="section-desc" style="margin-bottom:16px">경기 날짜 기준</p>
  	<c:choose>
    	<c:when test="${state eq 'completed'}">
        	<c:set var="displayList" value="${personfinish}" />
    	</c:when>
    	<c:when test="${state eq 'date'}">
        	<c:set var="displayList" value="${personday}" />
    	</c:when>
    	<c:otherwise>
        	<c:set var="displayList" value="${personwaitlist}" />
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
       href="${ctx}/admin/settlement/detail?matchId=${s.personal_match_id}&amp;matchType=personal">보기</a>
  		</div>
	</c:forEach>
	<c:if test="${empty displayList}">
		<div class="empty-state">
			<div class="empty-icon">
				<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor"
				     stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
					<c:choose>
						<c:when test="${state eq 'date'}">
							<rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/>
						</c:when>
						<c:otherwise>
							<path d="M20 6 9 17l-5-5"/>
						</c:otherwise>
					</c:choose>
				</svg>
			</div>
			<c:choose>
				<c:when test="${state eq 'completed'}">
					<strong>아직 지급 완료된 정산이 없어요</strong>
					<p>정산 대기 경기를 지급 완료 처리하면 여기에 내역이 쌓입니다.</p>
					<a class="btn btn-outline btn-sm" href="?state=all">정산 대기 보기</a>
				</c:when>
				<c:when test="${state eq 'date' and empty startDate}">
					<strong>조회할 기간을 선택해 주세요</strong>
					<p>위의 달력에서 시작일과 종료일을 고르면 해당 기간의 정산 내역이 표시됩니다.</p>
				</c:when>
				<c:when test="${state eq 'date'}">
					<strong>선택한 기간에 정산 내역이 없어요</strong>
					<p>기간을 넓혀서 다시 조회해 보세요.</p>
				</c:when>
				<c:otherwise>
					<strong>처리할 정산이 없어요</strong>
					<p>경기가 끝나면 모집자에게 지급할 정산이 여기에 표시됩니다.</p>
					<a class="btn btn-outline btn-sm" href="?state=completed">지급 완료 내역 보기</a>
				</c:otherwise>
			</c:choose>
		</div>
	</c:if>
</div>

<script>
	const periodPicker = document.getElementById('periodPicker');
	if (periodPicker) {
		flatpickr(periodPicker, {
			mode: 'range',                    // 기간 선택
			locale: 'ko',
			dateFormat: 'Y-m-d',
			disableMobile: true,
			defaultDate: ['${startDate}', '${endDate}'],   // 현재 조회 중인 기간 표시
			onClose: function (selectedDates, dateStr, instance) {
				// 시작일, 종료일 둘 다 골랐을 때만 조회
				if (selectedDates.length === 2) {
					document.getElementById('startDate').value = instance.formatDate(selectedDates[0], 'Y-m-d');
					document.getElementById('endDate').value = instance.formatDate(selectedDates[1], 'Y-m-d');
					document.getElementById('periodForm').submit();
				}
			}
		});
	}
</script>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
