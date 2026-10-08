<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  공지사항 수정 (adminNoticeModify.jsp) - 담당: 임태균
  피그마: Admin / Notice Edit / Desktop
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="공지사항 수정" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="notice" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
<nav class="breadcrumb">
	<a href="${ctx}/admin/notice">공지사항 관리</a>
	<span>공지 수정</span>
</nav>
<div class="page-head">
	<h1 class="page-title">공지사항 수정</h1>
	<p class="page-desc">제목과 내용을 수정합니다.</p>
</div>
<form style="width:820px;max-width:100%" method="post" action="${ctx}/admin/notice/modify">
	<input type="hidden" name="noticeId" value="${detail.notice_id}">
	<div class="field">
		<label class="field-label" for="nTitle">공지 제목</label>
		<input class="input" id="nTitle" name="title" value="${detail.title}" required>
	</div>
	<div class="field mt-24">
		<label class="field-label" for="nType">유형</label>
		<select class="notice-type" id="nType" name="type">
			<option value="공지">공지</option>
			<option value="정책">정책</option>
			<option value="점검">점검</option>
			<option value="이벤트">이벤트</option>
			<option value="업데이트">업데이트</option>
		</select>
	</div>
	<div class="field mt-24">
		<label class="field-label" for="nBody">공지 내용</label>
		<textarea class="textarea" id="nBody" name="content" rows="12" required>${detail.content}</textarea>
	</div>
	<div class="form-actions">
		<a class="btn btn-outline" href="${ctx}/admin/notice" style="width:110px">취소</a>
		<button type="submit" class="btn btn-primary" style="width:125px">수정 완료</button>
	</div>
</form>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function(){
	$("#nType").val('${detail.type}');
});
</script>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
