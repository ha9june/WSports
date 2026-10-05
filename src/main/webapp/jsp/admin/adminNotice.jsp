<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  공지사항 관리 (adminNotice.jsp) - 담당: 임태균
  피그마: Admin / Notices / Desktop, Admin / Notice Delete / Modal
   state : default | deleteModal(삭제 확인 모달)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="공지사항 관리" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="notice" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'default' : param.state}" />
<c:set var="demoStates" value="default:기본|deleteModal:삭제 모달" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
	<p class="eyebrow-path">관리자(사이트)</p>
	<div class="page-head">
		<h1 class="page-title">공지사항 관리</h1>
		<p class="page-desc">사용자에게 노출되는 공지사항을 작성하고 관리합니다.</p>
	</div>
  	<div class="row-list" style="width:760px;max-width:100%">
    	<c:forTokens var="row" delims="|" items="N-018^결제 시스템 점검 안내^2026.09.14^Y|N-017^추석 연휴 고객센터 운영 안내^2026.09.12^N|N-016^서비스 이용약관 변경 안내^2026.09.01^N">
      		<c:set var="n" value="${fn:split(row, '^')}" />
      		<div class="row-card">
        		<span class="t-11 t-2" style="width:50px">${n[0]}</span>
        		<div style="flex:1">
        			<a class="title" href="${ctx}/jsp/support/noticeDetail.jsp">${n[1]}</a>
        			<p class="meta">관리자(사이트) · ${n[2]}</p>
        		</div>
        		<c:if test="${n[3] eq 'Y'}">
        			<span class="pill pill-brand">📌 상단 고정</span>
        		</c:if>
        		<a class="btn btn-outline btn-xs" href="${ctx}/jsp/admin/adminNoticeModify.jsp">수정</a>
        		<button type="button" class="btn btn-danger btn-xs" data-modal-open="noticeDeleteModal" style="width:60px">삭제</button>
      		</div>
    	</c:forTokens>
  	</div>
</div>
</main></div>
<a class="fab" href="${ctx}/jsp/admin/adminNoticeWrite.jsp">
	<span class="fab-label">공지 작성</span>
	<span class="fab-btn" aria-hidden="true"></span>
</a>
<div class="modal ${state eq 'deleteModal' ? 'is-open' : ''}" id="noticeDeleteModal" role="dialog" aria-modal="true">
	<div class="modal-card sm">
  		<h2 class="modal-title">공지사항을 삭제할까요?</h2>
  		<p class="modal-desc">삭제한 공지는 사용자 화면에서 바로 사라지며 복구할 수 없습니다.</p>
  		<div class="modal-actions">
  			<button type="button" class="btn btn-outline" data-modal-close>취소</button>
  			<button type="button" class="btn btn-danger" data-toast="공지사항을 삭제했어요.">삭제</button>
  		</div>
  	</div>
</div>
<%@ include file="/jsp/common/footer.jsp" %>
