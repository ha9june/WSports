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
.pen-summary {
	display: flex;
	gap: 16px;
	margin-bottom: 24px;
}

.pen-box {
	flex: 1;
	padding: 20px;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-radius: 16px;
}

.pen-box .label {
	font-size: 13px;
	color: #6b7280;
	margin-bottom: 8px;
}

.pen-box .value {
	font-size: 24px;
	font-weight: 700;
	color: #111;
}

.pen-box .value.danger {
	color: #dc2626;
}

.pen-box .value.ok {
	color: #16a34a;
}

.pen-box .sub {
	margin-top: 8px;
	font-size: 13px;
	color: #6b7280;
}

.pen-table {
	width: 100%;
	border-collapse: collapse;
	background: #fff;
	border: 1px solid #e5e7eb;
	border-radius: 16px;
	overflow: hidden;
}

.pen-table th, .pen-table td {
	padding: 14px 16px;
	font-size: 14px;
	text-align: left;
	border-bottom: 1px solid #f1f2f4;
}

.pen-table th {
	background: #f9fafb;
	color: #6b7280;
	font-weight: 500;
}

.pen-table td.score {
	font-weight: 700;
	white-space: nowrap;
}

/* 관리자가 취소한 패널티 */
.pen-table tr.is-cancelled td {
	color: #9ca3af;
}

.pen-table tr.is-cancelled td.score {
	color: #9ca3af;
	text-decoration: line-through;
}

.pen-badge {
	display: inline-block;
	padding: 2px 10px;
	border-radius: 999px;
	font-size: 12px;
	font-weight: 600;
}

.pen-badge.on {
	background: #fee2e2;
	color: #b91c1c;
}

.pen-badge.off {
	background: #f3f4f6;
	color: #6b7280;
}

.pen-empty {
	text-align: center;
	color: #9ca3af;
	padding: 60px 0;
}

.pen-table td.score {
	font-weight: 700;
	white-space: nowrap;
}

.score.plus {
	color: #dc2626; /* 증가: 빨강 */
}

.score.minus {
	color: #2563eb; /* 감소: 파랑 */
}
</style>

<div class="work-inner full" style="max-width: 1000px">
	<h1 class="section-title">패널티 내역</h1>
	<p class="section-desc">신고 처리로 부과된 패널티 점수와 이용 정지 내역을 확인하세요.</p>

	<div class="pen-summary">
		<div class="pen-box">
			<div class="label">현재 점수</div>
			<div class="value">${empty latestScore ? 0 : latestScore}점</div>

		</div>
		<div class="pen-box">
			<div class="label">이용 상태</div>
			<c:choose>
				<c:when test="${permanent}">
					<div class="value danger">영구 정지</div>
				</c:when>
				<c:when test="${suspended}">
					<div class="value danger">정지 중</div>
					<div class="sub">${fn:substring(fn:replace(suspendEnd, 'T', ' '), 0, 16)}
						까지</div>
				</c:when>
				<c:otherwise>
					<div class="value ok">정상</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<c:if test="${empty penaltyList}">
		<p class="pen-empty">패널티 내역이 없습니다.</p>
	</c:if>

	<c:if test="${not empty penaltyList}">
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
					<tr class="${p.cancelled == 1 ? 'is-cancelled' : ''}">
						<td>${fn:substring(fn:replace(p.receivedAt, 'T', ' '), 0, 16)}</td>
						<td><c:out value="${p.reason}" /></td>
						<td class="score ${p.scoreClass}">${p.scoreText}</td>
						<td><c:choose>
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
	</c:if>
</div>
<%@ include file="/jsp/common/footer.jsp"%>
