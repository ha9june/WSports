<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  토스 결제 성공 리다이렉트 (toss_success.jsp) - 담당: 임태균
  토스가 ?paymentKey=&orderId=&amount= 를 붙여 이 페이지로 돌려보냅니다.
  TODO: 서버에서 결제 승인 API(POST https://api.tosspayments.com/v1/payments/confirm)를 호출하고,
        DB 금액과 amount 가 같은지 검증한 뒤 orderComplete.jsp 로 forward 하세요.
        (아래 화면은 승인 처리 중 잠깐 보이는 화면 / 시연용 자동 이동)
--%>
<c:set var="pageTitle" value="결제 승인 중" />
<c:set var="pageCss" value="payment" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="result-box">
    <div class="icon ok">✓</div>
    <h1>결제 승인 중이에요</h1>
    <p>잠시만 기다려주세요. 승인이 끝나면 결제 완료 화면으로 이동합니다.</p>
    <div class="receipt summary">
      <div class="ln"><span>주문번호</span><span>${empty param.orderId ? 'MATCHON-20260916-0012' : fn:escapeXml(param.orderId)}</span></div>
      <div class="ln"><span>결제 금액</span><span>${empty param.amount ? '10,800' : fn:escapeXml(param.amount)}원</span></div>
    </div>
    <div class="btn-group"><a class="btn btn-primary" id="goComplete" href="${ctx}/jsp/payment/orderComplete.jsp">결제 완료 화면으로</a></div>
  </div>
</main>
<script>setTimeout(function(){ document.getElementById('goComplete').click(); }, 1500);</script>
<%@ include file="/jsp/common/footer.jsp" %>
