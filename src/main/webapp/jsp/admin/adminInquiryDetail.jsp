<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  문의 상세 (adminInquiryDetail.jsp) - 담당: 임태균
  피그마: Admin / Inquiry Detail / Desktop
   state : waiting(답변 작성) | answered(등록된 답변 - 수정 가능)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="문의 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="inquiry" />
<c:set var="demoRoles" value="admin" />
<c:set var="state" value="${empty param.state ? 'waiting' : param.state}" />
<c:set var="demoStates" value="waiting:답변 대기|answered:답변 완료" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/adminSideBar.jsp" %>
<div class="admin-inner">
  <nav class="breadcrumb"><a href="${ctx}/jsp/admin/adminInquiry.jsp">문의 관리</a><span class="sep">›</span><span>문의 상세</span></nav>
  <div class="page-head"><h1 class="page-title">문의 상세</h1></div>
  <%-- TODO: action 을 답변 등록 서블릿으로 교체 --%>
  <form class="admin-card" style="width:800px;max-width:100%" method="post" action="${ctx}/jsp/admin/adminInquiry.jsp">
    <div style="display:flex;justify-content:space-between"><div><p class="t-11 t-2">Q-204 · 결제/신청</p><h2 style="margin:8px 0 0">결제 후 참가 확정이 되지 않아요</h2></div>
      <span class="pill ${state eq 'answered' ? 'pill-success' : 'pill-outline'}">${state eq 'answered' ? '답변 완료' : '답변 대기'}</span></div>
    <dl class="kv1 mt-24"><dt>작성자</dt><dd>매치온 회원 (matchon01)</dd><dt>접수일</dt><dd>2026.09.14 11:20</dd></dl>
    <h3 class="t-12 t-bold mt-24">내용</h3>
    <p class="t-12 mt-8" style="line-height:1.7">오늘 풋살 경기 참가비를 결제했는데 내 경기에서 참가 확정으로 표시되지 않습니다.<br>결제 내역은 정상적으로 보이는데 신청 상태를 확인해주세요.</p>
    <div class="field answer-box"><label class="field-label strong" for="answer">답변</label>
      <textarea class="textarea" id="answer" name="answer" rows="5" placeholder="회원에게 보낼 답변을 입력하세요." required>${state eq 'answered' ? '결제 반영 지연을 확인하여 참가 확정 처리했습니다. 이용에 불편을 드려 죄송합니다.' : ''}</textarea></div>
    <div class="form-actions"><a class="btn btn-outline btn-sm" href="${ctx}/jsp/admin/adminInquiry.jsp">목록으로</a><button type="submit" class="btn btn-primary btn-sm">${state eq 'answered' ? '답변 수정' : '답변 등록'}</button></div>
  </form>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
