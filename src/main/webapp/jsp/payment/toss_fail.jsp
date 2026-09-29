<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  토스 결제 실패 리다이렉트 (toss_fail.jsp) - 담당: 임태균
  토스가 ?code=&message=&orderId= 를 붙여 이 페이지로 돌려보냅니다.
--%>
<c:set var="pageTitle" value="결제 실패" />
<c:set var="pageCss" value="payment" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="result-box">
    <div class="icon fail">!</div>
    <h1>결제에 실패했어요</h1>
    <p>${empty param.message ? '카드 승인이 거절되었습니다. 결제 수단을 확인한 뒤 다시 시도해주세요.' : fn:escapeXml(param.message)}</p>
    <div class="receipt summary">
      <div class="ln"><span>오류 코드</span><span>${empty param.code ? 'REJECT_CARD_PAYMENT' : fn:escapeXml(param.code)}</span></div>
      <div class="ln"><span>결제 금액</span><span>청구되지 않았어요</span></div>
    </div>
    <div class="btn-group">
      <a class="btn btn-outline" href="${ctx}/jsp/match/personalMatchDetail.jsp">경기 상세로</a>
      <a class="btn btn-primary" href="${ctx}/jsp/payment/toss_checkout.jsp">다시 결제하기</a>
    </div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
