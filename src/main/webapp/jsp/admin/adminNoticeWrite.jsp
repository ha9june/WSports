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
		<div class="field">
			<label class="field-label" for="nTitle">공지 제목</label>
			<input class="input" id="nTitle" name="title" required>
		</div>
		<div class="field mt-24">
			<label class="field-label" for="nType">유형</label>
			<input class="input" id="nType" name="type" required>
		</div>
		<div class="field mt-24">
			<label class="field-label" for="nBody">공지 내용</label>
			<textarea class="textarea" id="nBody" name="content" rows="12" required>${detail.content}</textarea>
		</div>
			<%-- 상단 고정 --%>
		<div style="display:flex; justify-content:space-between; align-items:center; margin-top:20px; padding:16px 18px; border:1px solid var(--ds-border); border-radius:var(--r-12); background:#fff">
			<div>
				<p class="t-12 t-bold">📌 게시판 상단 고정</p>
				<p class="t-11 t-2 mt-8">켜두면 공지사항 목록 맨 위에 고정돼요.</p>
			</div>
			<label class="switch">
				<input type="checkbox" name="isPinned">
				<span></span>
			</label>
		</div>
		<div class="form-actions">
			<button type="submit" class="btn btn-primary" style="width:125px">등록</button>
		</div>
	</form>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
