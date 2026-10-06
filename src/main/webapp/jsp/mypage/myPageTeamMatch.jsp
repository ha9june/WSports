<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/jsp/common/init.jsp"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.time.YearMonth, java.time.LocalDate"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr@4.6.13/dist/flatpickr.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/flatpickr@4.6.13/dist/flatpickr.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/flatpickr@4.6.13/dist/l10n/ko.js"></script>
<%--
  팀 경기 (myPageTeamMatch.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Club Matches / Desktop
  목록은 종목·상태 필터와 월 달력으로 조회합니다.
  TODO: 아래 act-card 를 <c:forEach var="m" items="${matchList}"> 로 반복 (날짜별 그룹 헤더 포함)
--%>
<c:set var="pageTitle" value="팀 경기" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="teamMatch" />
<c:set var="calDays" value="13,20,27" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<style>
.act-layout {
	display: flex;
	gap: 24px;
	align-items: flex-start;
}

.act-layout>section {
	flex: 1;
	min-width: 0;
}

.act-layout>aside.cal {
	width: 340px;
	flex-shrink: 0;
	padding: 16px;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-radius: 16px;
}

.cal .flatpickr-calendar.inline {
	box-shadow: none;
	border: 0;
	width: 100%;
}

.cal .flatpickr-days, .cal .dayContainer {
	width: 100%;
	min-width: 100%;
	max-width: 100%;
}

.cal .flatpickr-day {
	max-width: none;
	border-radius: 0%;
}

/* [선택 기간] 기본 배경 사각형 */
.cal .flatpickr-day.inRange {
	background: #e8f0ff !important;
	border-color: #e8f0ff !important;
	box-shadow: none;
	color: #1a6bff !important;
}

.cal .flatpickr-day.selected, .cal .flatpickr-day.startRange, .cal .flatpickr-day.endRange
	{
	background: #1a6bff !important;
	border-color: #1a6bff !important;
	color: #fff !important;
}

/* [지렁이/캡슐 모양] 시작과 끝 라운딩 */
.cal .flatpickr-day.startRange {
	border-top-left-radius: 50% !important;
	border-bottom-left-radius: 50% !important;
}

.cal .flatpickr-day.endRange {
	border-top-right-radius: 50% !important;
	border-bottom-right-radius: 50% !important;
}

.cal .flatpickr-day.startRange.endRange {
	border-radius: 50% !important;
}

/* 주말 줄바꿈 처리 */
.cal .dayContainer {
	display: flex;
	flex-wrap: wrap;
}

.cal .flatpickr-day.inRange:nth-child(7n+1) {
	border-top-left-radius: 50%;
	border-bottom-left-radius: 50%;
}

.cal .flatpickr-day.inRange:nth-child(7n) {
	border-top-right-radius: 50%;
	border-bottom-right-radius: 50%;
}

/* 경기 있는 날: 선택 여부 상관없이 365일 항상 표시 */
.cal .flatpickr-day.has-match {
	font-weight: 700 !important;
	color: #1a6bff !important; /* 평소에도 무조건 글자를 파란색으로 */
	position: relative !important;
}

/* 점(•) 강제 표시 */
.cal .flatpickr-day.has-match::after {
	content: "" !important;
	position: absolute !important;
	width: 5px !important;
	height: 5px !important;
	left: 50% !important;
	bottom: 5px !important;
	transform: translateX(-50%) !important;
	border-radius: 50% !important;
	background: #1a6bff !important;
	display: block !important;
}

/* 범위 선택 중(.startRange, .endRange)일 때는 가독성을 위해 흰색 점으로 변경 */
.cal .flatpickr-day.startRange.has-match::after, .cal .flatpickr-day.endRange.has-match::after,
	.cal .flatpickr-day.selected.has-match::after {
	background: #ffffff !important;
}

/* 연한 파란색 범위(.inRange) 안에 있을 때는 다시 파란색 점으로 */
.cal .flatpickr-day.inRange.has-match::after {
	background: #1a6bff !important;
}

/* 하단 범례 및 카드 */
.cal .legend {
	display: flex;
	align-items: center;
	gap: 6px;
	margin: 10px 0 0;
	font-size: 12px;
}

.cal .legend-dot {
	width: 6px;
	height: 6px;
	border-radius: 50%;
	background: #1a6bff;
}

.act-card {
	margin-bottom: 16px;
}

.list-head {
	display: flex;
	align-items: center;
	margin-bottom: 12px;
}

.btn-reset {
	margin-left: auto;
}
</style>
<div class="work-inner full" style="max-width: 1000px">
	<h1 class="section-title">팀 경기</h1>
	<p class="section-desc">내 팀의 경기를 종목, 상태와 월별 달력으로 확인하세요.</p>
	<form class="act-filters" method="get" id="periodForm">
		<input type="hidden" name="startDate" id="startDate"
			value="${startDate}"> <input type="hidden" name="endDate"
			id="endDate" value="${endDate}"> <select class="select"
			name="sport" onchange="this.form.submit()">
			<option value="">전체</option>
			<option value="축구/풋살" ${sport == '축구/풋살' ? 'selected' : ''}>축구/풋살</option>
			<option value="농구" ${sport == '농구' ? 'selected' : ''}>농구</option>
			<option value="테니스" ${sport == '테니스' ? 'selected' : ''}>테니스</option>
			<option value="배드민턴" ${sport == '배드민턴' ? 'selected' : ''}>배드민턴</option>
		</select> <select class="select" name="status" onchange="this.form.submit()">
			<option value="">전체 상태</option>
			<option value="모집중" ${status == '모집중' ? 'selected' : ''}
				style="background-color: #e6f7ed; color: #1f874c; font-weight: bold;">모집중</option>
			<option value="모집 마감" ${status == '모집 마감' ? 'selected' : ''}>모집
				마감</option>
			<option value="경기 종료" ${status == '경기 종료' ? 'selected' : ''}>경기
				종료</option>
			<option value="경기 취소" ${status == '경기 취소' ? 'selected' : ''}>경기
				취소</option>
		</select>
	</form>
	<div class="act-layout">
		<section>
			<div class="act-head"></div>
			<div class="list-head">
				<c:if test="${empty match}">
					<p class="empty-msg">참가 경기가 없습니다.</p>
				</c:if>
				<a class="btn-reset" href="?">필터 초기화</a>
			</div>


			<!-- 반복문으로 하나씩 꺼내서 match라는 변수로 받음 -->
			<c:forEach var="m" items="${match}">
				<div class="act-card"
					data-href="${ctx}/jsp/team/teamMatchDetail.jsp?state=completed">
					<div class="left">
						<span class="pill pill-info">${m.status}</span><img
							src="${ctx}/img/sport-icon-football.png" alt="">
					</div>
					<!-- 경기 제목 -->
					<div class="main">
						<strong>${m.title}</strong>
						<!-- 경기날짜 -->
						<p class="meta">
							<span><img src="${ctx}/img/icon-calendar-14.svg" alt="">${m.matchDate}</span>
							<!-- 경기 날짜 / 시간 -->
							<span><img src="${ctx}/img/icon-clock-16.svg" alt="">${m.startTime}
								~ ${m.endTime}</span>
							<!-- 경기 장소 -->
							<span><img src="${ctx}/img/icon-pin-14.svg" alt="">${m.placeName}</span>
							<!-- 경기 최소/최대 인원 -->
							<span><img src="${ctx}/img/icon-user-12.svg" alt="">8/10
								· 최소 8명 <span class="cap"><i style="width: 80%"> </i> </span> </span>
						</p>
					</div>
					<!-- 참가비 fmt:formatNumber: 숫자를 원하는형식으로 바꿔주는 JSTL fmt태그
		      					pattern="#,###" 출력형식(5,000)-->
					<div class="aside">
						<div class="top">
							<span><fmt:formatNumber value="${m.participationFee}"
									pattern="#,###" />원</span>
							<!-- 관심경기 추가/제거 -->
							<button type="button" class="fav-btn ${m.favorite ? 'is-on':''}"
								data-match-id="${m.teamMatchId}" data-match-type="Team"
								aria-label="관심 경기">${heart}</button>
						</div>
						<div class="btns">
							<a class="btn btn-primary btn-xs"
								href="${ctx}/jsp/team/teamMatchParticipants.jsp">참가자 확인</a>
						</div>
					</div>
				</div>
			</c:forEach>
			<c:set var="qs"
				value="&sport=${sport}&status=${status}&startDate=${startDate}&endDate=${endDate}" />
			<nav class="pagination"
				style="display: flex; justify-content: center; padding: 0">
				<c:if test="${pageInfo.curPage > 1}">
					<a href="?page=${pageInfo.curPage - 1}${qs}">&lt;</a>
				</c:if>
				<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}"
					var="p">
					<a href="?page=${p}${qs}"
						class="${pageInfo.curPage eq p ? 'is-active' : ''}">${p}</a>
				</c:forEach>
				<c:if test="${pageInfo.curPage < pageInfo.allPage}">
					<a href="?page=${pageInfo.curPage + 1}${qs}">&gt;</a>
				</c:if>
			</nav>

		</section>
		<aside class="cal">
			<div id="periodPicker"></div>
			<p class="legend">
				<span class="legend-dot"></span> 경기 있음
			</p>
		</aside>
		<%--
  마이페이지 활동 화면 공통 월 달력 (참가 경기 / 내가 만든 경기 / 관심경기 / 팀 경기)
   - calDays : 경기가 있는 날짜 (콤마 구분)  예) "19,20"
  피그마: MyPage / Month Picker / Overlay (연-월 선택)
  TODO: ?ym=2026-09 로 월 이동 → 서블릿에서 해당 월 목록 조회
