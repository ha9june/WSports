<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  결제 상세 / 영수증 (paymentDetail.jsp) - 담당: 임태균
   state : paid(결제 완료) | refunded(환불 완료)
  결제 내역(paymentList.jsp)에서 항목을 누르면 이동합니다.
--%>
<c:set var="isRefund" value="${payment.paymentStatus eq 'CANCELED'}" />
<c:set var="pageTitle" value="결제 상세" />
<c:set var="pageCss" value="mypage,payment" />
<c:set var="sideMenu" value="payment" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner">
	<div class="page-head row">
    	<div>
    		<h1 class="page-title md">결제 상세</h1>
    		<p class="page-desc">주문번호 ${payment.paymentKey}</p>
    	</div>
    	<span class="pill pill-lg ${isRefund ? 'pill-danger bd' : 'pill-success bd'}">${isRefund ? '환불 완료' : '결제 완료'}</span>
  	</div>
  	<section class="receipt">
		<h2 class="sub-title">${payment.orderName}  <span class="tag-sm">${isTeam ? '팀 경기' : '개인 경기'}</span></h2>
    	<p class="t-12 t-2 mt-8">${match.title}  ${match.matchDate}  ${match.placeName}</p>
    	<hr class="divider">
    	<div class="ln">
    		<span>참가비</span>
    		<span><fmt:formatNumber value="${match.participationFee}" pattern="#,###"/>원</span>
    	</div>
    	<div class="ln">
    		<span>수수료</span>
    		<span><fmt:formatNumber value="${match.fee}" pattern="#,###"/>원</span>
    	</div>
    	<div class="ln">
    		<span>결제 수단</span>
    		<span>${payment.cardCompany}</span><span>  ${payment.cardNumber}  ${payment.paymentMethod}</span>
    	</div>
    	<div class="ln">
    		<span>결제 일시</span>
    		<span>${fn:replace(fn:substring(payment.approvedAt, 0, 16), 'T', ' ')}</span>
    	</div>
    	<c:if test="${isRefund}">
      		<div class="ln">
      			<span>환불 일시</span>
      			<span>${fn:replace(fn:substring(payment.canceledAt, 0, 16), 'T', ' ')}</span>
      		</div>
      		<div class="ln">
      			<span>환불 사유</span>
      			<span>${payment.cancelReason }</span>
      		</div>
		</c:if>
    	<div class="ln total">
    		<span>${isRefund ? '환불 금액' : '결제 금액'}</span>
    		<b class="${isRefund ? 't-danger' : ''}">${isRefund ? '' : ''}<fmt:formatNumber value="${payment.totalAmount}" pattern="#,###"/>원</b>
    	</div>
	</section>
	<div class="form-actions">
    	<c:if test="${not empty payment.receiptUrl}">
			<a class="btn btn-outline" href="${payment.receiptUrl}" target="_blank" rel="noopener">영수증 보기</a>
		</c:if>
    	<c:if test="${canRefund}">
			<button type="button" class="btn btn-outline" data-modal-open="refundModal">환불하기</button>
		</c:if>
    	<c:choose>
			<c:when test="${isTeam}">
				<a class="btn btn-primary" href="${ctx}/team-match/detail/view?teamMatchId=${match.teamMatchId}">경기 보기</a>
			</c:when>
			<c:otherwise>
				<a class="btn btn-primary" href="${ctx}/match/detail/view?personalMatchId=${match.personalMatchId}">경기 보기</a>
			</c:otherwise>
		</c:choose>
  	</div>
</div>
<!-- 환불 확인 모달 -->
<div class="modal" id="refundModal" role="dialog" aria-modal="true">
	<div class="modal-card md">
		<h2 class="modal-title">환불할까요?</h2>
		<p class="modal-desc">
			<c:if test="${isTeam }">
				<p class="t-12 t-danger" style="margin-bottom:12px">
				환불하면 경기참가가 취소됩니다. 처리후에는 되돌릴 수 없어요.<br>
				모집 마감 전까지만 환불할 수 있어요.
				</p>  
			</c:if>
			
		</p>
		<form method="post" action="${ctx}/payment/refund" id="refundForm">
			<input type="hidden" name="paymentKey" value="${payment.paymentKey}">
			<input type="hidden" name="matchType" value="${isTeam ? 'team' : 'personal' }"/>
			<div class="modal-body">
				<p>환불금액 : <b><fmt:formatNumber value="${payment.totalAmount}"  pattern="#,###"/>원</b></p>
				<div class="field mt-16">
					<label class="field-label">환불사유</label>
					<select class="select" name="cancelReason" required>
						<option>일정이 맞지 않음</option>
						<option>${isTeam ? '팀 사정' : '개인 사정' }</option>
						<option>잘못 결제함</option>
						<option>기타</option>
					</select>
				</div>
			</div>
			<div class="modal-actions">
				<button type="submit" class="btn btn-danger" id="refundSubmit">환불하기</button>
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
			</div>
		</form>
	</div>
</div>
<script>
	//환불 버튼 두번 클릭 방지
	const refundForm = document.getElementById('refundForm');
	if(refundForm) {
		refundForm.addEventListener('submit', function() {
			const btn = document.getElementById('refundSubmit');
			btn.disabled = true;
			btn.textContent = '처리 중...';
		});
	}
</script>
<%-- 환불 처리 결과 알림 : 한 번 띄우고 삭제 --%>
<c:if test="${not empty sessionScope.refundMsg}">
	<script>alert('${sessionScope.refundMsg}');</script>
	<c:remove var="refundMsg" scope="session"/>
</c:if>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
