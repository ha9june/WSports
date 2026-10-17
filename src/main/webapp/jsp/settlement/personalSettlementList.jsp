<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%--
  개인 경기 정산 (personalSettlementList.jsp) - 담당: 박우리
  피그마: MyPage / Settlement / Personal Match / Desktop
  TODO: 요약 금액은 ${summary.xxx}, 목록은 <c:forEach var="s" items="${settlementList}"> 로 교체
--%>
<c:set var="pageTitle" value="개인 경기 정산" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="personalSettlement" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner mp-body">
  <h1 class="section-title">개인 경기 정산</h1>
  <p class="section-desc">내가 만든 개인 경기의 참가비 정산 내역과 지급 상태를 확인하세요.</p>
  <div class="sum-bar">정산 예정<b class="brand"><fmt:formatNumber value="${summary.wait_amount}"/>원</b><span class="sep"></span>${summary.cur_month}월 지급 완료<b><fmt:formatNumber value="${summary.month_done_amount}"/>원</b><span class="sep"></span>누적 지급<b><fmt:formatNumber value="${summary.total_done_amount}"/>원</b>
    <span class="acct">
	<c:choose>
      <c:when test="${not empty maskedAccount}">지급 계좌 ${bankName} ${maskedAccount}</c:when>
      <c:otherwise>등록된 지급 계좌가 없어요</c:otherwise>
    </c:choose>
  <button type="button" class="btn btn-outline btn-xs" data-modal-open="accountModal">${empty maskedAccount ? '계좌 등록' : '계좌 변경'}</button></span></div>
  <form class="list-toolbar" method="get">
  <c:set var="settlementStatus" value="${empty param.settlementStatus ? 'ALL' : param.settlementStatus}" />
    <input type="hidden" name="settlementStatus" value="${settlementStatus}">
    <div class="seg pill success">
    <a class="seg-item ${settlementStatus eq 'ALL' ? 'is-active' : ''}" href="?settlementStatus=ALL&period=${param.period}&keyword=${param.keyword}">전체 ${summary.all_cnt}</a>
    <a class="seg-item ${settlementStatus eq 'WAIT' ? 'is-active' : ''}" href="?settlementStatus=WAIT&period=${param.period}&keyword=${param.keyword}">정산 대기 ${summary.wait_cnt}</a>
    <a class="seg-item ${settlementStatus eq 'DONE' ? 'is-active' : ''}" href="?settlementStatus=DONE&period=${param.period}&keyword=${param.keyword}">정산 완료 ${summary.done_cnt}</a></div>
    <span class="grow"></span>
    <div class="input-wrap"><span class="input-icon">⌕</span><input class="input" name="keyword" placeholder="경기명으로 검색" value="${param.keyword}"></div>
    <select class="select" name="period" onchange="this.form.submit()">
    <option value="3m"   ${param.period == '3m' || empty param.period ? 'selected' : ''}>최근 3개월</option>
    <option value="6m"   ${param.period == '6m'   ? 'selected' : ''}>최근 6개월</option>
    <option value="year" ${param.period == 'year' ? 'selected' : ''}>올해</option></select>
  </form>
  <div class="ledger">
  	<c:forEach var="s" items="${personalSettlementList}">
        <div class="ledger-row">
          <div class="date"><b>${s.match_date_fmt}</b><span>(${s.match_day}) ${s.start_time_fmt}</span></div>
          <div><p class="ttl">${s.title} <span class="tag-sm">${s.sport}</span></p><p>${s.region} ${s.place_name}</p></div>
          <div class="t-2">${s.participant_count}명 참가 · <fmt:formatNumber value="${s.participation_fee}"/>원</div>
          <c:set var="total" value="${(s.participant_count) * s.participation_fee}" />
          <c:set var="feeAmt" value="${total * 0.08}" />
          <div class="amt"><b class="brand"><fmt:formatNumber value="${total}" maxFractionDigits="0"/>원</b><%-- <span><fmt:formatNumber value="${total}"/>원 − 수수료 <fmt:formatNumber value="${feeAmt}" maxFractionDigits="0"/>원</span> --%></div>
          <div class="st">
          <c:choose>
            <c:when test="${s.settlement_status eq '지급완료'}"><span class="pill pill-info bd">정산 완료</span><span>${s.settled_fmt} 지급 완료</span></c:when>
            <c:otherwise><span class="pill pill-warning bd">정산 대기</span><span>${s.settled_fmt} 지급 예정</span></c:otherwise>
      	  </c:choose>
        </div>
      </div>
    </c:forEach>   
  </div>
  
  <p class="ledger-note">경기 종료 후 확정 참가 인원 기준으로 정산돼요. <!-- 플랫폼 수수료 8%를 제외한 금액이 등록 계좌로 지급됩니다. --></p>
	<c:if test="${not empty personalSettlementList }">
	<nav class="pagination" style="display: flex; justify-content:center; padding:0px">
	  <a href="${pageInfo.curPage > 1 ? ctx += '/settlement/personal/list?settlementStatus=' += settlementStatus += '&page=' += (pageInfo.curPage - 1) += '&keyword=' += param.keyword += '&period=' += param.period : '#'}">&lt;</a>
	    <c:forEach begin="${pageInfo.startPage}" end="${pageInfo.endPage}" var="page">
	  <a href="${ctx}/settlement/personal/list?settlementStatus=${settlementStatus}&amp;page=${page}&amp;keyword=${param.keyword}&amp;period=${param.period}" class="${pageInfo.curPage eq page ? 'is-active' : ''}">${page}</a>
	    </c:forEach>
	  <a href="${pageInfo.curPage < pageInfo.allPage ? ctx += '/settlement/personal/list?settlementStatus=' += settlementStatus += '&page=' += (pageInfo.curPage + 1) += '&keyword=' += param.keyword += '&period=' += param.period : '#'}">&gt;</a>
	</nav>
	</c:if>
</div>	
</main></div>

<div class="modal" id="accountModal" role="dialog" aria-modal="true">
  <div class="modal-card md">
    <h2 class="modal-title">지급 계좌 변경</h2>
    <p class="modal-desc">정산금은 본인 명의 계좌로만 지급됩니다.</p>
    <form method="post" action="${ctx}/settlement/account">
    <input type="hidden" name="returnUrl" value="/settlement/personal/list">
    <div class="modal-body">
      <div class="field"><label class="field-label">은행</label>
      <select class="select" name="bank" required>
        <c:forEach var="b" items="카카오뱅크,토스뱅크,국민은행">
          <option value="${b}" ${bankName eq b ? 'selected' : ''}>${b}</option>
        </c:forEach>
      </select></div>
      <div class="field mt-16"><label class="field-label">계좌번호</label>
        <input class="input" name="accountNo" placeholder="'-' 없이 입력" inputmode="numeric" maxlength="20" autocomplete="off" required></div>
      <div class="field mt-16"><label class="field-label">예금주</label>
        <input class="input" name="accountHolder" value="${sessionScope.user.accountHolder}" maxlength="20" required></div>
    </div>
    <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="submit" class="btn btn-primary">변경</button></div>
    </form>
  </div>
</div>

<c:if test="${param.account eq 'ok' or param.account eq 'fail'}">
<script>
window.addEventListener('load', function () {
  showToast('${param.account eq "ok" ? "지급 계좌를 변경했어요." : "계좌 정보를 다시 확인해 주세요."}');
});
</script>
</c:if>
<%@ include file="/jsp/common/footer.jsp" %>
