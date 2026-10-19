<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--
  공통 푸터 (footer.jsp)
   - showFooter : true 면 하단 저작권 영역 노출 (홈/목록 화면)
   - pageJs     : 추가 js 파일명(콤마 구분, 확장자 제외)
--%>
<c:if test="${showFooter}">
	<footer class="site-footer">© WSports</footer>
</c:if>

<c:if test="${empty sessionScope.user}">
	<%-- 비로그인 사용자가 로그인 필요 기능([data-auth])을 누르면 열림 --%>
	<div class="modal" id="loginRequiredModal" role="dialog"
		aria-modal="true" aria-labelledby="loginRequiredTitle">
		<div class="modal-card sm" style="text-align: center">
			<h2 class="modal-title" id="loginRequiredTitle">로그인이 필요한 기능입니다</h2>
			<p class="modal-desc">로그인 후 모집·신청·결제·팀 기능을 이용할 수 있어요.</p>
			<div class="modal-actions" style="justify-content: center">
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
				<a class="btn btn-primary" href="${ctx}/auth/login">로그인하러 가기</a>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${not empty sessionScope.user}">
<div class="modal" id="logoutModal" role="dialog" aria-modal="true">
	<div class="modal-card sm" style="text-align:center">
		<h2 class="modal-title">로그아웃할까요?</h2>
		<form action="${ctx}/auth/logout/submit" method="get">
			<div class="modal-actions" style="justify-content:center">
				<button type="button" class="btn btn-outline" data-modal-close>취소</button>
				<button type="submit" class="btn btn-primary">로그아웃</button>
			</div>
		</form>
	</div>
</div>
<%-- 정지 회원·정지 팀이 제한된 기능을 눌렀을 때 --%>
<div class="modal" id="suspendModal" role="dialog" data-no-autofocus
	aria-modal="true" aria-labelledby="suspendTitle">
	<div class="modal-card sm" style="text-align: center">
		<h2 class="modal-title" id="suspendTitle">이용이 제한되어 있어요</h2>
		<p class="modal-desc" id="suspendDesc"><c:out value="${sessionScope.suspendNotice}" /></p>
		<div class="modal-actions" style="justify-content: center">
			<button type="button" class="btn btn-outline" data-modal-close>확인</button>
			<%-- 개인 정지는 개인 패널티, 팀 정지는 팀 패널티 내역으로 (AlertUtil.notice 에서 지정) --%>
			<a class="btn btn-primary"
				href="${ctx}${empty sessionScope.suspendLink ? '/mypage/penalty' : sessionScope.suspendLink}">
				<c:out value="${empty sessionScope.suspendLinkLabel ? '패널티 내역 보기' : sessionScope.suspendLinkLabel}" /></a>
		</div>
	</div>
</div>
<script>
	// AJAX 응답 등에서 직접 띄울 때
	function showSuspendNotice(msg) {
		if (msg) document.getElementById('suspendDesc').textContent = msg;
		openModal('suspendModal');
	}
</script>
<c:if test="${not empty sessionScope.suspendNotice}">
	<script>$(function() { openModal('suspendModal'); });</script>
	<c:remove var="suspendNotice" scope="session" />
	<c:remove var="suspendLink" scope="session" />
	<c:remove var="suspendLinkLabel" scope="session" />
</c:if>
</c:if>
<c:if test="${not empty sessionScope.user
	and (empty sessionScope.user.bankName
	or empty sessionScope.user.accountNumber
	or empty sessionScope.user.accountHolder)}">
	<div class="modal" id="accountRequiredModal" role="dialog"
		aria-modal="true" aria-labelledby="accountRequiredTitle">
		<div class="modal-card sm" style="text-align: center">
			<h2 class="modal-title" id="accountRequiredTitle">정산받을 계좌를 등록해 주세요</h2>
			<p class="modal-desc">
				경기가 끝나면 참가비를 정산해 드려요.<br>
				계좌를 한 번만 등록해 두면 바로 글을 쓸 수 있어요.
			</p>
			<div class="modal-actions" style="justify-content: center">
				<button type="button" class="btn btn-outline" data-modal-close>나중에 할게요</button>
				<a class="btn btn-primary" href="${ctx}/member/mypage/view">계좌 등록하기</a>
			</div>
		</div>
	</div>
</c:if>


<div class="toast" id="toast" role="status" aria-live="polite"></div>

<c:if test="${not empty sessionScope.toast}">
	<script>$(function() { showToast('<c:out value="${sessionScope.toast}" />'); });</script>
	<c:remove var="toast" scope="session" />
</c:if>

<script src="${ctx}/js/common.js"></script>
<c:forTokens items="${pageJs}" delims="," var="jsName">
	<script src="${ctx}/js/${jsName}.js"></script>
</c:forTokens>
</body>
</html>
