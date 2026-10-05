<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<%--
  관심경기 (myPageHeartMatch.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Saved Matches / Desktop
  목록은 종목·상태 필터와 월 달력으로 조회합니다.
  TODO: 아래 act-card 를 <c:forEach var="m" items="${matchList}"> 로 반복 (날짜별 그룹 헤더 포함)
--%>
<c:set var="pageTitle" value="관심경기" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="heartMatch" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<style>
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
	<h1 class="section-title">관심경기</h1>
	<p class="section-desc">관심 표시한 경기를 종목, 상태와 월별 달력으로 확인하세요.</p>
	<form class="act-filters" method="get" id="periodForm">
			<input type="text" id="periodPicker" class="input" placeholder="기간 선택" readonly> 
			<input type="hidden" id="startDate" name="startDate" value="${startDate}">
			<input type="hidden" id="endDate" name="endDate" value="${endDate}">
		
		<!-- 경기 종목별 리스트 검색 -->
		<select class="select" name="sport" onchange="this.form.submit()">
			<option value="">전체</option>
			<option value="축구/풋살" ${sport == '축구/풋살' ? 'selected' : ''}>축구/풋살</option>
			<option value="농구" ${sport == '농구' ? 'selected' : ''}>농구</option>
			<option value="테니스" ${sport == '테니스' ? 'selected' : ''}>테니스</option>
			<option value="배드민턴" ${sport == '배드민턴' ? 'selected' : ''}>배드민턴</option>
		</select>
		<select class="select" name="status" onchange="this.form.submit()">
			<option value="">전체 상태</option>
			<option value="모집중" ${status == '모집중' ? 'selected' : ''}
				style="background-color: #e6f7ed; color: #1f874c; font-weight: bold;">모집중</option>
			<option value="모집 마감" ${status == '모집 마감' ? 'selected' : ''}>모집 마감</option>
			<option value="경기 종료" ${status == '경기 종료' ? 'selected' : ''}>경기 종료</option>
			<option value="경기 취소" ${status == '경기 취소' ? 'selected' : ''}>경기 취소</option>
		</select>
	</form>


	<div class="act-layout">
		<section>
			<div class="act-head"></div>
			<div class="list-head">
				<h2>관심경기 ${fn:length(match)}건</h2>
				<a class="btn-reset" href="?">필터 초기화</a>
			</div>
			<c:if test="${empty match}">
				<p class="empty-msg">관심 경기가 없습니다.</p>
			</c:if>
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
							<!-- 관심경기 제거 -->
							<button type="button" class="fav-btn is-on"
								data-match-id="${m.personalMatchId}" data-match-type="Personal"
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
		<script>
			$(function() {
				flatpickr('#periodPicker', {
					mode : 'range',
					locale : 'ko',
					dateFormat : 'Y-m-d',
					disableMobile : true,
					defaultDate : [ '${startDate}', ?['${startDate}':'${endDate}']:null,
					onClose : function(selectedDates, dateStr, instance) {
						if (selectedDates.length === 2) {
							$('#startDate').val(
									instance.formatDate(selectedDates[0],
											'Y-m-d'));
							$('#endDate').val(
									instance.formatDate(selectedDates[1],
											'Y-m-d'));
							$('#periodForm').submit();
						}
					}
				});
			});
		</script>
		<script>
			$(function() {
				$(".fav-btn").click(
						function(e) {
							e.stopPropagation();
							var $btn = $(this);
							$.ajax({
								url : '${ctx}/mypage/matches/saved',
								type : 'post',
								dataType : 'text',
								data : {
									matchId : $btn.data("matchId"),
									matchType : $btn.data("matchType"),
									heart : $btn.hasClass("is-on")
								},
								success : function(result) {
									result = result.trim();
									if (result == 'delete') {
										$btn.closest('.act-card').fadeOut(200,
												function() {
													$(this).remove();
												});
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
