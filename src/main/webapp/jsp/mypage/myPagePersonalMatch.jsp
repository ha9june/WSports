<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.time.YearMonth, java.time.LocalDate"%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<%--
  참가 경기 (myPagePersonalMatch.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Participating Matches / Desktop
  목록은 종목·상태 필터와 월 달력으로 조회합니다.
  TODO: 아래 act-card 를 <c:forEach var="m" items="${matchList}"> 로 반복 (날짜별 그룹 헤더 포함)
--%>
<c:set var="pageTitle" value="참가 경기" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="personalMatch" />
<c:set var="demoRoles" value="member" />

<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<style>
.pill-info.bd {
	border: 1px solid var(--ds-info-bd);
}

.match-left img {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	object-fit: contain;
}

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

/* 달력 점 색: 여기 한 줄만 바꾸면 전체 적용 */
.cal {
	--dot-color: #1a6bff;
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

/* 경기 있는 날: 글자 강조 + 점 (평소 / 범위 안 / 시작·끝 모두 같은 점) */
.cal .flatpickr-day.has-match {
	font-weight: 700 !important;
	color: #1a6bff !important;
}

.cal .flatpickr-day.has-match,
.cal .flatpickr-day.inRange.has-match,
.cal .flatpickr-day.startRange.has-match,
.cal .flatpickr-day.endRange.has-match,
.cal .flatpickr-day.selected.has-match {
	background-image: radial-gradient(circle at 50% calc(100% - 7px), var(--dot-color) 2.5px, transparent 3px) !important;
	background-repeat: no-repeat !important;
}

/* [선택 기간] 범위 배경 */
.cal .flatpickr-day.inRange {
	background: #D9E2EC !important;
	border-color: #F0F4F8 !important;
	box-shadow: none;
	color: #102A43 !important;
	border-radius: 0 !important;
}

/* [선택 시작/끝/단일] */
.cal .flatpickr-day.selected, .cal .flatpickr-day.startRange, .cal .flatpickr-day.endRange {
	background: #102A43 !important;
	border-color: #102A43 !important;
	color: #BCCCDC !important;
	border-radius: 50% !important;
}

.cal .flatpickr-day.startRange:not(.endRange) {
	border-radius: 50% 0 0 50% !important;
}

.cal .flatpickr-day.endRange:not(.startRange) {
	border-radius: 0 50% 50% 0 !important;
}

.cal .flatpickr-day.startRange.endRange {
	border-radius: 50% !important;
}

/* 짧게 선택(붙어 있는 두 날짜)했을 때 사이를 메우는 기본 파란색 → 남색 */
.cal .flatpickr-day.selected.startRange + .endRange:not(:nth-child(7n+1)),
.cal .flatpickr-day.startRange.startRange + .endRange:not(:nth-child(7n+1)),
.cal .flatpickr-day.endRange.startRange + .endRange:not(:nth-child(7n+1)) {
	box-shadow: -10px 0 0 #102A43 !important;
}

/* 오늘 날짜: 작은 동그라미 */
.cal .flatpickr-day.today {
	border-color: transparent !important;
	font-weight: 700;
}

.cal .flatpickr-day.today::before {
	content: "" !important;
	position: absolute !important;
	top: 50% !important;
	left: 50% !important;
	width: 28px !important;
	height: 28px !important;
	transform: translate(-50%, -50%) !important;
	box-sizing: border-box !important;
	border: 1.5px solid #102A43 !important;
	border-radius: 50% !important;
	pointer-events: none;
}

/* 오늘이 시작/끝/선택일일 때: 배경이 남색이라 밝은 원 */
.cal .flatpickr-day.today.selected::before,
.cal .flatpickr-day.today.startRange::before,
.cal .flatpickr-day.today.endRange::before {
	border-color: #BCCCDC !important;
}

/* 하단 범례 */
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
	background: var(--dot-color);
}

/* 카드 */
.act-card {
	margin-bottom: 16px;
}

.act-card .left {
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: 6px;
	width: 90px;
}

.act-card .left img {
	width: 64px;
	height: 64px;
	object-fit: contain;
}

/* 필터 */
.act-filters {
	display: flex;
	align-items: center;
	gap: 12px;
}

.act-filters .btn-reset {
	margin-left: 0;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 35px;
	padding: 0 20px;
	border: 1px solid #111;
	border-radius: 10px;
	background: #fff;
	color: #111;
	font-size: 14px;
	font-weight: 500;
	text-decoration: none;
	white-space: nowrap;
	cursor: pointer;
}

.act-filters .btn-reset:hover {
	background: #111;
	color: #fff;
}
.cal .legend-today {
	width: 12px;
	height: 12px;
	box-sizing: border-box;
	border: 1.5px solid #102A43;
	border-radius: 50%;
	margin-left: 10px;
}
</style>

<div class="work-inner full" style="max-width: 1000px">
	<h1 class="section-title">참가 경기</h1>
	<p class="section-desc">내가 참가하는 경기를 종목, 상태와 월별 달력으로 확인하세요.</p>
	<form class="act-filters" method="get" id="periodForm">
		<input type="hidden" name="startDate" id="startDate"
			value="${startDate}"> <input type="hidden" name="endDate"
			id="endDate" value="${endDate}">
		<!-- 경기 종목별 리스트 검색 -->
		<select class="select" name="sport" onchange="this.form.submit()">
			<option value="">전체</option>
			<option value="축구/풋살" ${sport == '축구/풋살' ? 'selected' : ''}>축구/풋살</option>
			<option value="농구" ${sport == '농구' ? 'selected' : ''}>농구</option>
			<option value="테니스" ${sport == '테니스' ? 'selected' : ''}>테니스</option>
			<option value="배드민턴" ${sport == '배드민턴' ? 'selected' : ''}>배드민턴</option>
		</select> <select class="select" name="status" onchange="this.form.submit()">
			<option value="">전체 상태</option>
			<option value="모집중" ${status == '모집중' ? 'selected' : ''}>모집중</option>
			<option value="모집 마감" ${status == '모집 마감' ? 'selected' : ''}>모집
				마감</option>
			<option value="경기 종료" ${status == '경기 종료' ? 'selected' : ''}>경기
				종료</option>
			<option value="경기 취소" ${status == '경기 취소' ? 'selected' : ''}>경기
				취소</option>
		</select> <a class="btn-reset" href="?">필터 초기화</a>
	</form>
	<div class="act-layout">
		<section>
			<div class="act-head"></div>
			<c:if test="${empty match}">
				<p class="empty-msg"
					style="text-align: center; color: #9ca3af; padding: 60px 0;">경기가
					없습니다.</p>
			</c:if>

			<c:forEach var="m" items="${match}">
				<div class="act-card"
					data-href="${ctx}/match/detail/view?personalMatchId=${m.personalMatchId}">
					<div class="left">
						<c:choose>
							<c:when test="${m.status eq '모집중'}">
								<span class="pill pill-success bd">모집중</span>
							</c:when>
							<c:when test="${m.status eq '모집 마감' or m.status eq '경기 종료'}">
								<span class="pill pill-info bd">${m.status}</span>
							</c:when>
							<c:when test="${m.status eq '경기 취소'}">
								<span class="pill pill-danger bd">경기 취소</span>
							</c:when>
							<c:otherwise>
								<span class="pill pill-neutral bd">${m.status}</span>
							</c:otherwise>
						</c:choose>

						<c:choose>
							<c:when test="${m.sport eq '축구/풋살'}">
								<img src="${ctx}/img/art-football.png" alt="축구/풋살">
							</c:when>
							<c:when test="${m.sport eq '농구'}">
								<img src="${ctx}/img/art-basketball.png" alt="농구">
							</c:when>
							<c:when test="${m.sport eq '테니스'}">
								<img src="${ctx}/img/art-tennis.png" alt="테니스">
							</c:when>
							<c:when test="${m.sport eq '배드민턴'}">
								<img src="${ctx}/img/art-badminton.png" alt="배드민턴">
							</c:when>
							<c:otherwise>
								<img src="${ctx}/img/match-default.png" alt="">
							</c:otherwise>
						</c:choose>
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
								data-fav data-type="match" data-match-id="${m.personalMatchId}"
								data-match-type="Personal" aria-label="관심 경기">${heart}</button>

						</div>
						<div class="btns">
							<c:choose>
								<%-- 경기 취소: 버튼 없음 --%>
								<c:when test="${m.status eq '경기 취소'}">
								</c:when>

								<%-- 경기 종료: 후기 작성 / 참가 팀 평가 --%>
								<c:when test="${m.status eq '경기 종료'}">
									<a class="btn btn-outline btn-xs"
										href="${ctx}/review/create?matchNo=PERSONAL:${m.personalMatchId}"
										onclick="event.stopPropagation()">후기 작성</a>
									<a class="btn btn-primary btn-xs"
										href="${ctx}/match/after/profile/list/edit?personalMatchId=${m.personalMatchId}"
										onclick="event.stopPropagation()">참가 팀 평가</a>
								</c:when>

								<%-- 그 외: 기존 버튼 --%>
								<c:otherwise>
									<a class="btn btn-primary btn-xs"
										href="${ctx}/personal-match/participants/list?personalMatchId=${m.personalMatchId}"
										onclick="event.stopPropagation()">참가자 확인</a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</c:forEach>
			<c:if test="${pageInfo.allPage > 1}">
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
			</c:if>
		</section>
		<aside class="cal">
			<div id="periodPicker"></div>
			<p class="legend">
				<span class="legend-dot"></span> 경기 있음
				<span class="legend-today"></span> Today
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

		    // 새로고침 후 선택 기간 복원
		    var sd = '${startDate}', ed = '${endDate}';
		    var initDates = (sd && sd !== 'null')
		        ? [sd, (ed && ed !== 'null') ? ed : sd]
		        : null;


		    var fp = flatpickr('#periodPicker', {
		        inline: true,
		        mode: 'range',
		        locale: 'ko',
		        dateFormat: 'Y-m-d',
		        defaultDate: initDates,
		        onDayCreate: function(dObj, dStr, inst, dayElem) {
		            var d = inst.formatDate(dayElem.dateObj, 'Y-m-d');
		            if (matchDates.indexOf(d) !== -1) {
		                dayElem.classList.add('has-match');
		            }
		        }
		    });

		    var $cal = $(fp.calendarContainer);
		    var dragStart = null;
		    var dragEnd = null;
		    var dragging = false;

		    $cal.on('mousedown', '.flatpickr-day', function(e) {
		        if ($(this).hasClass('flatpickr-disabled')) return;
		        e.preventDefault();
		        e.stopPropagation();
		        dragStart = this.dateObj;
		        dragEnd = dragStart;
		        dragging = true;
		        fp.setDate([dragStart], false);
		    });

		    $cal.on('mouseover', '.flatpickr-day', function() {
		        if (!dragging) return;
		        dragEnd = this.dateObj;
		        var s = dragStart, t = dragEnd;
		        if (s > t) { var tmp = s; s = t; t = tmp; }
		        fp.setDate([s, t], false);
		    });

		    $(document).on('mouseup', function() {
		        if (!dragging) return;
		        dragging = false;

		        var s = dragStart, t = dragEnd || dragStart;
		        if (s > t) { var tmp = s; s = t; t = tmp; }

		        var sdStr = fp.formatDate(s, 'Y-m-d');
		        var edStr = fp.formatDate(t, 'Y-m-d');

		        var params = new URLSearchParams(window.location.search);
		        params.set('startDate', sdStr);
		        params.set('endDate', edStr);
		        params.set('sport', $('select[name=sport]').val() || '');
		        params.set('status', $('select[name=status]').val() || '');
		        params.delete('page');   // 기간 바꾸면 1페이지부터

		        window.location.href = window.location.pathname + '?' + params.toString();
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