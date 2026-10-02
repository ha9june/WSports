<%@ page pageEncoding="UTF-8" %>
<%--
  마이페이지 사이드바 (워크스페이스 시작 태그 포함)
   - sideMenu : user | profile | personalMatch | createdMatch | heartMatch | myTeam | teamMatch
                | review | alarm | support | personalSettlement | teamSettlement | payment
  ※ 이 파일은 <div class="workspace"> ... <main class="work"> 를 열어둡니다.
     페이지 본문 마지막에서 </main></div> 로 닫아주세요.
--%>
<div class="workspace">
  <aside class="side" aria-label="마이페이지 메뉴">
    <a class="me" href="${ctx}/jsp/mypage/myPageProfile.jsp">
      <span class="avatar sm default"></span>
      <span><strong>매치온 회원</strong><small>내 평점 ★ 4.6</small></span>
    </a>

    <div class="group">
      <p class="group-title">계정</p>
      <nav class="menu">
        <a href="${ctx}/member/mypage/view" class="${sideMenu eq 'user' ? 'is-active' : ''}">내 정보</a>
        <a href="${ctx}/member/profile/view" class="${sideMenu eq 'profile' ? 'is-active' : ''}">내 프로필</a>
      </nav>
    </div>
    <div class="group">
      <p class="group-title">경기</p>
      <nav class="menu">
        <a href="${ctx}/mypage/matches/participating" class="${sideMenu eq 'personalMatch' ? 'is-active' : ''}">참가 경기</a>
        <a href="${ctx}/jsp/mypage/myPageCreatedPersonalMatch.jsp" class="${sideMenu eq 'createdMatch' ? 'is-active' : ''}">내가 만든 경기</a>
        <a href="${ctx}/jsp/mypage/myPageHeartMatch.jsp" class="${sideMenu eq 'heartMatch' ? 'is-active' : ''}">관심경기</a>
      </nav>
    </div>
    <div class="group">
      <p class="group-title">팀</p>
      <nav class="menu">
        <a href="${ctx}/jsp/mypage/myPageMyTeam.jsp" class="${sideMenu eq 'myTeam' ? 'is-active' : ''}">내 팀</a>
        <a href="${ctx}/jsp/mypage/myPageTeamMatch.jsp" class="${sideMenu eq 'teamMatch' ? 'is-active' : ''}">팀 경기</a>
      </nav>
    </div>
    <div class="group">
      <p class="group-title">기타</p>
      <nav class="menu">
        <a href="${ctx}/jsp/mypage/myPageReview.jsp" class="${sideMenu eq 'review' ? 'is-active' : ''}">내 후기</a>
        <a href="${ctx}/jsp/mypage/myPageAlarm.jsp" class="${sideMenu eq 'alarm' ? 'is-active' : ''}">알림 <span class="count-badge">3</span></a>
        <a href="${ctx}/jsp/support/reportList.jsp" class="${sideMenu eq 'support' ? 'is-active' : ''}">신고・문의사항</a>
      </nav>
    </div>
    <div class="group">
      <p class="group-title">정산・결제</p>
      <nav class="menu">
        <a href="${ctx}/jsp/settlement/personalSettlementList.jsp" class="${sideMenu eq 'personalSettlement' ? 'is-active' : ''}">개인 경기 정산</a>
        <a href="${ctx}/jsp/settlement/teamSettlementList.jsp" class="${sideMenu eq 'teamSettlement' ? 'is-active' : ''}">팀 경기 정산</a>
        <a href="${ctx}/jsp/payment/paymentList.jsp" class="${sideMenu eq 'payment' ? 'is-active' : ''}">결제 내역</a>
      </nav>
    </div>

    <div class="bottom">
      <%-- TODO: 로그아웃 서블릿 URL 로 교체 (예: ${ctx}/logout) --%>
      <a href="${ctx}/auth/logout/submit">로그아웃</a>
    </div>
  </aside>
  <main class="work">