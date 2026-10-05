<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--
  공통 푸터 (footer.jsp)
   - showFooter : true 면 하단 저작권 영역 노출 (홈/목록 화면)
   - pageJs     : 추가 js 파일명(콤마 구분, 확장자 제외)
--%>
<c:if test="${showFooter}">
	<footer class="site-footer">© 매치온</footer>
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

<div class="toast" id="toast" role="status" aria-live="polite"></div>


<script src="${ctx}/js/common.js"></script>
<c:forTokens items="${pageJs}" delims="," var="jsName">
	<script src="${ctx}/js/${jsName}.js"></script>
</c:forTokens>
</body>
</html>
