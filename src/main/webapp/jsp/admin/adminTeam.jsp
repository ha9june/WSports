<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  패널티 점수 팀 관리 (adminTeam.jsp) - 담당: 임태균
  피그마: Admin / Clubs / Desktop
  TODO: <c:forEach var="t" items="${penaltyTeamList}">
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="패널티 점수 팀 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="team" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
	<p class="eyebrow-path">관리자(사이트)</p>
  	<div class="page-head">
  		<h1 class="page-title">팀 관리</h1>
  		<p class="page-desc">팀 상태를 관리</p>
  	</div>
  	<div class="kpi-grid three">
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
  	<c:set var="status" value="${empty param.status ? 'ALL' : param.status}" /><!-- 주소에 있는 status 값을 꺼내 status에 담음, 값이 없으면 ALL을 대신 넣음 -->
  	<form class="list-toolbar" method="get" style="flex-direction: column; align-items: flex-start; margin-top: 24px; margin-bottom: 24px">
  		<input type="hidden" name="status" value="${status}">
  			<div class="field" style="width: 280px">
  				<label class="field-label">팀명 검색</label>
  				<div style="display: flex; gap: 8px">
    				<input class="input" name="keyword" value="${param.keyword}">
    				<button type="submit" class="btn btn-primary">검색</button>
    			</div>
    		</div>
    		<div>
    			<div class="seg pill neutral" style="padding-left:0">
   					<a class="seg-item ${status eq 'ALL' ? 'is-active' : ''}" href="?status=ALL">전체</a>
   					<a class="seg-item ${status eq 'PENALTY' ? 'is-active' : ''}" href="?status=PENALTY">페널티점수</a>
   					<a class="seg-item ${status eq 'LIMITED' ? 'is-active' : ''}" href="?status=LIMITED">활동제한</a>
   				</div>
    		</div>	
	</form>

	<div style="width: fit-content;max-width:100%">
   		<div class="tbl-head" style="grid-template-columns:repeat(7, 100px); justify-self: start; justify-items: center; padding-left: 0px">
   			<span>팀</span>
   			<span>주장</span>
   			<span>팀원</span>
   			<span>패널티 점수</span>
   			<span>팀 정지 상태</span>
   			<span>최근 사유</span>
   			<span>상세</span>
		</div>
		<c:forEach var="t" items="${teamlist}">
   			<div class="tbl-body">
  				<div class="tbl-row" style="grid-template-columns:repeat(7, 100px); justify-self: start; justify-items: center; padding-left: 0px">
   					<span>${t.team_name}</span>
   					<span>${t.nickname.nickname}</span>
   					<span>${t.membercnt}명</span>
   					<span>${t.score}점</span>
   					<span class="${t.suspension eq '정상' ? '' : 't-danger'}">${t.suspension }</span>
   					<span>${t.reason}</span>
   					<a class="btn btn-outline btn-xs t-brand" href="${ctx}/admin/team/detail?teamId=${t.team_id}">상세</a>
   				</div>
   			</div>
   		</c:forEach>
   		<nav class="pagination" style="display: flex; justify-content:center; padding:0px">
			<a href="${pageInfo.curPage > 1 ? ctx += '/admin/team?status=' += status += '&keyword=' += param.keyword += '&page=' += (pageInfo.curPage - 1) : '#'}">&lt;</a>
			<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="page">
				<a href="${ctx}/admin/team?status=${status}&amp;keyword=${param.keyword}&amp;page=${page}" class="${pageInfo.curPage eq page ? 'is-active' : ''}">${page}</a>
			</c:forEach>
			<a href="${pageInfo.curPage < pageInfo.allPage ? ctx += '/admin/team?status=' += status += '&keyword=' += param.keyword += '&page=' += (pageInfo.curPage + 1) : '#'}">&gt;</a>
		</nav>
	</div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
