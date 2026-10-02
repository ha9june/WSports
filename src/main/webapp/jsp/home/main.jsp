<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  메인 (main.jsp) - 담당: 변재언
  피그마: Main / Landing / Desktop
  권한별 차이 : 비회원은 추천 대신 인기 경기 기준 문구, 헤더 로그인 버튼
--%>
<c:set var="pageTitle" value="메인" />
<c:set var="pageCss" value="home" />
<c:set var="pageJs" value="" />
<c:set var="showFooter" value="true" />
<%@ include file="/jsp/common/header.jsp" %>
<script>
	$(function(){
		

	});
</script>
<section class="hero">
  <div class="container">
    <p class="eyebrow">혼자여도, 팀이어도, 매치온에서</p>
    <h1>경기를 찾고, 팀에 들어가고,<br>뛴 후엔 후기를 남겨보세요</h1>
    <p>경기 찾기, 팀, 후기까지 · 매치온 하나로 축구·농구·테니스·배드민턴을 즐겨보세요.</p>
    <a class="btn btn-primary" href="${ctx}/match/list">경기 찾아보기</a>
  </div>
</section>

<main class="page">
  <div class="container">
    <section>
      <div class="section-head">
        <div>
          <h2 class="section-title">경기 찾기</h2>
          <p class="section-desc">지금 열려있는 경기를 둘러보세요.</p>
        </div>
        <a class="t-brand t-13" href="${ctx}/match/list" style="font-weight:500">전체보기 →</a>
      </div>
      
      
	<div id="recomandMatchListDiv" class="feature-row">
	    <c:forEach var="match" items="${rList}">

