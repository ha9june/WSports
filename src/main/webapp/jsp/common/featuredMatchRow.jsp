<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  추천/인기 경기 카드 4개 (DS / Home Match Card V2)
  main.jsp, personalMatchList.jsp 에서 include 합니다.
  TODO: <c:forEach var="m" items="${featuredList}"> 로 교체
        m.sportCode(football|basketball|tennis|badminton), m.title, m.date, m.region, m.fee, m.current, m.capacity
--%>
<div class="feature-row">
  <a class="match-card football" href="${ctx}/jsp/match/personalMatchDetail.jsp">
    <img class="art" src="${ctx}/img/art-football.png" alt="">
    <span class="sport-tag football">축구/풋살</span>
    <button type="button" class="fav-btn bare" data-fav data-auth aria-label="관심 경기">${heart}</button>
    <span class="signal"><img src="${ctx}/img/icon-pin-14.svg" alt="">${role eq 'guest' ? '인기 경기' : '지역 · 실력 일치'}</span>
    <div class="body">
      <p class="title">토요일 저녁 풋살 한 판!</p>
      <p class="when"><img src="${ctx}/img/icon-calendar-14.svg" alt="">9/19 19:00 · 마포구</p>
      <p class="price">10,000원</p>
    </div>
    <p class="count">8명<small>/ 정원 10명</small></p>
    <div class="bar"><i style="width:80%"></i></div>
  </a>
  <a class="match-card basketball" href="${ctx}/jsp/match/personalMatchDetail.jsp">
    <img class="art" src="${ctx}/img/art-basketball.png" alt="">
    <span class="sport-tag basketball">농구</span>
    <button type="button" class="fav-btn bare" data-fav data-auth aria-label="관심 경기">${heart}</button>
    <span class="signal"><img src="${ctx}/img/icon-pin-14.svg" alt="">${role eq 'guest' ? '마감 임박' : '선호 시간 일치'}</span>
    <div class="body">
      <p class="title">주말 실내 농구 같이 하실 분</p>
      <p class="when"><img src="${ctx}/img/icon-calendar-14.svg" alt="">9/20 14:00 · 성동구</p>
      <p class="price">8,000원</p>
    </div>
    <p class="count">6명<small>/ 정원 8명</small></p>
    <div class="bar"><i style="width:75%"></i></div>
  </a>
  <a class="match-card tennis" href="${ctx}/jsp/match/personalMatchDetail.jsp">
    <img class="art" src="${ctx}/img/art-tennis.png" alt="">
    <span class="sport-tag tennis">테니스</span>
    <button type="button" class="fav-btn bare" data-fav data-auth aria-label="관심 경기">${heart}</button>
    <span class="signal"><img src="${ctx}/img/icon-pin-14.svg" alt="">${role eq 'guest' ? '신규 모집' : '실력 일치'}</span>
    <div class="body">
      <p class="title">초중급 테니스 복식 모집</p>
      <p class="when"><img src="${ctx}/img/icon-calendar-14.svg" alt="">9/21 18:30 · 송파구</p>
      <p class="price">15,000원</p>
    </div>
    <p class="count">3명<small>/ 정원 4명</small></p>
    <div class="bar"><i style="width:75%"></i></div>
  </a>
  <a class="match-card badminton" href="${ctx}/jsp/match/personalMatchDetail.jsp">
    <img class="art" src="${ctx}/img/art-badminton.png" alt="">
    <span class="sport-tag badminton">배드민턴</span>
    <button type="button" class="fav-btn bare" data-fav data-auth aria-label="관심 경기">${heart}</button>
    <span class="signal"><img src="${ctx}/img/icon-pin-14.svg" alt="">${role eq 'guest' ? '인기 경기' : '추천도 높음'}</span>
    <div class="body">
      <p class="title">퇴근 후 배드민턴</p>
      <p class="when"><img src="${ctx}/img/icon-calendar-14.svg" alt="">9/22 20:00 · 영등포구</p>
      <p class="price">6,000원</p>
    </div>
    <p class="count">4명<small>/ 정원 6명</small></p>
    <div class="bar"><i style="width:67%"></i></div>
  </a>
</div>
