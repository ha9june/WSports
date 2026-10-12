<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  토스 결제 실패 리다이렉트 (/payment/fail) - 담당: 임태균
  토스가 ?code=&message=&orderId= 를 붙여 이 페이지로 돌려보냅니다.
--%>
<c:set var="pageTitle" value="결제 실패" />
<c:set var="pageCss" value="payment" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="result-box">
    <div class="icon fail">!</div>
    <h1 class="page-title">${empty failTitle ? '결제에 실패했어요' : failTitle}</h1>
	<p class="page-desc"><c:out value="${failDesc}"/></p>
    <div class="receipt summary">
    	<c:if test="${not empty param.orderId}">
			<p class="t-12 t-2">주문번호 <c:out value="${param.orderId}"/></p>
		</c:if>
      	<c:if test="${not empty param.code}">
			<p class="t-11 t-2">오류 코드 <c:out value="${param.code}"/></p>
		</c:if>
		<div class="ln">
        	<span>결제 금액</span>
            <span>청구되지 않았어요</span>
        </div>
    </div>
	<div class="form-actions">
		<c:choose>
			<c:when test="${empty param.matchId and param.matchType eq 'team'}">
				<a class="btn btn-outline" href="${ctx}/team-match/list">상대팀 찾기로</a>
			</c:when>
			<c:when test="${empty param.matchId}">
				<a class="btn btn-outline" href="${ctx}/match/list">경기 목록으로</a>
			</c:when>
			<c:when test="${param.matchType eq 'team'}">
				<a class="btn btn-outline" href="${ctx}/team-match/detail/view?teamMatchId=${param.matchId}">경기로 돌아가기</a>
				<a class="btn btn-primary" href="${ctx}/payment/confirm?state=teamMatch&matchId=${param.matchId}&teamId=${param.teamId}">다시 결제하기</a>
			</c:when>
			<c:otherwise>
				<a class="btn btn-outline" href="${ctx}/match/detail/view?personalMatchId=${param.matchId}">경기로 돌아가기</a>
				<a class="btn btn-primary" href="${ctx}/payment/confirm?state=match&matchId=${param.matchId}">다시 결제하기</a>
			</c:otherwise>
		</c:choose>
	</div>
 	</div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
