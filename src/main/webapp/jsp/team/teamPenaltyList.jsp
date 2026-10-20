<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/jsp/common/init.jsp"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--
  팀 패널티 내역 (teamPenaltyList.jsp)
  서블릿에서 넘겨받는 값
   - teamName    : 팀 이름
   - penaltyList : team_penalty 이력 (receivedAt, score, reason, suspensionStart,
                   suspensionEnd, permanentSuspension, cancelled, scoreText, scoreClass)
   - totalPoint  : 현재 팀 패널티 점수
   - suspended   : 현재 정지 여부 (true/false)
   - permanent   : 영구 정지 여부 (true/false)
   - suspendEnd  : 현재 정지 종료일
  요청 파라미터: teamId
--%>
<c:set var="pageTitle" value="${teamName} 패널티 내역" />
<c:set var="pageCss" value="match,team" />
<c:set var="activeNav" value="team" />
<%@ include file="/jsp/common/header.jsp"%>

<c:url var="detailUrl" value="/team/detail/view">
	<c:param name="teamId" value="${param.teamId}" />
</c:url>

<main class="page">
	<div class="container">
		<nav class="breadcrumb">
			<a href="${ctx}/team/list">팀</a><span class="sep">›</span>
			<a href="${detailUrl}"><c:out value="${teamName}" /></a>
				<span class="sep">›</span>
				<a href="${ctx}/team/manage/applications?teamId=${param.teamId}">관리</a>
		</nav>
		
		<div class="page-head">
			<h1 class="page-title">팀 관리</h1>
			<p class="page-desc">가입 신청, 팀원, 팀 작성글 관리,팀 패널티 내역을 한 화면에서 전환합니다.</p>
		</div>
		<c:set var="lockCls" value="${isManager ? '' : 'locked'}" />
		<nav class="tabs">
			<a class="tab ${lockCls}"
				href="${ctx}/team/manage/applications?teamId=${param.teamId}">가입
				신청</a> <a class="tab ${lockCls}"
				href="${ctx}/team/manage/members?teamId=${param.teamId}">팀원 관리</a> <a
				class="tab ${lockCls}"
				href="${ctx}/team/manage/posts?teamId=${param.teamId}">팀 작성글 관리</a>
			<a class="tab is-active"
				href="${ctx}/team/penalty?teamId=${param.teamId}">팀 패널티 내역</a>
		</nav>

		<section class="team-section team-pen">
			<div class="pen-head">
				<h2>팀 패널티 내역</h2>
				<p>
					<c:out value="${teamName}" />
					팀에 부과된 패널티 점수와 이용 정지 내역을 확인하세요.
				</p>
			</div>

			<c:set var="pt" value="${empty totalPoint ? 0 : totalPoint}" />
			<div class="pen-summary">
				<div class="pen-box">
					<div class="label">현재 점수</div>
					<div class="value">${pt}<small>점</small>
					</div>
					<div
						class="pen-bar ${pt >= 100 ? 'danger' : (pt >= 70 ? 'warn' : '')}">
						<span style="width: ${pt > 100 ? 100 : pt}%"></span>
					</div>
					<div class="sub">100점 이상이면 영구정지 검토 대상이에요.</div>
				</div>
				<div class="pen-box">
					<div class="label">이용 상태</div>
					<c:choose>
						<c:when test="${permanent}">
							<div class="value danger">영구 정지</div>
							<div class="sub">경기에 참가할 수 없어요.</div>
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
									<td class="pen-date">${fn:substring(rcv, 0, 10)}<span>${fn:substring(rcv, 11, 16)}</span></td>
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
		</section>
	</div>
</main>
<%@ include file="/jsp/common/footer.jsp"%>