<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  결제 내역 (paymentList.jsp) - 담당: 박우리
  피그마: MyPage / Payments / Desktop
  TODO: <c:forEach var="p" items="${paymentList}"> 로 행 반복, 필터는 ?type=&status= 파라미터
--%>
<c:set var="pageTitle" value="결제 내역" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="payment" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>

<c:url var="uAll" value="/payment/history/list"><c:param name="period" value="${period}"/><c:param name="keyword" value="${keyword}"/></c:url>
<c:url var="uPaid" value="/payment/history/list"><c:param name="status" value="PAID"/><c:param name="period" value="${period}"/><c:param name="keyword" value="${keyword}"/></c:url>
<c:url var="uRefund" value="/payment/history/list"><c:param name="status" value="REFUND"/><c:param name="period" value="${period}"/><c:param name="keyword" value="${keyword}"/></c:url>
<c:url var="uPersonal" value="/payment/history/list"><c:param name="type" value="PERSONAL"/><c:param name="period" value="${period}"/><c:param name="keyword" value="${keyword}"/></c:url>
<c:url var="uTeam" value="/payment/history/list"><c:param name="type" value="TEAM"/><c:param name="period" value="${period}"/><c:param name="keyword" value="${keyword}"/></c:url>

<div class="work-inner full" style="max-width:1000px">
	<h1 class="section-title">결제 내역</h1>
	<p class="section-desc">경기 참가비 결제와 환불 내역을 확인하고 영수증을 받을 수 있어요.</p>
	<form class="list-toolbar" method="get" action="${ctx}/payment/history/list">
    	<c:if test="${not empty status}"><input type="hidden" name="status" value="${status}"></c:if>
		<c:if test="${not empty type}"><input type="hidden" name="type" value="${type}"></c:if>
    	
    	<div class="seg pill success">
			<a class="seg-item ${tab eq 'ALL' ? 'is-active' : ''}" href="${uAll}">전체 ${summary.total}</a>
			<a class="seg-item ${tab eq 'PAID' ? 'is-active' : ''}" href="${uPaid}">결제 완료 ${summary.paid}</a>
			<a class="seg-item ${tab eq 'REFUND' ? 'is-active' : ''}" href="${uRefund}">환불 완료 ${summary.refund}</a>
			<a class="seg-item ${tab eq 'PERSONAL' ? 'is-active' : ''}" href="${uPersonal}">개인 경기</a>
			<a class="seg-item ${tab eq 'TEAM' ? 'is-active' : ''}" href="${uTeam}">팀 경기</a>
    	</div>
    	<span class="grow"></span>
    	<div class="input-wrap">
    		<span class="input-icon">⌕</span>
    		<input class="input" name="keyword" value="<c:out value='${keyword}'/>" placeholder="경기명으로 검색" style="width:200px"></div>
    		<select class="select" name="period" onchange="this.form.submit()">
    			<option value="3m" ${period eq '3m' ? 'selected' : ''}>최근 3개월</option>
			<option value="6m" ${period eq '6m' ? 'selected' : ''}>최근 6개월</option>
			<option value="year" ${period eq 'year' ? 'selected' : ''}>올해</option>
    		</select>
  	</form>
  	<div class="ledger">
    	<c:choose>
			<c:when test="${empty paymentList}">
				<p class="t-2" style="padding:48px 0;text-align:center">조건에 맞는 결제 내역이 없어요.</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="p" items="${paymentList}">
					<%-- ★ 상세 페이지 URL은 구현 후 맞춰주세요 --%>
					<a class="ledger-row" href="${ctx}/info?matchType=${p.matchType}&paymentKey=${p.paymentKey}"
					   style="grid-template-columns:110px 1fr 160px 190px 90px">
						<div class="date">
							<b>${p.payDate}</b>
							<span>${p.payTime}</span>
						</div>
						<div>
							<p class="ttl"><c:out value="${p.orderName}"/>
								<span class="tag-sm">${p.matchType eq 'TEAM' ? '팀 경기' : '개인 경기'}</span>
							</p>
							<p class="t-2"><c:out value="${p.matchSchedule}"/> · <c:out value="${p.matchPlace}"/></p>
						</div>
						<div class="t-2"><c:out value="${p.methodLabel}"/></div>
						<div class="amt">
							<c:choose>
								<c:when test="${p.refunded eq 1}">
									<b class="danger">−<fmt:formatNumber value="${p.refundAmount}" pattern="#,##0"/>원</b>
									<span class="danger">${p.cancelDate} 환불</span>
								</c:when>
								<c:otherwise>
									<b><fmt:formatNumber value="${p.totalAmount}" pattern="#,##0"/>원</b>
									<span>참가비 <fmt:formatNumber value="${p.participationFee}" pattern="#,##0"/>원
										+ 수수료 <fmt:formatNumber value="${p.fee}" pattern="#,##0"/>원</span>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="st">
							<span class="pill ${p.refunded eq 1 ? 'pill-danger bd' : 'pill-success bd'}">${p.refunded eq 1 ? '환불 완료' : '결제 완료'}</span>
						</div>
					</a>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>

	<%-- 페이지네이션 (status/type/period/keyword 유지) --%>
	<c:if test="${pageInfo.totalCnt > 0}">
    <nav class="pagination">

        <%-- 왼쪽 화살표: 이전 페이지 --%>
        <c:url var="uPrev" value="/payment/history/list">
            <c:param name="page" value="${pageInfo.curPage > 1 ? pageInfo.curPage - 1 : 1}"/>
            <c:param name="status" value="${status}"/>
            <c:param name="type" value="${type}"/>
            <c:param name="period" value="${period}"/>
            <c:param name="keyword" value="${keyword}"/>
        </c:url>

        <a href="${uPrev}" aria-label="이전 페이지">&lt;</a>

        <%-- 페이지 번호 --%>
        <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
            <c:url var="uPage" value="/payment/history/list">
                <c:param name="page" value="${i}"/>
                <c:param name="status" value="${status}"/>
                <c:param name="type" value="${type}"/>
                <c:param name="period" value="${period}"/>
                <c:param name="keyword" value="${keyword}"/>
            </c:url>

            <a href="${uPage}" class="${i == pageInfo.curPage ? 'is-active' : ''}">${i}</a>
        </c:forEach>

        <%-- 오른쪽 화살표: 다음 페이지 --%>
        <c:url var="uNext" value="/payment/history/list">
            <c:param name="page" value="${pageInfo.curPage < pageInfo.allPage ? pageInfo.curPage + 1 : pageInfo.allPage}"/>
            <c:param name="status" value="${status}"/>
            <c:param name="type" value="${type}"/>
            <c:param name="period" value="${period}"/>
            <c:param name="keyword" value="${keyword}"/>
        </c:url>

        <a href="${uNext}" aria-label="다음 페이지">&gt;</a>
    </nav>
    </c:if>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
