<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  팀 경기 목록 / 상대팀 찾기 (teamMatchList.jsp) - 담당: 하준수
  피그마: Club / Matches / Desktop (Guest · Member)
  비회원은 찜/경기 만들기 시 로그인 안내 모달이 열립니다.
--%>
<c:set var="pageTitle" value="팀 경기" />
<c:set var="pageCss" value="home,team" />
<c:set var="pageJs" value="home" />
<c:set var="activeNav" value="teamMatch" />
<c:set var="showFooter" value="true" />
<c:set var="demoRoles" value="guest,member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="rail">
    <div class="page-head" style="margin-bottom:18px"><h1 class="page-title lg">팀</h1><p class="page-desc">가입할 팀을 찾거나 다른 팀과 매칭해보세요.</p></div>
    <nav class="tabs big"><a class="tab" href="${ctx}/jsp/team/teamList.jsp">팀 찾기</a><a class="tab is-active" href="${ctx}/jsp/team/teamMatchList.jsp">팀 경기</a></nav>
    <form class="search-shell" method="get" action="${ctx}/jsp/team/teamMatchList.jsp" style="margin-bottom:24px">
      <div class="filter-row">
        <div class="filter-cluster">
          <div class="chip-group" data-select="multi" data-name="sport"><span class="chip-label">종목</span>
            <button type="button" class="chip">축구/풋살</button><button type="button" class="chip">농구</button><button type="button" class="chip">테니스</button><button type="button" class="chip">배드민턴</button></div>
          <div class="filter-more">
            <button type="button" class="btn btn-outline btn-sm" data-filter-toggle>필터 더보기 +</button><span class="count">0</span>
            <div class="filter-panel">
              <div class="chip-group" data-select="single" data-name="gender"><span class="chip-label">성별</span><button type="button" class="chip neutral is-selected" data-all>전체</button><button type="button" class="chip">남자</button><button type="button" class="chip">여자</button><button type="button" class="chip">성별 무관</button></div>
              <div class="chip-group" data-select="multi" data-name="size"><span class="chip-label">인원</span><button type="button" class="chip">5 vs 5</button><button type="button" class="chip">6 vs 6</button><button type="button" class="chip">11 vs 11</button></div>
              <div class="chip-group" data-select="multi" data-name="level"><span class="chip-label">팀 레벨</span><button type="button" class="chip">입문</button><button type="button" class="chip">초급</button><button type="button" class="chip">중급</button><button type="button" class="chip">상급</button></div>
            </div>
          </div>
        </div>
        <button type="button" class="btn-reset" data-filter-reset>필터 초기화</button>
      </div>
      <div class="input-row">
        <select class="select" name="region"><option value="">지역 검색</option><option>서울 마포구</option><option>서울 송파구</option></select>
        <select class="select date" name="period"><option value="">기간 선택</option><option>이번 주</option><option>다음 주</option><option>이번 달</option></select>
        <input class="input keyword" name="keyword" placeholder="키워드 검색">
        <button type="submit" class="btn btn-primary btn-lg" style="width:96px">검색</button>
      </div>
    </form>

    <%-- TODO: <c:forEach var="m" items="${teamMatchList}"> 로 교체 (아래는 시연용 더미) --%>
    <c:forTokens var="row" delims="|" items="서울 풋살 크루 vs 상대 팀 모집^football^9/27^17:00^난지 풋살장|주말 바스켓 연습경기^basketball^10/03^15:00^성동구 체육관|라켓메이트 교류전^tennis^10/10^10:00^송파 테니스장|셔틀콕 데이 상대 팀 모집^badminton^10/12^20:00^영등포 체육관">
      <c:set var="m" value="${fn:split(row, '^')}" />
      <div class="tm-row" data-href="${ctx}/jsp/team/teamMatchDetail.jsp">
        <div class="left"><span class="pill pill-success bd">모집중</span><img src="${ctx}/img/sport-icon-${m[1]}.png" alt=""></div>
        <div class="main"><strong>${m[0]}</strong>
          <p class="meta"><span><img src="${ctx}/img/icon-calendar-14.svg" alt="">${m[2]}</span><span><img src="${ctx}/img/icon-clock-16.svg" alt="">${m[3]}</span><span><img src="${ctx}/img/icon-pin-14.svg" alt="">${m[4]}</span></p></div>
        <div class="aside">10,000원<button type="button" class="fav-btn" data-fav data-auth aria-label="관심 경기">${heart}</button></div>
      </div>
    </c:forTokens>
    <nav class="pagination"><a href="#">‹</a><a href="#" class="is-active">1</a><a href="#">2</a><a href="#">3</a><a href="#">›</a></nav>
  </div>
</main>
<a class="fab" href="${ctx}/jsp/team/teamMatchMakeForm.jsp" data-auth><span class="fab-label">상대 팀 모집</span><span class="fab-btn" aria-hidden="true"></span></a>
<%@ include file="/jsp/common/footer.jsp" %>
