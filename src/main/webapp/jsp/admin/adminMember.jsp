<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  회원 관리 (adminMember.jsp) - 담당: 임태균
  피그마: Admin / Members / Desktop
  TODO: <c:forEach var="m" items="${memberList}">, 상태 필터는 ?status=NORMAL|SUSPENDED|BANNED
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="회원 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="member" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
	<p class="eyebrow-path">관리자(사이트)</p>
  	<div class="page-head">
  		<h1 class="page-title">회원 관리</h1>
  		<p class="page-desc">회원 상태와 제재 이력을 확인합니다.</p>
  	</div>
  	<form class="list-toolbar" method="get" style="align-items:flex-end;gap:20px;margin-bottom:24px">
    	<div class="field" style="width:280px">
    		<label class="field-label">검색</label>
    		<input class="input" name="keyword"><!-- 아이디 닉네임 -->
    	</div>
    	<div class="seg pill neutral">
    		<a class="seg-item is-active" href="?">전체</a>
    		<a class="seg-item" href="?status=NORMAL">정상</a>
    		<a class="seg-item" href="?status=SUSPENDED">정지</a>
    		<a class="seg-item" href="?status=BANNED">영구정지</a>
    		<a class="seg-item" href="?status=BANNED">패널티점수</a>
    	</div>
  	</form>
  	<div style="width:860px;max-width:100%">
    	<div class="tbl-head" style="grid-template-columns:160px 160px 100px 1fr">
    		<span>로그인 아이디</span>
    		<span>닉네임</span>
    		<span>회원 상태</span>
    		<span>패널티 점수</span>
    	</div>
    	<div class="tbl-body">
    		<a class="tbl-row" href="${ctx}/jsp/admin/adminMemberDetail.jsp?state=normal" style="grid-template-columns:160px 160px 100px 1fr">
      			<b>matchon01</b>
      			<b>매치온 회원</b>
      			<b>정상</b>
      			<span class="t-2">0점</span>
      		</a>
      		<a class="tbl-row" href="${ctx}/jsp/admin/adminMemberDetail.jsp?state=normal" style="grid-template-columns:160px 160px 100px 1fr">
      			<b>player22</b>
      			<b>풋살초보</b>
      			<b>정상</b>
      			<span class="t-2">2점</span>
      		</a>
      		<a class="tbl-row" href="${ctx}/jsp/admin/adminMemberDetail.jsp?state=suspended" style="grid-template-columns:160px 160px 100px 1fr">
      			<b>baduser7</b>
      			<b>노쇼반복</b>
      			<b class="t-danger">정지</b>
      			<span class="t-2">12점</span>
      		</a>
    	</div>
    	<nav class="pagination">
    		<a href="#">‹</a>
    		<a href="#" class="is-active">1</a>
    		<a href="#">2</a>
    		<a href="#">›</a>
    	</nav>
  	</div>
</div>

<%@ include file="/jsp/common/footer.jsp" %>
