<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/jsp/common/init.jsp"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--
  패널티 내역 (myPagePenalty.jsp)
  신고 처리 알림 링크로 들어오는 화면: 누적 점수 / 이용 상태 / 패널티 이력
  서블릿에서 넘겨받는 값
   - penaltyList : user_penalty 이력 (receivedAt, score, reason, suspensionStart,
                   suspensionEnd, permanentSuspension, cancelled)
   - totalPoint  : 누적 패널티 점수 (취소된 건 제외)
   - suspended   : 현재 정지 여부 (true/false)
   - permanent   : 영구 정지 여부 (true/false)
   - suspendEnd  : 현재 정지 종료일 (영구 정지/정상이면 비어 있음)
--%>
<c:set var="pageTitle" value="패널티 내역" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="penalty" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>
<style>
/* 요약 카드 */
.pen-summary {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 16px;
	margin-bottom: 28px;
}

.pen-box {
	padding: 22px 24px;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-radius: 16px;
}

.pen-box .label {
	font-size: 13px;
	font-weight: 600;
	color: #6b7280;
}

.pen-box .value {
	margin-top: 10px;
	font-size: 32px;
	font-weight: 800;
	line-height: 1.1;
	color: #111827;
}

.pen-box .value small {
	margin-left: 2px;
	font-size: 16px;
	font-weight: 600;
	color: #6b7280;
}

.pen-box .value.danger {
	color: #dc2626;
}

.pen-box .value.ok {
	color: #16a34a;
}

.pen-box .sub {
	margin-top: 12px;
	font-size: 13px;
	color: #6b7280;
}

/* 점수 게이지 */
.pen-bar {
	height: 8px;
	margin-top: 16px;
	background: #eef2f7;
	border-radius: 999px;
	overflow: hidden;
}

.pen-bar span {
	display: block;
	height: 100%;
	border-radius: 999px;
	background: #1a6bff;
}

.pen-bar.warn span {
	background: #f59e0b;
}

.pen-bar.danger span {
	background: #dc2626;
}

/* 내역 */
.pen-list-title {
	display: flex;
	align-items: center;
	gap: 8px;
	margin: 0 0 12px;
	font-size: 17px;
	font-weight: 800;
	color: #111827;
}

.pen-list-title em {
	padding: 2px 10px;
	border-radius: 999px;
	font-style: normal;
	font-size: 12px;
	font-weight: 700;
	background: #eef4ff;
	color: #1a6bff;
}

.pen-table-wrap {
	background: #fff;
	border: 1px solid #e5e7eb;
	border-radius: 16px;
	overflow-x: auto;
}

.pen-table {
	width: 100%;
	min-width: 640px;
	border-collapse: collapse;
}

.pen-table th, .pen-table td {
	padding: 15px 20px;
	font-size: 14px;
	text-align: left;
	vertical-align: middle;
	border-bottom: 1px solid #f1f2f4;
}

.pen-table th {
	background: #f9fafb;
	color: #6b7280;
	font-size: 13px;
	font-weight: 600;
	white-space: nowrap;
}

.pen-table tbody tr:last-child td {
	border-bottom: 0;
}

.pen-table tbody tr:hover td {
	background: #fafbfc;
}

.pen-date {
	white-space: nowrap;
	color: #111827;
	font-weight: 600;
}

.pen-date span {
	display: block;
	font-size: 12px;
	font-weight: 500;
	color: #9ca3af;
}

.pen-reason {
	max-width: 300px;
	color: #374151;
	word-break: break-all;
}

.pen-period {
	white-space: nowrap;
	color: #6b7280;
}

/* 점수 배지 */
.score-chip {
	display: inline-block;
	min-width: 52px;
	padding: 4px 12px;
	border-radius: 999px;
	font-size: 13px;
	font-weight: 700;
	text-align: center;
	background: #f3f4f6;
	color: #6b7280;
}

.score-chip.plus {
	background: #fee2e2;
	color: #b91c1c; /* 증가: 빨강 */
}

.score-chip.minus {
	background: #dbeafe;
	color: #1d4ed8; /* 감소: 파랑 */
}

