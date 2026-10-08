<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<div class="work-inner full" style="max-width:1000px">
	<h1 class="section-title">결제 내역</h1>
	<p class="section-desc">경기 참가비 결제와 환불 내역을 확인하고 영수증을 받을 수 있어요.</p>
	<form class="list-toolbar" method="get">
    	<div class="seg pill success">
    		<a class="seg-item is-active" href="?">전체 5</a>
    		<a class="seg-item" href="?status=PAID">결제 완료 4</a>
    		<a class="seg-item" href="?status=REFUND">환불 완료 1</a>
    		<a class="seg-item" href="?type=PERSONAL">개인 경기</a>
    		<a class="seg-item" href="?type=TEAM">팀 경기</a>
    	</div>
    	<span class="grow"></span>
    	<div class="input-wrap">
    		<span class="input-icon">⌕</span>
    		<input class="input" name="keyword" placeholder="경기명으로 검색" style="width:200px"></div>
    		<select class="select" name="period">
    			<option>최근 3개월</option>
    			<option>최근 6개월</option>
    			<option>올해</option>
    		</select>
  	</form>
  	<div class="ledger">
    	<c:forTokens var="row" delims="|" items="2026.09.24^21:14^주말 실내 농구 같이 하실 분^개인 경기^
    	9/27 (일) 14:00 · 서울 성동구 실내체육관^국민카드 ****1234^8,640원^x^참가비 8,000원 + 수수료 640원^paid|2026.09.17^12:03^초중급 테니스 복식 모집^개인 경기^
    	9/21 (토) 18:30 · 서울 송파구 테니스장^카카오페이^16,200원^x^참가비 15,000원 + 수수료 1,200원^paid|2026.09.12^09:41^망원 배드민턴 번개^개인 경기^
    	9/13 (토) 10:00 · 서울 마포구 망원체육관^국민카드 ****1234^−7,560원^danger^9/13 전액 환불^refunded|2026.09.03^19:27^성수 FC vs 서울 풋살 크루^팀 경기^
    	9/05 (토) 17:00 · 서울 성동구 성수 풋살장^토스페이^54,000원^x^참가비 50,000원 + 수수료 4,000원^paid|2026.08.28^08:10^한강 러닝 크루 10K^개인 경기^
    	8/30 (일) 07:00 · 서울 영등포구 여의도 한강공원^국민카드 ****1234^5,400원^x^참가비 5,000원 + 수수료 400원^paid">
			<c:set var="p" value="${fn:split(row, '^')}" />
      		<%-- 시연용 더미 데이터를 한 줄 문자열로 넣었습니다. 실제로는 DTO 리스트를 forEach 하세요. --%>
      		<%-- 주의: fn:split 은 빈 값을 건너뛰므로 빈 칸은 x 로 채웠습니다. --%>
      		<a class="ledger-row" href="${ctx}/jsp/payment/paymentDetail.jsp?state=${p[9]}" style="grid-template-columns:110px 1fr 160px 190px 90px">
        		<div class="date">
        			<b>${p[0]}</b>
        			<span>${p[1]}</span>
        		</div>
        		<div>
        			<p class="ttl">${p[2]} <span class="tag-sm">${p[3]}</span></p>
        			<p class="t-2">${p[4]}</p>
        		</div>
        		<div class="t-2">${p[5]}</div>
        		<div class="amt">
        			<b class="${p[7]}">${p[6]}</b>
        			<span class="${p[7]}">${p[8]}</span>
        		</div>
        		<div class="st">
        			<span class="pill ${p[9] eq 'refunded' ? 'pill-danger bd' : 'pill-success bd'}">${p[9] eq 'refunded' ? '환불 완료' : '결제 완료'}</span>
        		</div>
      		</a>
    	</c:forTokens>
  	</div>
	<nav class="pagination">
		<a href="#">‹</a>
		<a href="#" class="is-active">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<a href="#">›</a>
	</nav>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
