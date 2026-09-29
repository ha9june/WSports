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
<nav class="breadcrumb"><a href="${ctx}/jsp/admin/adminNotice.jsp">공지사항 관리</a><span class="sep">›</span><span>공지 수정</span></nav>
<div class="page-head"><h1 class="page-title">공지사항 수정</h1><p class="page-desc">제목과 내용을 입력해 사용자 공지사항으로 수정합니다.</p></div>
<%-- TODO: action 을 공지 수정 서블릿으로 교체 --%>
<form style="width:820px;max-width:100%" method="post" action="${ctx}/jsp/admin/adminNotice.jsp">
  <div class="field"><label class="field-label" for="nTitle">공지 제목</label><input class="input" id="nTitle" name="title" value="결제 시스템 점검 안내" placeholder="공지 제목을 입력해주세요." required></div>
  <div class="field mt-24"><label class="field-label" for="nBody">공지 내용</label><textarea class="textarea" id="nBody" name="content" rows="12" placeholder="공지 내용을 입력해주세요." required>안정적인 서비스 제공을 위해 결제 시스템 점검을 진행합니다. 점검 시간에는 결제 및 환불 기능이 일시 중단됩니다.</textarea></div>
  <div style="display:flex;justify-content:space-between;align-items:center;margin-top:20px">
    <div><p class="t-12 t-bold">게시판 상단 고정</p><p class="t-11 t-2 mt-8">선택하면 등록 후 공지사항 게시판 최상단에 고정됩니다.</p></div>
    <label class="switch"><input type="checkbox" name="pinned" value="Y" checked><span></span></label>
  </div>
  <div class="form-actions"><a class="btn btn-outline" href="${ctx}/jsp/admin/adminNotice.jsp" style="width:110px">취소</a><button type="submit" class="btn btn-primary" style="width:125px">수정 완료</button></div>
</form>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
