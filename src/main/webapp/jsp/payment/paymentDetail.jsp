<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  결제 상세 / 영수증 (paymentDetail.jsp) - 담당: 임태균
   state : paid(결제 완료) | refunded(환불 완료)
  결제 내역(paymentList.jsp)에서 항목을 누르면 이동합니다.
--%>
<c:set var="state" value="${empty param.state ? 'paid' : param.state}" />
<c:set var="isRefund" value="${state eq 'refunded'}" />
<c:set var="pageTitle" value="결제 상세" />
<c:set var="pageCss" value="mypage,payment" />
<c:set var="sideMenu" value="payment" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="paid:결제 완료|refunded:환불 완료" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner">
  <a class="back-link" href="${ctx}/jsp/payment/paymentList.jsp">← 결제 내역</a>
  <div class="page-head row">
    <div><h1 class="page-title md">결제 상세</h1><p class="page-desc">주문번호 MATCHON-20260912-0007</p></div>
    <span class="pill pill-lg ${isRefund ? 'pill-danger bd' : 'pill-success bd'}">${isRefund ? '환불 완료' : '결제 완료'}</span>
  </div>
  <section class="receipt">
    <h2 class="sub-title">${isRefund ? '망원 배드민턴 번개' : '주말 실내 농구 같이 하실 분'} <span class="tag-sm">개인 경기</span></h2>
    <p class="t-12 t-2 mt-8">${isRefund ? '9/13 (일) 10:00 · 서울 마포구 망원체육관' : '9/27 (일) 14:00 · 서울 성동구 실내체육관'}</p>
    <hr class="divider">
    <div class="ln"><span>참가비</span><span>${isRefund ? '7,000' : '8,000'}원</span></div>
    <div class="ln"><span>수수료</span><span>${isRefund ? '560' : '640'}원</span></div>
    <div class="ln"><span>결제 수단</span><span>국민카드 ****1234 (일시불)</span></div>
    <div class="ln"><span>결제 일시</span><span>2026.09.12 09:41</span></div>
    <c:if test="${isRefund}">
      <div class="ln"><span>환불 일시</span><span>2026.09.13 11:02</span></div>
      <div class="ln"><span>환불 사유</span><span>최소 인원 미달로 경기 자동 취소</span></div>
    </c:if>
    <div class="ln total"><span>${isRefund ? '환불 금액' : '결제 금액'}</span><b class="${isRefund ? 't-danger' : ''}">${isRefund ? '−7,560' : '8,640'}원</b></div>
  </section>
  <div class="form-actions">
    <button type="button" class="btn btn-outline" data-toast="영수증을 이메일로 보냈어요.">영수증 받기</button>
    <a class="btn btn-primary" href="${ctx}/jsp/match/personalMatchDetail.jsp">경기 보기</a>
  </div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
