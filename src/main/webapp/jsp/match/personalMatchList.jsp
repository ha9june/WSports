<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  경기 찾기 (personalMatchList.jsp) - 담당: 변재언
  피그마: Home / Guest · Member · Admin / Desktop, Home / * / Map Search (Typing · Moved · Pin Selected)
  ─ 하나의 JSP 로 처리 ─
   role  : guest(인기 기준 추천, 로그인 버튼) / member·admin(맞춤 추천 탭 추가)
   state : list(일반 검색) | map(지도 검색) | mapTyping(지도 검색어 입력 중) | mapPin(지도 핀 선택)
--%>
<c:set var="state" value="${empty param.state ? 'list' : param.state}" />
<c:set var="isMap" value="${fn:startsWith(state, 'map')}" />
<c:set var="pageTitle" value="경기 찾기" />
<c:set var="pageCss" value="home" />
<c:set var="pageJs" value="home" />
<c:set var="activeNav" value="match" />
<c:set var="showFooter" value="true" />
<c:set var="demoStates" value="list:일반 검색|map:지도 검색|mapTyping:지도-입력 중|mapPin:지도-핀 선택" />
<%@ include file="/jsp/common/header.jsp" %>

<main class="page">
  <div class="container">

    <%-- ===== 지금 볼 만한 경기 ===== --%>
    <section>
      <h2 class="section-title">지금 볼 만한 경기</h2>
      <p class="section-desc">
        <c:choose>
          <c:when test="${role eq 'guest'}">인기 경기, 마감 임박, 신규 모집을 빠르게 확인해보세요.</c:when>
          <c:otherwise>내 조건에 맞는 경기와 서비스에서 인기 있는 경기를 함께 보여드려요.</c:otherwise>
        </c:choose>
      </p>
      <div class="feature-tabs">
        <c:if test="${role ne 'guest'}"><a href="#" class="is-active">추천 경기</a></c:if>
        <a href="#" class="${role eq 'guest' ? 'is-active' : ''}">인기 경기</a>
        <a href="#">마감 임박</a>
        <a href="#">신규 모집</a>
      </div>
      <%@ include file="/jsp/common/featuredMatchRow.jsp" %>
    </section>

    <%-- ===== 검색 ===== --%>
    <section class="search-intro">
      <h2>경기를 검색해보세요!</h2>
      <p>종목, 지역, 날짜, 실력과 키워드로 원하는 경기를 찾아보세요.</p>
      <div class="search-mode">
        <a href="?state=list" class="${isMap ? '' : 'is-active'}">일반 검색</a>
        <a href="?state=map" class="${isMap ? 'is-active' : ''}">지도기반 검색</a>
      </div>

      <%-- TODO: action 을 검색 서블릿 URL 로 교체 (예: ${ctx}/match/list) --%>
      <form class="search-shell" action="${ctx}/jsp/match/personalMatchList.jsp" method="get">
        <input type="hidden" name="state" value="${state}">
        <div class="filter-row">
          <div class="filter-cluster">
            <div class="chip-group" data-select="multi" data-name="sport">
              <span class="chip-label">종목</span>
              <button type="button" class="chip" data-value="FOOTBALL">축구/풋살</button>
              <button type="button" class="chip" data-value="BASKETBALL">농구</button>
              <button type="button" class="chip" data-value="TENNIS">테니스</button>
              <button type="button" class="chip" data-value="BADMINTON">배드민턴</button>
            </div>
            <div class="filter-more">
              <button type="button" class="btn btn-outline btn-sm" data-filter-toggle>필터 더보기 +</button>
              <span class="count">0</span>
              <div class="filter-panel">
                <div class="chip-group" data-select="single" data-name="gender">
                  <span class="chip-label">성별</span>
                  <button type="button" class="chip neutral is-selected" data-all data-value="ALL">전체</button>
                  <button type="button" class="chip" data-value="M">남성</button>
                  <button type="button" class="chip" data-value="F">여성</button>
                  <button type="button" class="chip" data-value="MIX">혼성</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="age">
                  <span class="chip-label">연령대</span>
                  <button type="button" class="chip">20대</button><button type="button" class="chip">30대</button>
                  <button type="button" class="chip">40대</button><button type="button" class="chip">50대+</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="level">
                  <span class="chip-label">실력</span>
                  <button type="button" class="chip">입문</button><button type="button" class="chip">초급</button>
                  <button type="button" class="chip">중급</button><button type="button" class="chip">상급</button>
                </div>
                <div class="chip-group" data-select="multi" data-name="time">
                  <span class="chip-label">시간대</span>
                  <button type="button" class="chip">오전</button><button type="button" class="chip">오후</button><button type="button" class="chip">저녁</button>
                </div>
              </div>
            </div>
          </div>
          <button type="button" class="btn-reset" data-filter-reset>필터 초기화</button>
        </div>

        <div class="input-row">
          <c:choose>
            <c:when test="${isMap}">
              <div class="map-query ${state eq 'mapTyping' ? 'is-focus' : ''}">
                <span class="t-3">⌕</span>
                <c:choose>
                  <c:when test="${state eq 'mapTyping'}">
                    <input type="text" name="keyword" value="망원" autofocus aria-label="지역 또는 경기명">
                  </c:when>
                  <c:otherwise>
                    <span class="token-chip">📍 마포구 망원동 <button type="button" aria-label="지역 삭제">✕</button></span>
                    <input type="text" name="keyword" placeholder="경기명·팀명도 검색할 수 있어요" aria-label="키워드">
                  </c:otherwise>
                </c:choose>
                <div class="search-dropdown" ${state eq 'mapTyping' ? '' : 'hidden'}>
                  <p class="grp-title">지역 · 장소 — 선택하면 지도가 이동해요</p>
                  <a href="?state=map" class="is-hover"><span class="ic">📍</span><span><b>망원</b> 동</span></a>
                  <a href="?state=map"><span class="ic">📍</span><span><b>망원</b> 한강공원</span></a>
                  <a href="?state=map"><span class="ic">📍</span><span><b>망원</b> 시장</span></a>
                  <hr>
                  <p class="grp-title">경기 — 현재 지도 영역에서 찾아요</p>
                  <a href="${ctx}/jsp/match/personalMatchDetail.jsp"><span class="ic" style="background:var(--ds-bg-muted)">⌕</span>토요일 저녁 풋살 한 판!</a>
                  <a href="?state=map" class="all">'망원'이 들어간 경기 모두 보기</a>
                </div>
              </div>
              <select class="select date" name="period" aria-label="기간"><option>기간 선택</option><option>오늘</option><option>이번 주</option><option>이번 달</option></select>
            </c:when>
            <c:otherwise>
              <select class="select" name="region" aria-label="지역"><option value="">지역 검색</option><option>서울 마포구</option><option>서울 성동구</option><option>서울 송파구</option></select>
              <select class="select date" name="period" aria-label="기간"><option value="">기간 선택</option><option>오늘</option><option>이번 주</option><option>이번 달</option></select>
              <input class="input keyword" type="text" name="keyword" placeholder="키워드 검색" aria-label="키워드">
            </c:otherwise>
          </c:choose>
          <button type="submit" class="btn btn-primary btn-lg">검색</button>
        </div>
      </form>
    </section>

    <c:choose>
      <%-- ===== 지도 기반 검색 결과 ===== --%>
      <c:when test="${isMap}">
        <section class="list-head">
          <h2 class="section-title">지도 기반 경기 찾기</h2>
          <p class="section-desc">검색한 지역 주변 경기를 지도에서 확인하세요.</p>
        </section>
        <div class="map-result">
          <%-- TODO: 카카오/네이버 지도 API 로 교체 (핀 좌표는 경기 장소의 위경도) --%>
          <div class="map-canvas" id="map">
            <a href="#" class="pin ${state eq 'mapPin' ? '' : 'is-active'}" data-pin="m1" style="left:16%;top:26%"><span>풋살 · 1.2km</span></a>
            <a href="#" class="pin" data-pin="m2" style="left:68%;top:22%"><span>테니스 · 2.4km</span></a>
            <a href="#" class="pin ${state eq 'mapPin' ? 'is-active' : ''}" data-pin="m3" style="left:54%;top:55%"><span>농구 · 3.1km</span></a>
            <a href="#" class="pin" data-pin="m4" style="left:37%;top:78%"><span>배드민턴 · 4.0km</span></a>
            <c:if test="${state eq 'mapPin'}">
              <div class="map-popup" style="left:39%;top:9%">
                <span class="sport-tag basketball">농구</span>
                <strong>주말 실내 농구 같이 하실 분</strong>
                <p>9/20 14:00 · 성동구 · 3.1km</p>
                <p class="price">8,000원</p>
                <a class="btn btn-primary btn-sm btn-block" href="${ctx}/jsp/match/personalMatchDetail.jsp">경기 자세히 보기</a>
              </div>
            </c:if>
            <button type="button" class="ctrl" style="bottom:60px" aria-label="현재 위치">⌖</button>
            <button type="button" class="ctrl" style="bottom:16px" aria-label="확대">+</button>
          </div>
          <div class="map-list">
            <h3>지도 주변 경기 4개</h3>
            <a href="${ctx}/jsp/match/personalMatchDetail.jsp" class="football ${state eq 'mapPin' ? '' : 'is-active'}" data-pin="m1"><small>축구/풋살</small><strong>토요일 저녁 풋살 한 판!</strong><span>9/19 19:00 · 망원동 · 1.2km</span></a>
            <a href="${ctx}/jsp/match/personalMatchDetail.jsp" class="tennis" data-pin="m2"><small>테니스</small><strong>초중급 테니스 복식 모집</strong><span>9/21 18:30 · 송파구 · 2.4km</span></a>
            <a href="${ctx}/jsp/match/personalMatchDetail.jsp" class="basketball ${state eq 'mapPin' ? 'is-active' : ''}" data-pin="m3"><small>농구</small><strong>주말 실내 농구 같이 하실 분</strong><span>9/20 14:00 · 성동구 · 3.1km</span></a>
            <a href="${ctx}/jsp/match/personalMatchDetail.jsp" class="badminton" data-pin="m4"><small>배드민턴</small><strong>퇴근 후 배드민턴</strong><span>9/22 20:00 · 영등포구 · 4.0km</span></a>
          </div>
        </div>
      </c:when>

      <%-- ===== 일반 검색 결과 : 경기 리스트 ===== --%>
      <c:otherwise>
        <section class="list-head">
          <h2 class="section-title">경기 리스트</h2>
          <p class="section-desc">검색 조건에 맞는 경기를 한 줄씩 빠르게 비교해보세요.</p>
        </section>
        <%-- TODO: <c:forEach var="m" items="${matchList}"> 로 아래 행 하나를 반복 --%>
        <div class="match-rows">
          <a class="match-row" href="${ctx}/jsp/match/personalMatchDetail.jsp">
            <div class="left"><span class="pill pill-success bd">모집중</span><img src="${ctx}/img/sport-icon-football.png" alt="축구/풋살"></div>
            <div class="main">
              <p class="title">토요일 저녁 풋살 한 판!</p>
              <div class="meta">
                <span class="it people"><img src="${ctx}/img/icon-person.svg" alt="">8/10 &nbsp; 최소 8명 <span class="cap"><i style="width:80%"></i></span></span>
                <span class="it"><img src="${ctx}/img/icon-calendar-16.svg" alt="">9/19 (토)</span>
                <span class="it"><img src="${ctx}/img/icon-clock-16.svg" alt="">19:00</span>
                <span class="it"><img src="${ctx}/img/icon-pin-16.svg" alt="">서울 마포구</span>
                <span class="price">10,000원</span>
                <button type="button" class="fav-btn" data-fav data-auth aria-label="관심 경기">${heart}</button>
              </div>
            </div>
          </a>
          <a class="match-row" href="${ctx}/jsp/match/personalMatchDetail.jsp">
            <div class="left"><span class="pill pill-success bd">모집중</span><img src="${ctx}/img/sport-icon-basketball.png" alt="농구"></div>
            <div class="main">
              <p class="title">주말 실내 농구 같이 하실 분</p>
              <div class="meta">
                <span class="it people"><img src="${ctx}/img/icon-person.svg" alt="">6/8 &nbsp; 최소 6명 <span class="cap"><i style="width:75%"></i></span></span>
                <span class="it"><img src="${ctx}/img/icon-calendar-16.svg" alt="">9/20 (일)</span>
                <span class="it"><img src="${ctx}/img/icon-clock-16.svg" alt="">14:00</span>
                <span class="it"><img src="${ctx}/img/icon-pin-16.svg" alt="">서울 성동구</span>
                <span class="price">8,000원</span>
                <button type="button" class="fav-btn" data-fav data-auth aria-label="관심 경기">${heart}</button>
              </div>
            </div>
          </a>
          <a class="match-row" href="${ctx}/jsp/match/personalMatchDetail.jsp">
            <div class="left"><span class="pill pill-success bd">모집중</span><img src="${ctx}/img/sport-icon-tennis.png" alt="테니스"></div>
            <div class="main">
              <p class="title">초중급 테니스 복식 모집</p>
              <div class="meta">
                <span class="it people"><img src="${ctx}/img/icon-person.svg" alt="">3/4 &nbsp; 최소 4명 <span class="cap"><i style="width:75%"></i></span></span>
                <span class="it"><img src="${ctx}/img/icon-calendar-16.svg" alt="">9/21 (월)</span>
                <span class="it"><img src="${ctx}/img/icon-clock-16.svg" alt="">18:30</span>
                <span class="it"><img src="${ctx}/img/icon-pin-16.svg" alt="">서울 송파구</span>
                <span class="price">15,000원</span>
                <button type="button" class="fav-btn" data-fav data-auth aria-label="관심 경기">${heart}</button>
              </div>
            </div>
          </a>
          <a class="match-row" href="${ctx}/jsp/match/personalMatchDetail.jsp">
            <div class="left"><span class="pill pill-success bd">모집중</span><img src="${ctx}/img/sport-icon-badminton.png" alt="배드민턴"></div>
            <div class="main">
              <p class="title">퇴근 후 배드민턴</p>
              <div class="meta">
                <span class="it people"><img src="${ctx}/img/icon-person.svg" alt="">4/6 &nbsp; 최소 4명 <span class="cap"><i style="width:67%"></i></span></span>
                <span class="it"><img src="${ctx}/img/icon-calendar-16.svg" alt="">9/22 (화)</span>
                <span class="it"><img src="${ctx}/img/icon-clock-16.svg" alt="">20:00</span>
                <span class="it"><img src="${ctx}/img/icon-pin-16.svg" alt="">서울 영등포구</span>
                <span class="price">6,000원</span>
                <button type="button" class="fav-btn" data-fav data-auth aria-label="관심 경기">${heart}</button>
              </div>
            </div>
          </a>
          <a class="match-row" href="${ctx}/jsp/match/personalMatchDetail.jsp">
            <div class="left"><span class="pill pill-success bd">모집중</span><img src="${ctx}/img/sport-icon-football.png" alt="축구/풋살"></div>
            <div class="main">
              <p class="title">일요일 아침 축구 경기</p>
              <div class="meta">
                <span class="it people"><img src="${ctx}/img/icon-person.svg" alt="">10/14 &nbsp; 최소 10명 <span class="cap"><i style="width:71%"></i></span></span>
                <span class="it"><img src="${ctx}/img/icon-calendar-16.svg" alt="">9/27 (일)</span>
                <span class="it"><img src="${ctx}/img/icon-clock-16.svg" alt="">09:00</span>
                <span class="it"><img src="${ctx}/img/icon-pin-16.svg" alt="">서울 강남구</span>
                <span class="price">7,000원</span>
                <button type="button" class="fav-btn" data-fav data-auth aria-label="관심 경기">${heart}</button>
              </div>
            </div>
          </a>
        </div>
        <div class="more-wrap"><button type="button" class="btn-more">↓ &nbsp;더보기</button></div>
      </c:otherwise>
    </c:choose>
  </div>
</main>

<a class="fab" href="${ctx}/jsp/match/personalMatchWriteForm.jsp" data-auth>
  <span class="fab-label">경기 만들기</span><span class="fab-btn" aria-hidden="true"></span>
</a>

<%@ include file="/jsp/common/footer.jsp" %>
