<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  관심경기 (myPageHeartMatch.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Saved Matches / Desktop
  목록은 종목·상태 필터와 월 달력으로 조회합니다.
  TODO: 아래 act-card 를 <c:forEach var="m" items="${matchList}"> 로 반복 (날짜별 그룹 헤더 포함)
--%>
<c:set var="pageTitle" value="관심경기" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="heartMatch" />
<c:set var="calDays" value="21,22" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner full" style="max-width:1000px">
  <h1 class="section-title">관심경기</h1>
  <p class="section-desc">관심 표시한 경기를 종목, 상태와 월별 달력으로 확인하세요.</p>
  <form class="act-filters" method="get"><select class="select" name="sport"><option>전체 종목</option><option>축구/풋살</option><option>농구</option><option>테니스</option><option>배드민턴</option></select><select class="select" name="status"><option>전체 상태</option><option>모집중</option><option>경기 예정</option><option>경기 종료</option><option>취소</option></select></form>
  <div class="act-layout">
    <section>
      <div class="act-head"><b>2026년 9월 · 2건</b><a class="btn-reset" href="?">필터 초기화</a></div>
      <p class="date-label">9월 21일 <span>월</span></p>
    <div class="act-card" data-href="${ctx}/jsp/match/personalMatchDetail.jsp?state=saved">
      <div class="left"><span class="pill pill-success">모집중</span><img src="${ctx}/img/sport-icon-tennis.png" alt=""></div>
      <div class="main"><strong>초중급 테니스 복식 모집</strong>
        <p class="meta"><span><img src="${ctx}/img/icon-calendar-14.svg" alt="">9/21 (월)</span><span><img src="${ctx}/img/icon-clock-16.svg" alt="">18:30 ~ 20:30</span><span><img src="${ctx}/img/icon-pin-14.svg" alt="">서울 송파구 테니스장</span><span><img src="${ctx}/img/icon-user-12.svg" alt="">8/10 · 최소 8명 <span class="cap"><i style="width:80%"></i></span></span></p></div>
      <div class="aside"><div class="top">15,000원<button type="button" class="fav-btn is-on" data-fav aria-label="관심 경기">${heart}</button></div><div class="btns"></div></div>
    </div>
      <p class="date-label">9월 22일 <span>화</span></p>
    <div class="act-card" data-href="${ctx}/jsp/match/personalMatchDetail.jsp?state=saved">
      <div class="left"><span class="pill pill-success">모집중</span><img src="${ctx}/img/sport-icon-badminton.png" alt=""></div>
      <div class="main"><strong>퇴근 후 배드민턴</strong>
        <p class="meta"><span><img src="${ctx}/img/icon-calendar-14.svg" alt="">9/22 (화)</span><span><img src="${ctx}/img/icon-clock-16.svg" alt="">20:00 ~ 22:00</span><span><img src="${ctx}/img/icon-pin-14.svg" alt="">서울 영등포구 체육관</span><span><img src="${ctx}/img/icon-user-12.svg" alt="">6/8 · 최소 6명 <span class="cap"><i style="width:75%"></i></span></span></p></div>
      <div class="aside"><div class="top">6,000원<button type="button" class="fav-btn is-on" data-fav aria-label="관심 경기">${heart}</button></div><div class="btns"></div></div>
    </div>
    </section>
    <%--
  마이페이지 활동 화면 공통 월 달력 (참가 경기 / 내가 만든 경기 / 관심경기 / 팀 경기)
   - calDays : 경기가 있는 날짜 (콤마 구분)  예) "19,20"
  피그마: MyPage / Month Picker / Overlay (연-월 선택)
  TODO: ?ym=2026-09 로 월 이동 → 서블릿에서 해당 월 목록 조회
--%>
<aside class="cal">
  <div class="head">
    <div class="dropdown">
      <button type="button" data-dropdown-toggle>2026년 9월 ▾</button>
      <div class="dropdown-menu month-pop">
        <div class="yr"><button type="button">‹</button>2026<button type="button">›</button></div>
        <div class="months">
          <c:forEach var="m" begin="1" end="12"><a href="?ym=2026-${m lt 10 ? '0' : ''}${m}" class="${m eq 9 ? 'is-active' : ''}">${m}월</a></c:forEach>
        </div>
      </div>
    </div>
    <div class="nav"><a href="?ym=2026-08" aria-label="이전 달">‹</a><a href="?ym=2026-09" class="t-bold">오늘</a><a href="?ym=2026-10" aria-label="다음 달">›</a></div>
  </div>
  <div class="grid">
    <span class="dow">일</span><span class="dow">월</span><span class="dow">화</span><span class="dow">수</span><span class="dow">목</span><span class="dow">금</span><span class="dow">토</span>
    <span class="muted">31</span>
    <c:set var="calList" value=",${calDays}," />
  <c:forEach var="d" begin="1" end="30">
      <c:set var="dStr" value=",${d}," />
      <span class="${d eq 19 ? 'today' : ''} ${fn:contains(calList, dStr) ? 'has' : ''}">${d}</span>
    </c:forEach>
  </div>
  <p class="legend">● 경기 있음</p>
</aside>
  </div>
</div>
</main></div>
<%@ include file="/jsp/common/footer.jsp" %>
