<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="회원 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="member" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/adminSideBar.jsp"%>
<div class="admin-inner">
	<p class="eyebrow-path">관리자(사이트)</p>
	<div class="page-head">
		<h1 class="page-title">회원 관리</h1>
		<p class="page-desc">회원 상태와 제재 이력을 확인합니다.</p>
	</div>
	<c:set var="status" value="${empty param.status ? 'ALL' : param.status}" />
	<form class="list-toolbar" method="get"
		style="align-items: flex-end; gap: 20px; margin-bottom: 24px">
		<input type="hidden" name="status" value="${status}">
		<div class="field" style="width: 280px">
			<label class="field-label">검색</label>
			<div style="display: flex; gap: 8px">
				<input class="input" name="keyword" value="${param.keyword}">
				<button type="submit" class="btn btn-primary">검색</button>
			</div>
		</div>

		<div class="seg pill neutral">
			<a class="seg-item ${status eq 'ALL' ? 'is-active' : ''} "href="?status=ALL">전체</a> 
			<a class="seg-item ${status eq 'NORMAL' ? 'is-active' : ''} "href="?status=NORMAL">정상</a> 
			<a class="seg-item ${status eq 'SUSPENDED' ? 'is-active' : ''} "href="?status=SUSPENDED">정지</a> 
			<a class="seg-item ${status eq 'PENALTY' ? 'is-active' : ''} "href="?status=PENALTY">패널티점수</a>
		</div>
	</form>
	<div style="width: 860px; max-width: 100%">
		<div class="tbl-head"
			style="grid-template-columns: 160px 160px 100px 100px">
			<span>로그인 아이디</span> <span>닉네임</span> <span>회원 상태</span> <span>패널티
				점수</span>
		</div>
	</div>

	<c:forEach var="m" items="${memberlist}">
		<div class="settle-row"
			style="grid-template-columns: 160px 160px 100px 100px 100px">
			<strong>${m.login_id}</strong>
			<p>${m.nickname}</p>
			<span class="${m.suspended ? 't-danger' : '' }">${m.suspended ? '정지' : '정상'}</span>
			<strong>${empty m.score ? 0 : m.score}</strong> <a
				class="btn btn-outline btn-xs t-brand"
				href="${ctx}/admin/member/detail?userId=${m.user_id}">보기</a>
		</div>

	</c:forEach>

	<nav class="pagination">
		<a href="${pageInfo.curPage > 1 ? ctx += '/admin/member?status=' += status += '&keyword=' += param.keyword += '&page=' += (pageInfo.curPage - 1) : '#'}">&lt;</a>

		<c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="page">
			<a href="${ctx}/admin/member?status=${status}&amp;keyword=${param.keyword}&amp;page=${page}"
				class="${pageInfo.curPage eq page ? 'is-active' : ''}">${page}</a>
		</c:forEach>
		<a href="${pageInfo.curPage < pageInfo.allPage ? ctx += '/admin/member?status=' += status += '&keyword=' += param.keyword += '&page=' += (pageInfo.curPage + 1) : '#'}">&gt;</a>
	</nav>
</div>

<%@ include file="/jsp/common/footer.jsp"%>