--%>
		<script>
		$(function() {
    // ★ 내가 참가한 경기 날짜
		    var matchDates = [
		    <c:forEach var="d" items="${matchDates}" varStatus="st">
		        '${d}'${st.last ? '' : ','}
		    </c:forEach>
		];
    flatpickr('#periodPicker', {
        inline: true,
        mode: 'range',
        locale: 'ko',
        dateFormat: 'Y-m-d',
        defaultDate: '${startDate}'
            ? ['${startDate}', '${endDate}'] : null,

        onDayCreate: function(dObj, dStr, fp, dayElem) {
            var currentDate = fp.formatDate(
                dayElem.dateObj,
                'Y-m-d'
            );
            // ★ 참가한 경기가 있는 날짜만 점
            if (matchDates.indexOf(currentDate) !== -1) {
                dayElem.classList.add('has-match');
            }
        },
        onChange: function(selectedDates, dateStr, instance) {
            if (selectedDates.length === 2) {
                var start = instance.formatDate(
                    selectedDates[0],
                    'Y-m-d'
                );
                var end = instance.formatDate(
                    selectedDates[1],
                    'Y-m-d'
                );
                $('#startDate').val(start);
                $('#endDate').val(end);
                $('#periodForm').submit();
            }
        }
    });

});
</script>
		<script>
			$(function() {
				$(".fav-btn").click(function(e) {
					e.stopPropagation();
					var $btn = $(this);
					$.ajax({
						url : '${ctx}/mypage/matches/saved',
						type : 'post',
						dataType : 'text',
						data : {matchId : $btn.data("matchId"),
							matchType : $btn.data("matchType"),
							heart : $btn.hasClass("is-on")},
						    success : function(result) {
							result = result.trim();
							if (result == 'insert') {
								$btn.addClass("is-on");
								showToast("관심경기에 추가되었습니다.");
							}
							if (result == 'delete') {
								$btn.removeClass("is-on");
								showToast("관심경기에 제거되었습니다.");
							}
							if (result == 'login') {
								showToast("로그인이 필요합니다.");
							}
						}
					});
				});
			});
		</script>
	</div>
</div>
<%@ include file="/jsp/common/footer.jsp"%>
