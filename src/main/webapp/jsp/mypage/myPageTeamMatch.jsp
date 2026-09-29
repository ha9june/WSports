<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀 경기 (myPageTeamMatch.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Club Matches / Desktop
  목록은 종목·상태 필터와 월 달력으로 조회합니다.
  TODO: 아래 act-card 를 <c:forEach var="m" items="${matchList}"> 로 반복 (날짜별 그룹 헤더 포함)
--%>
<c:set var="pageTitle" value="팀 경기" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="teamMatch" />
<c:set var="calDays" value="13,20,27" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner full" style="max-width:1000px">
  <h1 class="section-title">팀 경기</h1>
  <p class="section-desc">내 팀의 경기를 종목, 상태와 월별 달력으로 확인하세요.</p>
  <form class="act-filters" method="get"><select class="select" name="teamNo"><option>전체 팀</option><option>서울 풋살 크루</option><option>성동 농구 모임</option></select><select class="select" name="sport"><option>전체 종목</option><option>축구/풋살</option><option>농구</option><option>테니스</option><option>배드민턴</option></select><select class="select" name="status"><option>전체 상태</option><option>모집중</option><option>경기 예정</option><option>경기 종료</option><option>취소</option></select></form>
  <div class="act-layout">
    <section>
      <div class="act-head"><b>2026년 9월 · 3건</b><a class="btn-reset" href="?">필터 초기화</a></div>
      <p class="date-label">9월 13일 <span>일</span></p>
    <div class="act-card" data-href="${ctx}/jsp/team/teamMatchDetail.jsp?state=completed">
      <div class="left"><span class="pill pill-danger">경기 종료</span><img src="${ctx}/img/sport-icon-football.png" alt=""></div>
      <div class="main"><strong>서울 풋살 크루 vs 망원 FC</strong>
        <p class="meta"><span><img src="${ctx}/img/icon-calendar-14.svg" alt="">9/13 (일)</span><span><img src="${ctx}/img/icon-clock-16.svg" alt="">17:00 ~ 19:00</span><span><img src="${ctx}/img/icon-pin-14.svg" alt="">서울 마포구 난지 풋살장</span></p></div>
      <div class="aside"><div class="top">10,000원<button type="button" class="fav-btn " data-fav aria-label="관심 경기">${heart}</button></div><div class="btns"><a class="btn btn-outline btn-xs" href="${ctx}/jsp/review/reviewWrite.jsp?state=clubMatch">후기 작성</a><a class="btn btn-primary btn-xs" href="${ctx}/jsp/team/teamMatchResultEdit.jsp">참가 팀 평가</a></div></div>
    </div>
      <p class="date-label">9월 20일 <span>일</span></p>
    <div class="act-card" data-href="${ctx}/jsp/team/teamMatchDetail.jsp?state=hostMatched">
      <div class="left"><span class="pill pill-info">매칭 확정</span><img src="${ctx}/img/sport-icon-football.png" alt=""></div>
      <div class="main"><strong>서울 풋살 크루 vs 마포 FC</strong>
        <p class="meta"><span><img src="${ctx}/img/icon-calendar-14.svg" alt="">9/20 (일)</span><span><img src="${ctx}/img/icon-clock-16.svg" alt="">17:00 ~ 19:00</span><span><img src="${ctx}/img/icon-pin-14.svg" alt="">서울 마포구 난지 풋살장</span><span><img src="${ctx}/img/icon-user-12.svg" alt="">8/10 · 최소 8명 <span class="cap"><i style="width:80%"></i></span></span></p></div>
      <div class="aside"><div class="top">10,000원<button type="button" class="fav-btn " data-fav aria-label="관심 경기">${heart}</button></div><div class="btns"><a class="btn btn-primary btn-xs" href="${ctx}/jsp/team/teamMatchParticipants.jsp">참가 팀 확인</a></div></div>
    </div>
      <p class="date-label">9월 27일 <span>일</span></p>
    <div class="act-card" data-href="${ctx}/jsp/team/teamMatchDetail.jsp?state=hostRecruiting">
      <div class="left"><span class="pill pill-success">모집중</span><img src="${ctx}/img/sport-icon-football.png" alt=""></div>
      <div class="main"><strong>서울 풋살 크루 vs 상대 팀 모집</strong>
        <p class="meta"><span><img src="${ctx}/img/icon-calendar-14.svg" alt="">9/27 (일)</span><span><img src="${ctx}/img/icon-clock-16.svg" alt="">17:00 ~ 19:00</span><span><img src="${ctx}/img/icon-pin-14.svg" alt="">서울 마포구 난지 풋살장</span><span><img src="${ctx}/img/icon-user-12.svg" alt="">8/10 · 최소 8명 <span class="cap"><i style="width:80%"></i></span></span></p></div>
      <div class="aside"><div class="top">10,000원<button type="button" class="fav-btn " data-fav aria-label="관심 경기">${heart}</button></div><div class="btns"><a class="btn btn-primary btn-xs" href="${ctx}/jsp/team/teamMatchParticipants.jsp">참가 팀 확인</a></div></div>
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
