<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  후기 목록 (reviewList.jsp) - 담당: 강신우
  피그마: Review / List / Desktop, Review / List / Grouped by Match / Desktop
  ─ 하나의 JSP 로 처리 ─
   state : recent(최근 후기 카드) | grouped(경기별 모아보기)
--%>
<c:set var="state" value="${empty param.state ? 'recent' : param.state}" />
<c:set var="pageTitle" value="후기" />
<c:set var="pageCss" value="review" />
<c:set var="activeNav" value="review" />
<c:set var="showFooter" value="true" />
<c:set var="demoStates" value="recent:최근 후기|grouped:경기별 모아보기" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="rail">
    <div class="page-head"><h1 class="page-title">후기</h1><p class="page-desc">경기 후기를 찾아보고 경험을 공유해보세요.</p></div>
    <form class="review-toolbar" method="get">
      <input type="hidden" name="state" value="${state}">
      <div class="field"><label class="field-label">검색</label><input class="input" name="keyword" placeholder="제목 또는 경기명 검색"></div>
      <div class="chip-group" data-select="single" data-name="sport" style="margin-bottom:8px">
        <button type="button" class="chip neutral is-selected">전체</button><button type="button" class="chip">축구/풋살</button><button type="button" class="chip">농구</button><button type="button" class="chip">테니스</button><button type="button" class="chip">배드민턴</button></div>
    </form>
				
    <c:choose>
      <c:when test="${state eq 'grouped'}">
        <div class="section-head"><h2 class="sub-title">경기별 후기</h2><a class="btn btn-outline btn-xs btn-pill" href="?state=recent">전체 후기 보기</a></div>
        <%-- TODO: <c:forEach var="g" items="${groupList}"> 경기 1건 = 그룹 1개 --%>
        <div class="group-title"><strong>토요일 저녁 풋살 한 판!</strong><span>9/19 (토) 19:00 · 서울 마포구 · 후기 2</span></div>
        <div class="review-grid">
          <a class="review-card" href="${ctx}/jsp/review/reviewDetail.jsp"><div class="thumb">풋살 후기 사진</div><div class="body"><strong>망원 풋살 경기 후기</strong><p class="by">작성자 · 매치온 회원</p><p class="link">참여 경기 · 토요일 저녁 풋살 한 판!</p><p class="cnt">♡ 12 &nbsp; 댓글 4</p></div></a>
          <a class="review-card" href="${ctx}/jsp/review/reviewDetail.jsp"><div class="thumb">풋살 후기 사진</div><div class="body"><strong>초보자도 편하게 참가했어요</strong><p class="by">작성자 · 매치온 회원</p><p class="link">참여 경기 · 토요일 저녁 풋살 한 판!</p><p class="cnt">♡ 6 &nbsp; 댓글 1</p></div></a>
        </div>
        <div class="group-title" style="margin-top:32px"><strong>주말 실내 농구 같이 하실 분</strong><span>9/20 (일) 14:00 · 서울 성동구 · 후기 1</span></div>
        <div class="review-grid">
          <a class="review-card" href="${ctx}/jsp/review/reviewDetail.jsp"><div class="thumb">농구 후기 사진</div><div class="body"><strong>실내 농구 첫 참가</strong><p class="by">작성자 · 매치온 회원</p><p class="link">참여 경기 · 주말 실내 농구 같이 하실 분</p><p class="cnt">♡ 8 &nbsp; 댓글 2</p></div></a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="section-head"><h2 class="sub-title">최근 후기</h2><a class="btn btn-outline btn-xs btn-pill" href="?state=grouped">경기별 모아보기</a></div>
        <%-- TODO: <c:forEach var="r" items="${reviewList}"> --%>
        <div class="review-grid">
          <a class="review-card" href="${ctx}/jsp/review/reviewDetail.jsp"><div class="thumb">풋살 후기 사진</div><div class="body"><strong>망원 풋살 경기 후기</strong><p class="by">작성자 · 매치온 회원</p><p class="link">참여 경기 · 토요일 저녁 풋살 한 판!</p><p class="cnt">♡ 12 &nbsp; 댓글 4</p></div></a>
          <a class="review-card" href="${ctx}/jsp/review/reviewDetail.jsp"><div class="thumb">농구 후기 사진</div><div class="body"><strong>실내 농구 첫 참가</strong><p class="by">작성자 · 매치온 회원</p><p class="link">참여 경기 · 주말 실내 농구 같이 하실 분</p><p class="cnt">♡ 8 &nbsp; 댓글 2</p></div></a>
          <a class="review-card" href="${ctx}/jsp/review/reviewDetail.jsp"><div class="thumb">테니스 후기 사진</div><div class="body"><strong>복식 테니스 즐거웠어요</strong><p class="by">작성자 · 매치온 회원</p><p class="link">참여 경기 · 초중급 테니스 복식 모집</p><p class="cnt">♡ 5 &nbsp; 댓글 1</p></div></a>
          <a class="review-card" href="${ctx}/jsp/review/reviewDetail.jsp"><div class="thumb">배드민턴 후기 사진</div><div class="body"><strong>배드민턴 초보 모임 추천</strong><p class="by">작성자 · 매치온 회원</p><p class="link">참여 경기 · 퇴근 후 배드민턴</p><p class="cnt">♡ 9 &nbsp; 댓글 3</p></div></a>
        </div>
        <nav class="pagination green"><a href="#" class="is-active">1</a><a href="#">2</a><a href="#">3</a></nav>
      </c:otherwise>
    </c:choose>
  </div>
</main>
<a class="fab" href="${ctx}/review/create" data-auth><span class="fab-label">후기 쓰기</span><span class="fab-btn" aria-hidden="true"></span></a>
<%@ include file="/jsp/common/footer.jsp" %>