<%--  	        ${match.title}
	        ${match.sport}
	        ${match.startTime}
	        ${match.endTime}
	        ${match.region}
	        ${match.participationFee}
	        ${match.maxPeople} 
	        ${match.currentPeople} --%> 
	        <br>

	  		<c:set var="sportClass" value="${match.sport eq '축구' ? 'football' :
    		    match.sport eq '농구' ? 'basketball' :	
                match.sport eq '테니스' ? 'tennis' :
                match.sport eq '배드민턴' ? 'badminton' : ''}" />
			<a class="match-card ${sportClass}" href="${ctx}/match/detail/view?num=${match.personalMatchId}">
			    <img class="art" src="${ctx}/img/art-${sportClass}.png" alt="">
			    <span class="sport-tag ${sportClass}">${match.sport}</span>
			    <button type="button" class="fav-btn bare" data-fav data-auth aria-label="관심 경기">${heart}</button>
			    <span class="signal"><img src="${ctx}/img/icon-pin-14.svg" alt="">${role eq 'guest' ? '인기 경기' : '지역 · 실력 일치'}</span>
			    <div class="body">
			      <p class="title">${match.title}</p>
			      <p class="when"><img src="${ctx}/img/icon-calendar-14.svg" alt="">${match.startTime} · ${match.region}</p>
			      <p class="price">${match.participationFee}원</p>
			    </div>
			    <p class="count">${match.currentPeople}명<small>/ 정원 ${match.maxPeople}명</small></p>
			    <div class="bar"><i style="width:${match.currentPeople * 100 / match.maxPeople}%"></i></div>
			  </a>
	    </c:forEach>
	</div>
      
    </section>

    <section class="landing-section">
      <div class="section-head">
        <div>
          <h2 class="section-title">팀</h2>
          <p class="section-desc">꾸준히 함께 뛸 사람들을 팀에서 만나보세요.</p>
        </div>
        <a href="${ctx}/jsp/team/teamList.jsp">전체보기 →</a>
      </div>
      <%-- TODO: <c:forEach var="t" items="${teamList}"> --%>
      <div id="recomandTeamListDiv" class="team-mini-row">
        <a class="team-mini" href="${ctx}/jsp/team/teamDetail.jsp">
          <div class="top"><img src="${ctx}/img/team-football.png" alt="">
            <div><strong>서울 풋살 크루</strong><p class="meta">축구/풋살 · 마포</p>
              <p class="sub"><span><img src="${ctx}/img/icon-user-12.svg" alt="">34명</span><span><img src="${ctx}/img/icon-pin-12.svg" alt="">마포구</span></p></div></div>
          <div class="foot"><span class="sport-tag football">축구/풋살</span></div>
        </a>
        <a class="team-mini" href="${ctx}/jsp/team/teamDetail.jsp">
          <div class="top"><img src="${ctx}/img/team-basketball.png" alt="">
            <div><strong>라켓메이트</strong><p class="meta">농구 · 송파/강동</p>
              <p class="sub"><span><img src="${ctx}/img/icon-user-12.svg" alt="">18명</span><span><img src="${ctx}/img/icon-pin-12.svg" alt="">송파구</span></p></div></div>
          <div class="foot"><span class="sport-tag basketball">농구</span></div>
        </a>
        <a class="team-mini" href="${ctx}/jsp/team/teamDetail.jsp">
          <div class="top"><img src="${ctx}/img/team-tennis.png" alt="">
            <div><strong>셔틀콕 데이</strong><p class="meta">테니스 · 영등포/구로</p>
              <p class="sub"><span><img src="${ctx}/img/icon-user-12.svg" alt="">26명</span><span><img src="${ctx}/img/icon-pin-12.svg" alt="">영등포구</span></p></div></div>
          <div class="foot"><span class="sport-tag tennis">테니스</span></div>
        </a>
        <a class="team-mini" href="${ctx}/jsp/team/teamDetail.jsp">
          <div class="top"><img src="${ctx}/img/team-badminton.png" alt="">
            <div><strong>서울롬 데이</strong><p class="meta">배드민턴 · 노원/도봉</p>
              <p class="sub"><span><img src="${ctx}/img/icon-user-12.svg" alt="">22명</span><span><img src="${ctx}/img/icon-pin-12.svg" alt="">노원구</span></p></div></div>
          <div class="foot"><span class="sport-tag badminton">배드민턴</span></div>
        </a>
      </div>
    </section>

    <section class="landing-section">
      <div class="section-head">
        <div>
          <h2 class="section-title">후기</h2>
          <p class="section-desc">먼저 뛰어본 사람들의 이야기를 들어보세요.</p>
        </div>
        <a href="${ctx}/jsp/review/reviewList.jsp">전체보기 →</a>
      </div>
      <%-- TODO: <c:forEach var="r" items="${reviewList}"> --%>
      <div class="review-mini-row">
        <a class="review-mini" href="${ctx}/jsp/review/reviewDetail.jsp">
          <div class="top"><span class="sport-tag football">축구/풋살</span><time>2026.09.16</time></div>
          <strong>매너 좋은 사람들과 함께한 토요일 풋살</strong>
          <p>경기 매칭이 빠르고 매너 온도가 높은 분들이 많아서 계속 참여하게 돼요. 다음 주에도 신청했어요.</p>
        </a>
        <a class="review-mini" href="${ctx}/jsp/review/reviewDetail.jsp">
          <div class="top"><span class="sport-tag tennis">테니스</span><time>2026.09.14</time></div>
          <strong>실력별 매칭 덕분에 편하게 즐긴 테니스</strong>
          <p>실력대가 잘 맞아서 처음 오는 분들도 편하게 즐길 수 있었어요.</p>
        </a>
        <a class="review-mini" href="${ctx}/jsp/review/reviewDetail.jsp">
          <div class="top"><span class="sport-tag badminton">배드민턴</span><time>2026.09.12</time></div>
          <strong>퇴근 후 바로 참가한 배드민턴 후기</strong>
          <p>퇴근 후에 바로 참가할 수 있는 경기가 많아서 좋아요.</p>
        </a>
      </div>
    </section>
  </div>
</main>

<%@ include file="/jsp/common/footer.jsp" %>
