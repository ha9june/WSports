<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
  패널티 점수 팀 관리 (adminTeam.jsp) - 담당: 임태균
  피그마: Admin / Clubs / Desktop
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="패널티 점수 팀 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="team" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/adminSideBar.jsp"%>
<div class="admin-inner">
	<p class="eyebrow-path">관리자(사이트)</p>
	<div class="page-head">
		<h1 class="page-title">팀 관리</h1>
		<p class="page-desc">팀 상태를 관리</p>
	</div>
	<div class="kpi-grid three"
		style="grid-template-columns: repeat(3, 1fr); width: var(--settle-w); max-width: 100%;">
		<div class="kpi">
			<p>등록된 팀</p>
			<b>${teamTotalCnt}팀</b>
		</div>
		<div class="kpi">
			<p>패널티 점수 보유</p>
			<b>${teamPenaltyCnt}팀</b>
		</div>
		<div class="kpi">
			<p>활동 정지</p>
			<b>${teamSuspendedCnt}팀</b>
		</div>
	</div>
	<c:set var="status"
		value="${empty param.status ? 'ALL' : param.status}" />
	<h2 class="sub-title" style="margin: 48px 0 7px">팀 목록</h2>
	<p class="page-desc">상태별로 팀을 확인합니다.</p>
	<!-- 주소에 있는 status 값을 꺼내 status에 담음, 값이 없으면 ALL을 대신 넣음 -->
	<form class="list-toolbar" method="get"
	style="display: flex; justify-content: space-between; align-items: center; width: var(--settle-w); max-width: 100%; margin:20px 0 24px; padding: 0">
		<input type="hidden" name="status" value="${status}">

		<%-- 왼쪽: 상태 탭 --%>
		<div class="seg pill neutral"
			style="display: flex; align-items: center; gap: 8px; height: 34px; padding: 0; margin: 0">
			<a class="seg-item ${status eq 'ALL' ? 'is-active' : ''}" style="margin: 0" href="?status=ALL&keyword=${param.keyword}">전체</a>
			<a class="seg-item ${status eq 'PENALTY' ? 'is-active' : ''}" style="margin: 0" href="?status=PENALTY&keyword=${param.keyword}">페널티점수</a>
			<a class="seg-item ${status eq 'LIMITED' ? 'is-active' : ''}" style="margin: 0" href="?status=LIMITED&keyword=${param.keyword}">활동제한</a>
		</div>
	
		<%-- 오른쪽: 검색 --%>
		<div style="display: flex; align-items: center; gap: 6px; height: 34px; margin: 0">
			<input class="input" name="keyword" value="${param.keyword}"
				placeholder="팀명 검색" aria-label="팀명 검색"
					style="width: 220px; height: 34px; margin: 0; font-size: 12px; box-sizing: border-box">
			<button type="submit" class="btn btn-primary btn-sm" style="height: 34px; margin: 0">검색</button>
		</div>
	</form>
	<div style="width: var(--settle-w); max-width: 100%;">
	<div class="tbl-head"
		style="grid-template-columns: minmax(0,1.2fr) minmax(0,1fr) minmax(0,0.5fr) minmax(0,0.8fr) minmax(0,1fr) minmax(0,2.5fr) 100px; justify-items: center; padding: 0 12px; box-sizing: border-box; border: 1px solid transparent">
		<span>팀</span>
		<span>주장</span>
		<span>팀원</span>
		<span>패널티 점수</span>
		<span>팀 정지 상태</span>
		<span>최근 사유</span>
		<span>팀 상세정보</span>
	</div>
	<c:forEach var="t" items="${teamlist}">
		<div class="tbl-row"
			style="grid-template-columns: minmax(0,1.2fr) minmax(0,1fr) minmax(0,0.5fr) minmax(0,0.8fr) minmax(0,1fr) minmax(0,2.5fr) 100px; 
			justify-items: center; padding: 0 12px; box-sizing: border-box">
					<span class="cell-ellipsis" title="${t.team_name}">${t.team_name}</span> 
					<span>${t.nickname.nickname}</span> 
					<span>${t.membercnt}명</span>
					<span>${t.score}점</span> 
					<span class="${t.suspension eq '정상' ? '' : 't-danger'}">${t.suspension }</span>
					<span class="cell-ellipsis" title="${t.reason}">${t.reason}</span> 
					<a class="btn btn-outline btn-xs t-brand"
						href="${ctx}/admin/team/detail?teamId=${t.team_id}">보기</a>
				</div>
			</c:forEach>
			<c:if test="${empty teamlist}">
				<div class="empty-state">
					<div class="empty-icon">
						<svg width="28" height="28" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="2" stroke-linecap="round"
							stroke-linejoin="round" aria-hidden="true">
						<c:choose>
							<c:when test="${not empty param.keyword}">
									<circle cx="11" cy="11" r="7" />
									<path d="m20 20-3.5-3.5" />
								</c:when>
							<c:otherwise>
									<circle cx="9" cy="8" r="3.5" />
									<path d="M2 20c0-3.5 3-5.5 7-5.5s7 2 7 5.5" />
									<path d="M16 4.5a3.5 3.5 0 0 1 0 7M18 14.5c2.4.5 4 2.3 4 5.5" />
								</c:otherwise>
						</c:choose>
					</svg>
					</div>
					<c:choose>
						<c:when test="${not empty param.keyword}">
							<strong>'${param.keyword}' 검색 결과가 없어요</strong>
							<p>팀 이름을 다시 확인해 주세요.</p>
							<a class="btn btn-outline btn-sm" href="?status=${status}">검색
								초기화</a>
						</c:when>
						<c:when test="${status eq 'PENALTY'}">
							<strong>패널티 점수가 있는 팀이 없어요</strong>
							<p>팀 경기 신고 처리로 패널티가 부여되면 여기에 표시됩니다.</p>
							<a class="btn btn-outline btn-sm" href="?status=ALL">전체 팀 보기</a>
						</c:when>
						<c:when test="${status eq 'LIMITED'}">
							<strong>활동 제한된 팀이 없어요</strong>
							<p>패널티 점수가 기준에 도달하면 활동이 제한되어 여기에 표시됩니다.</p>
							<a class="btn btn-outline btn-sm" href="?status=ALL">전체 팀 보기</a>
						</c:when>
						<c:otherwise>
							<strong>등록된 팀이 없어요</strong>
							<p>회원이 팀을 만들면 여기에 목록이 표시됩니다.</p>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
		</div>
		<c:if test="${not empty teamlist}">
			<nav class="pagination" style="display: flex; justify-content: center; padding: 0px; width: var(--settle-w); max-width: 100%">
				<a href="${pageInfo.curPage > 1 ? ctx += '/admin/team?status=' += status += '&keyword=' += param.keyword += '&page=' += (pageInfo.curPage - 1) : '#'}">&lt;</a>
				<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="page">
					<a	href="${ctx}/admin/team?status=${status}&amp;keyword=${param.keyword}&amp;page=${page}"
					class="${pageInfo.curPage eq page ? 'is-active' : ''}">${page}</a>
				</c:forEach>
				<a href="${pageInfo.curPage < pageInfo.allPage ? ctx += '/admin/team?status=' += status += '&keyword=' += param.keyword += '&page=' += (pageInfo.curPage + 1) : '#'}">&gt;</a>
			</nav>
		</c:if>
	</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp"%>
