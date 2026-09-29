<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀 찾기 (teamList.jsp) - 담당: 하준수
  피그마: Club / Find / Desktop (Guest · Member)
  비회원은 [팀 만들기] 클릭 시 로그인 안내 모달이 열립니다.
--%>
<c:set var="pageTitle" value="팀 찾기" />
<c:set var="pageCss" value="home,team" />
<c:set var="pageJs" value="home" />
<c:set var="activeNav" value="team" />
<c:set var="showFooter" value="true" />
<c:set var="demoRoles" value="guest,member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="rail">
    <div class="page-head" style="margin-bottom:18px"><h1 class="page-title lg">팀</h1><p class="page-desc">가입할 팀을 찾거나 다른 팀과 매칭해보세요.</p></div>
    <nav class="tabs big"><a class="tab is-active" href="${ctx}/jsp/team/teamList.jsp">팀 찾기</a><a class="tab" href="${ctx}/jsp/team/teamMatchList.jsp">팀 경기</a></nav>

    <form class="search-shell" method="get" action="${ctx}/jsp/team/teamList.jsp">
      <div class="filter-row">
        <div class="filter-cluster">
          <div class="chip-group" data-select="multi" data-name="sport"><span class="chip-label">종목</span>
            <button type="button" class="chip">축구/풋살</button><button type="button" class="chip">농구</button><button type="button" class="chip">테니스</button><button type="button" class="chip">배드민턴</button></div>
          <div class="filter-more">
            <button type="button" class="btn btn-outline btn-sm" data-filter-toggle>필터 더보기 +</button><span class="count">0</span>
            <div class="filter-panel">
              <div class="chip-group" data-select="single" data-name="gender"><span class="chip-label">성별</span><button type="button" class="chip neutral is-selected" data-all>전체</button><button type="button" class="chip">남자</button><button type="button" class="chip">여자</button><button type="button" class="chip">성별 무관</button></div>
              <div class="chip-group" data-select="multi" data-name="days"><span class="chip-label">요일</span><button type="button" class="chip">평일</button><button type="button" class="chip">주말</button></div>
              <div class="chip-group" data-select="multi" data-name="level"><span class="chip-label">레벨</span><button type="button" class="chip">입문</button><button type="button" class="chip">초급</button><button type="button" class="chip">중급</button><button type="button" class="chip">상급</button></div>
            </div>
          </div>
        </div>
        <button type="button" class="btn-reset" data-filter-reset>필터 초기화</button>
      </div>
      <div class="input-row">
        <select class="select" name="region" style="width:250px"><option value="">지역 검색</option><option>서울 마포구</option><option>서울 송파구</option><option>서울 성동구</option></select>
        <input class="input keyword" name="keyword" placeholder="팀명 또는 키워드 검색">
        <button type="submit" class="btn btn-primary btn-lg" style="width:108px">검색</button>
      </div>
    </form>

    <div class="list-meta"><p><b>팀 18개</b><span>1–12 / 18</span></p>
      <select class="select" name="sort" aria-label="정렬"><option>추천순</option><option>최신순</option><option>인원순</option></select></div>

    <%-- TODO: <c:forEach var="t" items="${teamList}"> 로 교체. (아래는 시연용 더미 데이터) --%>
    <div class="team-grid">
      <c:forTokens var="row" delims="|" items="서울 풋살 크루^football^축구/풋살 · 마포/서대문^34^마포구^토 · 일 · 저녁^20~30대 · 초급 · 성별 무관^2일 전|라켓메이트^tennis^테니스 · 송파/강동^18^송파구^화 · 목 · 야간^20~40대 · 중급 · 성별 무관^1일 전|셔틀콕 데이^badminton^배드민턴 · 영등포/구로^26^영등포구^토 · 오후^20~30대 · 초급 · 여자^3일 전|주말 바스켓^basketball^농구 · 성동/광진^22^성동구^일 · 오전^30~40대 · 중급 · 남자^오늘|강남 풋살렙^football^축구/풋살 · 강남/서초^41^강남구^수 · 금 · 저녁^20~30대 · 중급 · 성별 무관^오늘|성수 바스켓^basketball^농구 · 성동/광진^29^성동구^화 · 목 · 야간^20~30대 · 중급 · 성별 무관^1일 전|올림픽 테니스^tennis^테니스 · 송파/강동^16^송파구^토 · 일 · 오전^30~40대 · 초중급 · 성별 무관^2일 전|셔틀메이트^badminton^배드민턴 · 강서/양천^33^강서구^월 · 수 · 저녁^20~40대 · 중급 · 성별 무관^오늘|노원 풋살 클럽^football^축구/풋살 · 노원/도봉^27^노원구^토 · 오후^20~30대 · 초급 · 성별 무관^4일 전|북촌 라켓클럽^tennis^테니스 · 종로/성북^20^종로구^수 · 토 · 오전^30~40대 · 중급 · 성별 무관^1일 전|잠실 바스켓볼^basketball^농구 · 송파/강동^24^송파구^금 · 일 · 저녁^20~30대 · 초중급 · 성별 무관^오늘|강서 셔틀콕^badminton^배드민턴 · 강서/양천^19^강서구^화 · 금 · 야간^20~30대 · 중급 · 성별 무관^2일 전">
        <c:set var="t" value="${fn:split(row, '^')}" />
        <a class="team-card" href="${ctx}/jsp/team/teamDetail.jsp">
          <div class="top"><img src="${ctx}/img/team-${t[1]}.png" alt="">
            <div><strong>${t[0]}</strong><p class="meta">${t[2]}</p>
              <p class="sub"><span><img src="${ctx}/img/icon-user-12.svg" alt="">${t[3]}명</span><span><img src="${ctx}/img/icon-pin-12.svg" alt="">${t[4]}</span></p></div></div>
          <p class="cond">${t[5]}<br>${t[6]}<br>최근 활동 ${t[7]}</p>
        </a>
      </c:forTokens>
    </div>
    <div class="more-wrap"><button type="button" class="btn-more">↓ &nbsp;더보기</button></div>
  </div>
</main>
<a class="fab" href="${ctx}/jsp/team/teamMakeForm.jsp" data-auth><span class="fab-label">팀 만들기</span><span class="fab-btn" aria-hidden="true"></span></a>
<%@ include file="/jsp/common/footer.jsp" %>
