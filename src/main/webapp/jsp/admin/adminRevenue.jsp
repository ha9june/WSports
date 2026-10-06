<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  수익 관리 (adminRevenue.jsp) - 담당: 임태균
  피그마: Admin / Revenue Dashboard (수익 대시보드)
  월별 매출/수익 막대 그래프와 기간 조회 결과. TODO: 그래프 높이는 금액 비율(%)로 계산해 style 에 넣기
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="수익 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="revenue" />
<c:set var="demoRoles" value="admin" />
<c:set var="adminGray" value="true" />
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
	<p class="eyebrow-path">관리자(사이트) / 수익 관리</p>
  	<div class="page-head">
  		<h1 class="page-title">수익 대시보드</h1>
  	</div>
  	<div class="kpi-grid">
    	<div class="kpi">
    		<p>총 매출</p>
    		<b><fmt:formatNumber value="${totalRevenue}" pattern="#,###" />원</b>
    		<small>누적 결제 금액</small>
    	</div>
    	<div class="kpi">
    		<p>총 수익</p>
    		<b><fmt:formatNumber value="${totalProfit}" pattern="#,###" />원</b>
    		<small>플랫폼 순수익</small>
    	</div>
    	<div class="kpi">
    		<p>이번달 매출</p>
    		<b><fmt:formatNumber value="${monthlyRevenue}" pattern="#,###" />원</b>
    		<small>9월 결제 금액</small>
    	</div>
    	<div class="kpi">
    		<p>이번달 수익</p>
    		<b><fmt:formatNumber value="${monthlyProfit}" pattern="#,###" />원</b>
    		<small>9월 순수익</small>
    	</div>
  	</div>
  	<section class="admin-panel">
    	<div class="head">
    		<div>
    			<h2>월별 매출과 수익</h2>
    			<p>최근 6개월 실적 비교</p>
    		</div>
      		<div class="legend">
      			<span>
      				<i style="background:#2b4257"></i>매출
      			</span>
      			<span>
      				<i style="background:var(--ds-brand)"></i>수익
      			</span>
      		</div>
      	</div>
    	<div class="bar-chart" role="img" 
    	aria-label="${chartList[0].month }월부터 ${chartList[5].month }월까지 월별 매출과 수익 막대 그래프">
      		<c:forEach var="m" items="${chartList}">
        		<c:set var="v" value="${fn:split(b, '^')}" />
        		<div class="grp">
        			<div class="bars">
        				<i class="sales" style="height:${m.revenueHeight}%"
        				title="매출 <fmt:formatNumber value='${m.revenue }' pattern='#,###'/>원"></i>
        				<i class="profit" style="height:${m.profitHeight}%"
        				title="수익 <fmt:formatNumber value='${m.profit }' pattern='#,###'/>원"></i>
        			</div>
        			<span>${m.month}</span>
        		</div>
      		</c:forEach>
    	</div>
    	<div style="height:20px"></div>
  	</section>
  	<form class="admin-panel" method="get" id="periodForm">
    	<div class="period-panel">
      		<strong class="t-13" style="padding-bottom:10px">기간 조회</strong>
      			<div class="date-stepper">
					<input type="hidden" name="startDate" id="startDate" value="${startDate}">
					<input type="hidden" name="endDate" id="endDate" value="${endDate}">
					<input type="text" id="periodPicker" class="date-input" style="width:190px;text-align:center" readonly>
    			</div>
      		<button type="submit" class="btn btn-primary btn-sm" style="margin-bottom:2px">조회</button>
    	</div>
    	<c:if test="${not empty periodPaymentCnt}">
    	<div id="test" class="period-result">
      		<div>
      			<p>결제 건수</p>
      			<b>${periodPaymentCnt}</b>
      		</div>
      		<div>
      			<p>총 매출</p>
      			<b><fmt:formatNumber value="${periodRevenueCnt}" pattern="#,###" />원</b>
      		</div>
      		<div>
      			<p>수익</p>
      			<b><fmt:formatNumber value="${periodProfitCnt}" pattern="#,###" />원</b>
      		</div>
      		<div>
      			<p>수익률</p>
      			<b>8%</b>
      		</div>
    	</div>
    	</c:if>
  	</form>
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
