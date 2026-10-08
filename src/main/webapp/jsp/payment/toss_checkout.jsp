<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  결제 (toss_checkout.jsp) - 담당: 임태균
  피그마: Match / Payment, Match / Payment / Confirm, Club Match / Payment, Club Match / Payment / Confirm
  ─ 하나의 JSP 로 처리 ─
   state : match(개인 경기) | matchConfirm(확인 모달) | teamMatch(팀 매칭) | teamMatchConfirm(확인 모달)
  결제 흐름 : [결제하기] → 확인 모달 → 토스페이먼츠 결제창 → 성공 toss_success.jsp / 실패 toss_fail.jsp
--%>
<c:set var="state" value="${empty param.state ? 'match' : param.state}" />
<c:set var="isTeam" value="${fn:startsWith(state, 'teamMatch')}" />
<c:set var="pageTitle" value="${isTeam ? '팀 매칭 결제' : '결제'}" />
<c:set var="pageCss" value="payment" />
<c:set var="pageJs" value="payment" />
<c:set var="activeNav" value="${isTeam ? 'teamMatch' : 'match'}" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="match:개인 경기|matchConfirm:개인-확인 모달|teamMatch:팀 매칭|teamMatchConfirm:팀-확인 모달" />
<%-- TODO: 아래 값은 서블릿에서 경기/주문 정보로 채우기 --%>
<c:set var="itemName" value="${match.title}" />
<c:set var="itemWhen" value="${match.matchDate} ${match.startTime} · ${match.placeName}" />
<fmt:formatNumber var="fee" value="${match.participationFee}" pattern="#,###" />
<fmt:formatNumber var="charge" value="${match.fee}" pattern="#,###" />
<fmt:formatNumber var="total" value="${totalAmount}" pattern="#,###" />
<c:set var="totalNum" value="${totalAmount}" />
<%@ include file="/jsp/common/header.jsp" %>
<!-- 여기가 계산하는 곳 -->
<main class="page">
	<div class="pay-wrap">
    	<nav class="breadcrumb">
      		<c:choose>
        		<c:when test="${isTeam}">
        			<a href="${ctx}/jsp/team/teamMatchList.jsp">팀 매칭</a>
        			<span class="sep">›</span>
        			<span>신청</span>
        			<span class="sep">›</span>
        			<span>결제</span>
        		</c:when>
        		<c:otherwise>
        			<a href="${ctx}/jsp/match/personalMatchList.jsp">경기 찾기</a>
        			<span class="sep">›</span>
        			<a href="${ctx}/jsp/match/personalMatchDetail.jsp">경기 상세</a>
        			<span class="sep">›</span>
        			<span>결제</span>
        		</c:otherwise>
      		</c:choose>
    	</nav>
	<div class="page-head">
		<h1 class="page-title">${isTeam ? '팀 매칭 결제' : '결제'}</h1>
		<p class="page-desc">참가비와 수수료를 확인한 뒤 결제하세요.</p>
	</div>

    <section class="pay-card">
    	<h2>${itemName}</h2>
      	<p class="when">${itemWhen}</p>
      	<div class="pay-lines">
        	<div class="ln">
        		<span>참가비</span>
        		<span>${fee}원</span>
        	</div>
        	<div class="ln">
        		<span>수수료</span>
        		<span>${charge}원</span>
        	</div>
        	<div class="ln total">
        		<span>결제 금액</span>
        		<b>${total}원</b>
        	</div>
      	</div>
	</section>

    <section class="method-card">
      	<h3>결제 수단</h3>
      	<p class="sub">${total}원 결제 예정</p>
      	<%-- 토스 결제위젯을 쓰는 경우 아래 영역에 렌더링 : <div id="payment-method"></div><div id="agreement"></div> --%>
      	<!-- 결제 수단 선택 UI가 렌더링될 영역 -->
      	<div id="payment-method"></div>
      	<!-- 이용약관 영역 -->
      	<div id="agreement"></div>
      	
      	<div class="foot">
        	<label class="check"><input type="checkbox" id="refundAgree">환불 정책을 확인했습니다.</label>
        	<button type="button" class="btn btn-primary btn-sm" id="payOpenBtn" data-modal-open="payConfirmModal" disabled>결제하기</button>
      	</div>
    </section>
	</div>
</main>

<div class="modal ${fn:endsWith(state, 'Confirm') ? 'is-open' : ''}" id="payConfirmModal" role="dialog" aria-modal="true">
  <div class="modal-card md modal-pay">
    <h2 class="modal-title">${isTeam ? '팀 매칭 결제를 진행할까요?' : '결제를 진행할까요?'}</h2>
    <div class="item"><strong>${itemName}</strong><p>참가비 ${fee}원 · 수수료 ${charge}원</p></div>
    <div class="total"><span>결제 금액</span><b>${total}원</b></div>
    <p class="t-11 t-2 mt-16">${isTeam ? '결제 완료 후 팀 매칭 신청이 접수됩니다.' : '결제 완료 후 참가가 바로 확정됩니다.'}</p>
    <div class="modal-actions">
      <button type="button" class="btn btn-outline" data-modal-close>취소</button>
      <button type="button" class="btn btn-primary" id="tossPayBtn"
              data-amount="${totalNum}" data-order-name="${itemName}"
              data-success-url="${ctx}/jsp/payment/toss_success.jsp" data-fail-url="${ctx}/jsp/payment/toss_fail.jsp">결제하기</button>
    </div>
  </div>
</div>

<%-- 토스페이먼츠 SDK (실제 결제 연동 시 사용) --%>
<script src="https://js.tosspayments.com/v1/payment-widget"></script>
  <script>
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm"; // 개발자센터 클라이언트 키
    const customerKey = "USER_" + new Date().getTime(); // 회원 식별 고유키 (비회원은 PaymentWidget.ANONYMOUS)

    // 1. 위젯 초기화
    const paymentWidget = PaymentWidget(clientKey, customerKey);

    // 2. 결제 UI 렌더링 (금액 50,000원)
    paymentWidget.renderPaymentMethods("#payment-method", { value: ${totalNum} });

    // 3. 약관 렌더링
    paymentWidget.renderAgreement("#agreement");

    // 4. 결제하기 버튼 클릭 이벤트
    document.getElementById("tossPayBtn").addEventListener("click", function () {
    	const btn = this;
    	// 주문번호 생성 (실제 운영 시에는 서버 DB에 주문 정보를 먼저 저장하고 생성된 번호를 바인딩 권장)
    	const orderId = "ORDER_" + new Date().getTime();
    	const query = "?matchId=${param.matchId}&matchType=${isTeam ? 'team' : 'personal'}&teamId=${empty teamId ? 0 : teamId}";
    	
      	paymentWidget.requestPayment({
        	orderId: orderId,
        	orderName: btn.dataset.orderName,
        	successUrl: window.location.origin + btn.dataset.successUrl + query,
        	failUrl: window.location.origin + btn.dataset.failUrl,
        	customerName: "홍길동",
        	customerEmail: "user@example.com"
      	}).catch(function (error) {
        	if (error.code === 'USER_CANCEL') {
         		alert('결제가 취소되었습니다.');
        	} else {
          		alert('오류 발생: ' + error.message);
        	}
      	});
    });
  </script>
<%@ include file="/jsp/common/footer.jsp" %>
