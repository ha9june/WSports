<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.time.YearMonth, java.time.LocalDate"%>
<link href="https://jsdelivr.net" rel="stylesheet" />
<script src="https://jsdelivr.net"></script>
<%--
  내가 만든 경기 (myPageCreatedPersonalMatch.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Recruited Matches / Desktop
  목록은 종목·상태 필터와 월 달력으로 조회합니다.
  TODO: 아래 act-card 를 <c:forEach var="m" items="${matchList}"> 로 반복 (날짜별 그룹 헤더 포함)
--%>
<%
YearMonth ym;
try {
	String p = request.getParameter("ym");
	ym = (p == null || p.isEmpty()) ? YearMonth.now() : YearMonth.parse(p);
} catch (Exception e) {
	ym = YearMonth.now();
}
YearMonth now = YearMonth.now();

// ===== 추가: 일 단위 이동 =====
LocalDate baseDate;
try {
	String dp = request.getParameter("date");
	baseDate = (dp == null || dp.isEmpty()) ? LocalDate.now() : LocalDate.parse(dp);
} catch (Exception e) {
	baseDate = LocalDate.now();
}

request.setAttribute("ym", ym.toString());
request.setAttribute("ymYear", ym.getYear());
request.setAttribute("ymMonth", ym.getMonthValue());
request.setAttribute("prevYm", ym.minusMonths(1).toString());
request.setAttribute("nextYm", ym.plusMonths(1).toString());
request.setAttribute("todayYm", now.toString());
request.setAttribute("startOffset", ym.atDay(1).getDayOfWeek().getValue() % 7);
request.setAttribute("lastDay", ym.lengthOfMonth());
request.setAttribute("prevLastDay", ym.minusMonths(1).lengthOfMonth());
request.setAttribute("todayDay", ym.equals(now) ? LocalDate.now().getDayOfMonth() : 0);

request.setAttribute("baseDate", baseDate.toString());
request.setAttribute("prevDate", baseDate.minusDays(1).toString());
request.setAttribute("nextDate", baseDate.plusDays(1).toString());
request.setAttribute("todayDate", LocalDate.now().toString());
%>
<c:set var="pageTitle" value="내가 만든 경기" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="createdMatch" />
<c:set var="calDays" value="19,20" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<style>
/* 날짜 칸: 크기 고정 + 가운데 정렬 (타원 방지) */
.cal .grid a {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: 28px;
	height: 28px;
	margin: 0 auto;
	border-radius: 50%;
	font-size: 13px;
	text-decoration: none;
}

/* 경기 있는 날: 연한 파란 원 */
.cal .grid .has {
	font-weight: 700;
	color: #1a6bff;
	background: #e8f0ff;
	border-radius: 50%;
}

/* 점 제거 */
.cal .grid .has::after, .cal .grid .has::before {
	display: none !important;
}

/* 선택한 날: 진한 파란 원 (has보다 우선) */
.cal .grid a.sel {
	background: #1a6bff !important;
	color: #fff !important;
}

/* 이전 달 날짜, 요일도 같은 높이로 맞춤 */
.cal .grid .muted, .cal .grid .dow {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	height: 28px;
}

/* 범례 */
.cal .legend {
	display: flex;
	align-items: center;
	gap: 6px;
	font-size: 12px;
}

.cal .legend-dot {
	display: inline-block;
	width: 12px;
	height: 12px;
	border-radius: 50%;
	background: #e8f0ff;
	border: 1px solid #1a6bff;
}

.act-card {
	margin-bottom: 16px;
}

.list-head {
	display: flex;
	align-items: center;
	margin-bottom: 12px
}

.btn-reset {
	margin-left: auto;
}
</style>

<div class="work-inner full" style="max-width: 1000px">
	<h1 class="section-title">내가 만든 경기</h1>
	<p class="section-desc">내가 만든 경기와 참가 현황을 종목, 상태와 월별 달력으로 확인하세요.</p>

	<!-- 선택하지않는 월/일 가리기 -->
	<form class="act-filters" method="get">
		<input type="hidden" name="ym" value="${ym}">
		<c:if test="${not empty selectedDate}">
			<input type="hidden" name="date" value="${selectedDate}">
		</c:if>
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
		</select>
	</form>

	<div class="act-layout">
		<section>
			<div class="act-head"></div>
			<fmt:parseNumber var="mm" value="${fn:substring(ym, 5, 7)}"
				integerOnly="true" />
			<div class="list-head">
				<h2>${fn:substring(ym, 0, 4)}년${mm}월·${fn:length(calMatch)}건</h2>
				<a class="btn-reset" href="?ym=${ym}&date=${selectedDate}">필터
					초기화</a>
			</div>
			<c:choose>
				<c:when test="${not empty selectedDate and not empty match}">
					<p class="sel-title">${fn:substring(selectedDate, 5, 7)}월
						${fn:substring(selectedDate, 8, 10)}일</p>
				</c:when>
				<c:when test="${not empty selectedDate and empty match}">
					<p class="empty-msg">해당 날짜에는 경기가 없습니다.</p>
				</c:when>

			</c:choose>


			<!-- 반복문으로 하나씩 꺼내서 match라는 변수로 받음 -->
			<c:forEach var="m" items="${match}">
				<div class="act-card"
					data-href="${ctx}/jsp/match/personalMatchDetail.jsp?state=applied">
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
									data-match-id="${m.personalMatchId}"
									data-match-type="Personal"
									aria-label="관심 경기">${heart}</button>
						</div>
						<div class="btns">
							<a class="btn btn-primary btn-xs"
								href="${ctx}/jsp/match/personalMatchProfileList.jsp">참가자 확인</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</section>
		<%--
  마이페이지 활동 화면 공통 월 달력 (참가 경기 / 내가 만든 경기 / 관심경기 / 팀 경기)
   - calDays : 경기가 있는 날짜 (콤마 구분)  예) "19,20"
  피그마: MyPage / Month Picker / Overlay (연-월 선택)
  TODO: ?ym=2026-09 로 월 이동 → 서블릿에서 해당 월 목록 조회
