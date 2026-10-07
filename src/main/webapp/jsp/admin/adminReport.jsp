<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--
  신고 관리 (adminReport.jsp) - 담당: 임태균
  피그마: Admin / Reports / Member Tab · Post Tab
   state : member(회원 신고 탭) | post(게시글 신고 탭)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="신고 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="report" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'member' : param.state}" />
<c:set var="demoStates" value="member:회원 신고|post:게시글 신고" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
	<p class="eyebrow-path">관리자(사이트)</p>
	<div class="page-head">
		<h1 class="page-title">신고 관리</h1>
	</div>
	<!-- 주소에 있는 status 값을 꺼내 status에 담음, 값이 없으면 ALL을 대신 넣음 -->
	<c:set var="status" value="${empty param.status ? 'ALL' : param.status}" />
	<form class="list-toolbar" method="get" style="flex-direction: column; align-items: flex-start; gap: 20px; margin-bottom: 24px">
		<div style="width:860px;max-width:100%">
			<nav class="tabs big">
				<a class="tab ${status eq 'ALL' ? 'is-active' : ''}" href="?status=ALL">전체</a>
				<a class="tab ${status eq 'WAIT' ? 'is-active' : ''}" href="?status=WAIT">처리대기</a>
				<a class="tab ${status eq 'DONE' ? 'is-active' : ''}" href="?status=DONE">처리완료</a>
			</nav>
		</div>
	</form>
	
	<div style="width:fit-content; max-width:100%">
    	<div class="tbl-head" style="grid-template-columns:70px 70px 100px 100px 200px 100px 100px;
    	justify-self: start; justify-items: center; padding-left: 0px">
    		<span>신고번호</span>
    		<span>신고날짜</span>
    		<span>신고유형</span>
    		<span>신고자</span>
    		<span>신고제목</span>
    		<span>상태</span>
    		<span>신고 상세정보</span>
    	</div>
		<c:forEach var="r" items="${reportlist}">
			<div class="tbl-row" href="${ctx}/admin/report/detail?reportId=${r.report_id}"
		   	style="grid-template-columns: 70px 70px 100px 100px 200px 100px 100px; 
		   	justify-items: center; padding-left: 0px">
				<span>${r.report_id }</span>
				<b><fmt:formatDate value="${r.created_at}" pattern="M/dd" /></b>
				<span>${r.type}</span>
				<span>${r.nickname}</span>
				<span>${r.title}</span>
				<span class="pill ${r.status eq '처리완료' ? 'pill-neutral' : 'pill-warning bd'}">${r.status}</span>
				<a class="btn btn-outline btn-xs t-brand" href="${ctx}/admin/report/detail?reportId=${r.report_id}">보기</a>
			</div>
		</c:forEach>
		<nav class="pagination" style="display: flex; justify-content:center; padding:0px">
			<a href="${pageInfo.curPage > 1 ? ctx += '/admin/report?status=' += status += '&page=' += (pageInfo.curPage - 1) : '#'}">&lt;</a>
			<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="page">
				<a href="${ctx}/admin/report?status=${status}&amp;page=${page}" class="${pageInfo.curPage eq page ? 'is-active' : ''}">${page}</a>
			</c:forEach>
			<a href="${pageInfo.curPage < pageInfo.allPage ? ctx += '/admin/report?status=' += status +=  '&page=' += (pageInfo.curPage + 1) : '#'}">&gt;</a>
		</nav>
	</div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
