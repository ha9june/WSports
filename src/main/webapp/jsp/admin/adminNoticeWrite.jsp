<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  공지사항 작성 (adminNoticeWrite.jsp) - 담당: 임태균
  피그마: Admin / Notice Write / Desktop
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="공지사항 작성" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="notice" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
	<div class="page-head">
		<h1 class="page-title">공지사항 작성</h1>
		<p class="page-desc">제목과 내용을 입력해 사용자 공지사항으로 등록합니다.</p>
	</div>
	<%-- TODO: action 을 공지 등록 서블릿으로 교체 --%>
	<form style="width:820px;max-width:100%" method="post" action="${ctx}/admin/notice/write">
		<h2>공지 제목</h2>
		<input class="input" name="title" required>
		<br>
		<h2>유형</h2>
		<input class="input" name="type" required>
		<br>
		<h1>공지작성</h1>
		<textarea class="textarea" name="content" rows="10" required></textarea>
		<label><input type="checkbox" name="isPinned" > 상단 고정</label>
		<button type="submit" class="btn btn-primary">등록</button>
	</form>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