--%>
		<aside class="cal">
			<div class="head">
				<div class="dropdown">
					<button type="button" data-dropdown-toggle>${ymYear}년
						${ymMonth}월 ▾</button>
					<div class="dropdown-menu month-pop">
						<div class="yr">
							<a href="?ym=${ymYear - 1}-${ymMonth lt 10 ? '0' : ''}${ymMonth}">‹</a>
							${ymYear} <a
								href="?ym=${ymYear + 1}-${ymMonth lt 10 ? '0' : ''}${ymMonth}">›</a>
						</div>
						<div class="months">
							<c:forEach var="mo" begin="1" end="12">
								<a
									href="?ym=${ymYear}-${mo lt 10 ? '0' : ''}${mo}&date=${ymYear}-${mo lt 10 ? '0' : ''}${mo}-01&sport=${sport}"
									class="${mo eq ymMonth ? 'is-active' : ''}">${mo}월</a>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="nav">
					<a href="?ym=${prevYm}&sport=${sport}" aria-label="이전 달">‹</a> <a
						href="?ym=${todayYm}&date=${todayDate}&sport=${sport}"
						class="t-bold">오늘</a> <a href="?ym=${nextYm}&sport=${sport}"
						aria-label="다음 달">›</a>
				</div>
			</div>

			<div class="grid">
				<span class="dow">일</span><span class="dow">월</span><span
					class="dow">화</span> <span class="dow">수</span><span class="dow">목</span><span
					class="dow">금</span><span class="dow">토</span>

				<%-- 이전 달 날짜(흐리게) --%>
				<c:forEach var="i" begin="1" end="${startOffset}">
					<span class="muted">${prevLastDay - startOffset + i}</span>
				</c:forEach>

				<%-- 이번 달 날짜 --%>
				<c:set var="calList" value=",${calDays}," />
				<c:forEach var="d" begin="1" end="${lastDay}">
					<c:set var="full" value="${ym}-${d lt 10 ? '0' : ''}${d}" />

					<%-- 이 날짜에 경기가 있는지 확인 --%>
					<c:set var="hasMatch" value="false" />
					<c:forEach var="cm" items="${calMatch}">
						<c:if test="${cm.matchDate.toString() eq full}">
							<c:set var="hasMatch" value="true" />
						</c:if>
					</c:forEach>

					<a href="?ym=${ym}&date=${full}&sport=${sport}"
						class="${hasMatch ? 'has' : ''} ${selectedDate eq full ? 'sel' : ''}">${d}</a>
				</c:forEach>
			</div>
			<p class="legend">
				<span class="legend-dot"></span> 경기 있음
			</p>
		</aside>
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
									showToast("관심경기에 추가!!!!!!!");
								}
								if (result == 'delete') {
									$btn.removeClass("is-on");
									showToast("관심경기에 제거!!!!!!!");
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