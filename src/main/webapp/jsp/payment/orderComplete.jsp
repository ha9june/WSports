<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  결제 완료 (orderComplete.jsp) - 담당: 임태균
   state : match(개인 경기 참가 확정) | teamMatch(팀 매칭 신청 접수)
  TODO: 승인 완료된 결제 정보(${payment})로 값 교체
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="결제 완료" />
<c:set var="pageCss" value="payment" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="match:개인 경기|teamMatch:팀 매칭" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="result-box">
    <div class="icon ok">✓</div>
    <h1>결제가 완료되었어요</h1>
    <p>${isTeam ? '팀 매칭 신청이 접수되었습니다. 모집 팀 주장이 확인하면 알림으로 알려드려요.' : '참가가 확정되었습니다. 경기 시작 10분 전까지 도착해주세요.'}</p>
    <div class="receipt summary">
      <div class="ln"><span>경기</span><span class="t-bold">${match.title }</span></div>
      <div class="ln"><span>일시</span><span>${match.matchDate} ${match.startTime }</span></div>
      <div class="ln"><span>결제 수단</span><span>${empty payment.easyPaymentProvider ? payment.paymentMethod : payment.easyPaymentProvider}</span></div>
      <div class="ln"><span>결제 일시</span><span>${payment.approvedAt }</span></div>
      <div class="ln total"><span>결제 금액</span><b><fmt:formatNumber value="${payment.totalAmount}" pattern="#,###" />원</b></div>
    </div>
    <div class="btn-group">
      <a class="btn btn-outline" href="${ctx}/info?paymentKey=${param.paymentKey}&matchType=${isTeam ? 'team' : 'personal'}">결제 상세</a>
      <c:choose>
      	<c:when test="${isTeam}">
      		<a class="btn btn-primary" href="${ctx}/team-match/detail/view?teamMatchId=${match.teamMatchId}">경기 상세로 이동</a>
      	</c:when>
      	<c:otherwise>
      		<a class="btn btn-primary" href="${ctx}/match/detail/view?personalMatchId=${match.personalMatchId }">경기 상세로 이동</a>
      	</c:otherwise>
      </c:choose>
      
    </div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
