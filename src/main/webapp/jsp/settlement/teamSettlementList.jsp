<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀 경기 정산 (teamSettlementList.jsp) - 담당: 박우리
  피그마: MyPage / Settlement / Team Match / Desktop
  TODO: 요약 금액은 ${summary.xxx}, 목록은 <c:forEach var="s" items="${settlementList}"> 로 교체
--%>
<c:set var="pageTitle" value="팀 경기 정산" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="teamSettlement" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner full" style="max-width:1000px">
  <h1 class="section-title">팀 경기 정산</h1>
  <p class="section-desc">내가 주장인 팀이 개설한 팀 경기의 정산 내역을 확인하세요.</p>
  <div class="sum-bar">정산 예정<b class="brand">47,500원</b><span class="sep"></span>9월 지급 완료<b>95,000원</b><span class="sep"></span>누적 지급<b>427,500원</b>
    <span class="acct">지급 계좌 토스뱅크 1000-12-***421 (주장) <button type="button" class="btn btn-outline btn-xs" data-modal-open="accountModal">계좌 변경</button></span></div>
  <form class="list-toolbar" method="get">
    <div class="seg pill success"><a class="seg-item is-active" href="?">전체 4</a><a class="seg-item" href="?status=WAIT">정산 대기 1</a><a class="seg-item" href="?status=DONE">정산 완료 3</a></div>
    <span class="grow"></span>
    <select class="select wide" name="teamNo"><option>서울 풋살 크루</option><option>성동 농구 모임</option></select>
    <div class="input-wrap"><span class="input-icon">⌕</span><input class="input" name="keyword" placeholder="경기명으로 검색" style="width:180px"></div>
    <select class="select" name="period"><option>최근 3개월</option><option>최근 6개월</option><option>올해</option></select>
  </form>
  <div class="ledger">
        <div class="ledger-row">
          <div class="date"><b>2026.09.20</b><span>(일) 17:00</span></div>
          <div><p class="ttl">서울 풋살 크루 vs 마포 FC <span class="tag-sm">축구/풋살</span></p><p>서울 마포구 난지 풋살장</p></div>
          <div class="t-2">6 vs 6 · 참가비 50,000원</div>
          <div class="amt"><b class="brand">47,500원</b><span>50,000원 − 수수료 2,500원</span></div>
          <div class="st"><span class="pill pill-warning">정산 대기</span><span>9/28 지급 예정</span></div>
        </div>
        <div class="ledger-row">
          <div class="date"><b>2026.09.13</b><span>(일) 17:00</span></div>
          <div><p class="ttl">서울 풋살 크루 vs 망원 FC <span class="tag-sm">축구/풋살</span></p><p>서울 마포구 난지 풋살장</p></div>
          <div class="t-2">6 vs 6 · 참가비 50,000원</div>
          <div class="amt"><b class="">47,500원</b><span>50,000원 − 수수료 2,500원</span></div>
          <div class="st"><span class="pill pill-info">정산 완료</span><span>9/16 지급 완료</span></div>
        </div>
        <div class="ledger-row">
          <div class="date"><b>2026.09.06</b><span>(일) 17:00</span></div>
          <div><p class="ttl">서울 풋살 크루 vs 성산 FS <span class="tag-sm">축구/풋살</span></p><p>서울 마포구 난지 풋살장</p></div>
          <div class="t-2">6 vs 6 · 참가비 50,000원</div>
          <div class="amt"><b class="">47,500원</b><span>50,000원 − 수수료 2,500원</span></div>
          <div class="st"><span class="pill pill-info">정산 완료</span><span>9/08 지급 완료</span></div>
        </div>
        <div class="ledger-row">
          <div class="date"><b>2026.08.23</b><span>(일) 17:00</span></div>
          <div><p class="ttl">서울 풋살 크루 vs 한강 유나이티드 <span class="tag-sm">축구/풋살</span></p><p>서울 마포구 난지 풋살장</p></div>
          <div class="t-2">6 vs 6 · 참가비 50,000원</div>
          <div class="amt"><b class="">47,500원</b><span>50,000원 − 수수료 2,500원</span></div>
          <div class="st"><span class="pill pill-info">정산 완료</span><span>8/26 지급 완료</span></div>
        </div>
  </div>
  <p class="ledger-note">팀 경기 정산금은 상대 팀 참가비에서 플랫폼 수수료 5%를 제외하고 팀 대표(주장) 계좌로 지급돼요. 팀원 간 분배는 팀에서 직접 진행해 주세요.</p>
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
