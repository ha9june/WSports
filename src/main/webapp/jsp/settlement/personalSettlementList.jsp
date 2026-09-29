<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
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
<div class="work-inner full" style="max-width:1000px">
  <h1 class="section-title">개인 경기 정산</h1>
  <p class="section-desc">내가 만든 개인 경기의 참가비 정산 내역과 지급 상태를 확인하세요.</p>
  <div class="sum-bar">정산 예정<b class="brand">163,400원</b><span class="sep"></span>9월 지급 완료<b>110,200원</b><span class="sep"></span>누적 지급<b>549,100원</b>
    <span class="acct">지급 계좌 카카오뱅크 3333-12-***789 <button type="button" class="btn btn-outline btn-xs" data-modal-open="accountModal">계좌 변경</button></span></div>
  <form class="list-toolbar" method="get">
    <div class="seg pill success"><a class="seg-item is-active" href="?">전체 4</a><a class="seg-item" href="?status=WAIT">정산 대기 2</a><a class="seg-item" href="?status=DONE">정산 완료 2</a></div>
    <span class="grow"></span>
    <div class="input-wrap"><span class="input-icon">⌕</span><input class="input" name="keyword" placeholder="경기명으로 검색"></div>
    <select class="select" name="period"><option>최근 3개월</option><option>최근 6개월</option><option>올해</option></select>
  </form>
  <div class="ledger">
        <div class="ledger-row">
          <div class="date"><b>2026.09.20</b><span>(일) 14:00</span></div>
          <div><p class="ttl">주말 실내 농구 같이 하실 분 <span class="tag-sm">농구</span></p><p>서울 성동구 실내체육관</p></div>
          <div class="t-2">9명 참가 · 8,000원</div>
          <div class="amt"><b class="brand">68,400원</b><span>72,000원 − 수수료 3,600원</span></div>
          <div class="st"><span class="pill pill-warning">정산 대기</span><span>9/30 지급 예정</span></div>
        </div>
        <div class="ledger-row">
          <div class="date"><b>2026.09.19</b><span>(토) 19:00</span></div>
          <div><p class="ttl">토요일 저녁 풋살 한 판! <span class="tag-sm">축구/풋살</span></p><p>서울 마포구 망원 풋살장</p></div>
          <div class="t-2">10명 참가 · 10,000원</div>
          <div class="amt"><b class="brand">95,000원</b><span>100,000원 − 수수료 5,000원</span></div>
          <div class="st"><span class="pill pill-warning">정산 대기</span><span>9/28 지급 예정</span></div>
        </div>
        <div class="ledger-row">
          <div class="date"><b>2026.09.05</b><span>(토) 20:00</span></div>
          <div><p class="ttl">퇴근 후 배드민턴 <span class="tag-sm">배드민턴</span></p><p>서울 강서구 배드민턴장</p></div>
          <div class="t-2">8명 참가 · 7,000원</div>
          <div class="amt"><b class="">53,200원</b><span>56,000원 − 수수료 2,800원</span></div>
          <div class="st"><span class="pill pill-info">정산 완료</span><span>9/09 지급 완료</span></div>
        </div>
        <div class="ledger-row">
          <div class="date"><b>2026.08.30</b><span>(토) 18:30</span></div>
          <div><p class="ttl">초중급 테니스 복식 모집 <span class="tag-sm">테니스</span></p><p>서울 송파구 테니스장</p></div>
          <div class="t-2">4명 참가 · 15,000원</div>
          <div class="amt"><b class="">57,000원</b><span>60,000원 − 수수료 3,000원</span></div>
          <div class="st"><span class="pill pill-info">정산 완료</span><span>9/03 지급 완료</span></div>
        </div>
  </div>
  <p class="ledger-note">경기 종료 후 확정 참가 인원 기준으로 정산돼요. 플랫폼 수수료 5%를 제외한 금액이 등록 계좌로 지급됩니다.</p>
  <nav class="pagination"><a href="#">‹</a><a href="#" class="is-active">1</a><a href="#">2</a><a href="#">3</a><a href="#">›</a></nav>
</div>
</main></div>

<div class="modal" id="accountModal" role="dialog" aria-modal="true">
  <div class="modal-card md">
    <h2 class="modal-title">지급 계좌 변경</h2>
    <p class="modal-desc">정산금은 본인 명의 계좌로만 지급됩니다.</p>
    <div class="modal-body">
      <div class="field"><label class="field-label">은행</label><select class="select"><option>카카오뱅크</option><option>토스뱅크</option><option>국민은행</option></select></div>
      <div class="field mt-16"><label class="field-label">계좌번호</label><input class="input" placeholder="'-' 없이 입력"></div>
    </div>
    <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-primary" data-toast="지급 계좌를 변경했어요.">변경</button></div>
  </div>
</div>
<%@ include file="/jsp/common/footer.jsp" %>
