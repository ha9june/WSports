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
  레이아웃: 다른 마이페이지 목록과 같은 .mp-body 틀 (폭·제목 28px·설명 13px)
  스타일: mypage.css 의 "패널티 내역" 구역 (.pen-*)
--%>
<c:set var="pageTitle" value="패널티 내역" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="penalty" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/mypageSideBar.jsp"%>

<div class="work-inner mp-body">
	<h1 class="section-title">패널티 내역</h1>
	<p class="section-desc">신고 처리로 부과된 패널티 점수와 이용 정지 내역을 확인하세요.</p>

	<c:set var="pt" value="${empty latestScore ? 0 : latestScore}" />
	<div class="pen-summary">
		<div class="pen-box">
			<p class="label">현재 점수</p>
			<p class="value">${pt}<small>점</small></p>
			<div class="pen-bar ${pt >= 100 ? 'danger' : (pt >= 70 ? 'warn' : '')}">
				<span style="width: ${pt > 100 ? 100 : pt}%"></span>
			</div>
			<p class="sub">100점 이상이면 영구정지 검토 대상이에요.</p>
		</div>
		<div class="pen-box">
			<p class="label">이용 상태</p>
			<c:choose>
				<c:when test="${permanent}">
					<p class="value danger">영구 정지</p>
					<p class="sub">서비스를 이용할 수 없어요.</p>
				</c:when>
				<c:when test="${suspended}">
					<p class="value danger">정지 중</p>
					<p class="sub">${fn:substring(fn:replace(suspendEnd, 'T', ' '), 0, 16)} 까지</p>
				</c:when>
				<c:otherwise>
					<p class="value ok">정상</p>
					<p class="sub">현재 이용 제한이 없어요.</p>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<c:if test="${empty penaltyList}">
		<p class="pen-empty">패널티 내역이 없어요.</p>
	</c:if>

	<c:if test="${not empty penaltyList}">
		<h2 class="pen-list-title">패널티 이력 <em>${fn:length(penaltyList)}건</em></h2>
		<div class="pen-table-wrap">
			<table class="pen-table">
				<thead>
					<tr>
						<th>받은 일시</th>
						<th>사유</th>
						<th>점수</th>
						<th>정지 기간</th>
						<th class="center">상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="p" items="${penaltyList}">
						<c:set var="rcv" value="${fn:replace(p.receivedAt, 'T', ' ')}" />
						<tr class="${p.cancelled == 1 ? 'is-cancelled' : ''}">
							<td class="pen-date"><b>${fn:substring(rcv, 0, 10)}</b><span>${fn:substring(rcv, 11, 16)}</span></td>
							<td class="pen-reason"><c:out value="${p.reason}" /></td>
							<td><span class="score-chip ${p.scoreClass}">${p.scoreText}</span></td>
							<td class="pen-period">
								<c:choose>
									<c:when test="${p.permanentSuspension == 1}">영구 정지</c:when>
									<c:when test="${not empty p.suspensionEnd}">
										${fn:substring(fn:replace(p.suspensionStart, 'T', ' '), 0, 10)}
										~ ${fn:substring(fn:replace(p.suspensionEnd, 'T', ' '), 0, 10)}
									</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose>
							</td>
							<td class="center">
								<c:choose>
									<c:when test="${p.cancelled == 1}"><span class="pill pill-neutral pen-status">취소됨</span></c:when>
									<c:otherwise><span class="pill pill-brand pen-status">적용</span></c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:if>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp"%>
