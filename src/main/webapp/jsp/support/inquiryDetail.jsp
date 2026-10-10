<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  문의 상세 (inquiryDetail.jsp) - 담당: 박우리
  피그마: Inquiry / Detail / Desktop
   state : answered(답변 완료) | waiting(답변 대기 - 답변 영역 대신 안내 문구)
--%>
<c:set var="state" value="${empty param.state ? 'answered' : param.state}" />
<c:set var="pageTitle" value="문의 상세" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="support" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="answered:답변 완료|waiting:답변 대기" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner" style="width:900px">
  <div class="page-head"><h1 class="page-title">문의 내용 상세확인</h1><p class="page-desc">내 문의 내용과 처리 상태, 관리자(사이트) 답변을 확인할 수 있어요.</p></div>
  <section class="detail-card" style="margin-left:56px">
    <div class="head"><h2>${inquiry.title}</h2>
      <span class="t-12 ${inquiry.answer_status eq '답변완료' ? 't-2' : 't-success'}">${inquiry.answer_status eq '답변완료' ? '답변 완료' : '답변 대기'}</span></div>
    <dl class="kv"><dt>${inquiry.answer_status eq '답변완료' ? '답변완료일' : '접수일'}</dt><dd>${inquiry.answer_status eq '답변완료' ? inquiry.answered_at : inquiry.created_at}</dd></dl>
    <h3>내용</h3>
    <p class="body">${inquiry.content}</p>
    <c:if test="${inquiry.answer_status eq '답변완료'}">
      <h3>답변</h3>
      <p class="body">${inquiry.answer}</p>
  	</c:if>
  </section>
  <div class="form-actions" style="margin-left:56px"><a class="btn btn-outline btn-sm" href="${ctx}/support/inquiry/list">목록으로</a></div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
