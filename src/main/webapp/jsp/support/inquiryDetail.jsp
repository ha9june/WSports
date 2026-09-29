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
    <div class="head"><h2>${state eq 'waiting' ? '팀 가입 신청 상태가 궁금해요' : '결제 후 참가 확정이 되지 않아요'}</h2>
      <span class="t-12 ${state eq 'waiting' ? 't-2' : 't-success'}">${state eq 'waiting' ? '답변 대기' : '답변 완료'}</span></div>
    <dl class="kv"><dt>접수일</dt><dd>${state eq 'waiting' ? '2026.09.12' : '2026.09.14'}</dd></dl>
    <h3>내용</h3>
    <p class="body">${state eq 'waiting' ? '일주일 전에 가입 신청했는데 아직 승인 대기 상태예요. 확인 부탁드립니다.' : '오늘 풋살 경기 참가비를 결제했는데 내 경기에서 참가 확정으로 표시되지 않습니다.<br>결제 내역은 정상적으로 보이는데 신청 상태를 확인해주세요.'}</p>
    <h3>답변</h3>
    <p class="body ${state eq 'waiting' ? 't-2' : ''}">${state eq 'waiting' ? '아직 답변이 등록되지 않았어요. 영업일 기준 1~2일 내에 답변드릴게요.' : '결제 반영 지연을 확인하여 참가 확정 처리했습니다. 이용에 불편을 드려 죄송합니다.'}</p>
  </section>
  <div class="form-actions" style="margin-left:56px"><a class="btn btn-outline btn-sm" href="${ctx}/jsp/support/inquiryList.jsp">목록으로</a></div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