/* 상태 배지 */
.pen-badge {
	display: inline-block;
	padding: 4px 12px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 600;
}

.pen-badge.on {
	background: #eef4ff;
	color: #1a6bff;
}

.pen-badge.off {
	background: #f3f4f6;
	color: #9ca3af;
}

/* 관리자가 취소한 패널티 */
.pen-table tr.is-cancelled td {
	color: #9ca3af;
}

.pen-table tr.is-cancelled .pen-date, .pen-table tr.is-cancelled .pen-reason
	{
	color: #9ca3af;
}

.pen-table tr.is-cancelled .score-chip {
	background: #f3f4f6;
	color: #9ca3af;
	text-decoration: line-through;
}

.pen-empty {
	padding: 64px 0;
	text-align: center;
	color: #9ca3af;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-radius: 16px;
}

@media ( max-width : 640px) {
	.pen-summary {
		grid-template-columns: 1fr;
	}
}
</style>

<div class="work-inner full" style="max-width: 1000px">
	<h1 class="section-title">패널티 내역</h1>
	<p class="section-desc">신고 처리로 부과된 패널티 점수와 이용 정지 내역을 확인하세요.</p>

	<c:set var="pt" value="${empty latestScore ? 0 : latestScore}" />
	<div class="pen-summary">
		<div class="pen-box">
			<div class="label">현재 점수</div>
			<div class="value">${pt}<small>점</small>
			</div>
			<div class="pen-bar ${pt >= 100 ? 'danger' : (pt >= 70 ? 'warn' : '')}">
				<span style="width: ${pt > 100 ? 100 : pt}%"></span>
			</div>
			<div class="sub">100점 이상이면 영구정지 검토 대상이에요.</div>
		</div>
		<div class="pen-box">
			<div class="label">이용 상태</div>
			<c:choose>
				<c:when test="${permanent}">
					<div class="value danger">영구 정지</div>
					<div class="sub">서비스를 이용할 수 없어요.</div>
				</c:when>
				<c:when test="${suspended}">
					<div class="value danger">정지 중</div>
					<div class="sub">${fn:substring(fn:replace(suspendEnd, 'T', ' '), 0, 16)}
						까지</div>
				</c:when>
				<c:otherwise>
					<div class="value ok">정상</div>
					<div class="sub">현재 이용 제한이 없어요.</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<c:if test="${empty penaltyList}">
		<p class="pen-empty">패널티 내역이 없습니다.</p>
	</c:if>

	<c:if test="${not empty penaltyList}">
		<h3 class="pen-list-title">
			패널티 내역 <em>${fn:length(penaltyList)}건</em>
		</h3>
		<div class="pen-table-wrap">
			<table class="pen-table">
				<thead>
					<tr>
						<th>받은 일시</th>
						<th>사유</th>
						<th>점수</th>
						<th>정지 기간</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="p" items="${penaltyList}">
						<c:set var="rcv" value="${fn:replace(p.receivedAt, 'T', ' ')}" />
						<tr class="${p.cancelled == 1 ? 'is-cancelled' : ''}">
							<td class="pen-date">${fn:substring(rcv, 0, 10)} <span>${fn:substring(rcv, 11, 16)}</span></td>
							<td class="pen-reason"><c:out value="${p.reason}" /></td>
							<td><span class="score-chip ${p.scoreClass}">${p.scoreText}</span></td>
							<td class="pen-period"><c:choose>
									<c:when test="${p.permanentSuspension == 1}">영구 정지</c:when>
									<c:when test="${not empty p.suspensionEnd}">
										${fn:substring(fn:replace(p.suspensionStart, 'T', ' '), 0, 10)}
										~ ${fn:substring(fn:replace(p.suspensionEnd, 'T', ' '), 0, 10)}
									</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose></td>
							<td><c:choose>
									<c:when test="${p.cancelled == 1}">
										<span class="pen-badge off">취소됨</span>
									</c:when>
									<c:otherwise>
										<span class="pen-badge on">적용</span>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:if>
</div>
<%@ include file="/jsp/common/footer.jsp"%>
