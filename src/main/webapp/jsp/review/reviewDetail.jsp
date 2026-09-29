<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  후기 상세 (reviewDetail.jsp) - 담당: 강신우
  피그마: Review / Detail / Desktop (+ 댓글)
   role  : guest → 좋아요/댓글/신고 시 로그인 안내 | admin → 후기 삭제 버튼
   state : default(다른 사람 후기) | mine(내가 쓴 후기 - 수정/삭제)
--%>
<c:set var="state" value="${empty param.state ? 'default' : param.state}" />
<c:set var="pageTitle" value="후기 상세" />
<c:set var="pageCss" value="review,match" />
<c:set var="activeNav" value="review" />
<c:set var="demoStates" value="default:다른 사람 후기|mine:내 후기" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
  <div class="rail">
    <nav class="breadcrumb"><a href="${ctx}/jsp/review/reviewList.jsp">후기</a><span class="sep">›</span><span>상세</span></nav>
    <div class="detail-top" style="margin-bottom:16px">
      <div class="title-row" style="margin-top:0"><h1>망원 풋살 경기 후기</h1>
        <c:if test="${role eq 'admin'}"><button type="button" class="btn btn-danger btn-sm" data-modal-open="deleteModal">후기 삭제</button></c:if></div>
      <div class="host-inline"><span class="avatar default"></span><div><a href="${ctx}/jsp/member/userProfileInfo.jsp"><strong>풋살초보</strong></a><small>작성자 · 9/20 10:32</small></div></div>
      <p class="mt-8"><span class="sport-chip" style="height:26px">축구/풋살</span></p>
    </div>
    <section class="review-detail" style="width:744px;max-width:100%">
      <div class="photos"><span>경기 사진</span><span>경기 사진</span></div>
      <p class="text">경기장이 깔끔하고 참가자분들도 매너가 좋았습니다.<br>초보자도 편하게 참가할 수 있었고 다음에도 다시 신청하고 싶어요.</p>
      <div class="linked"><span class="t-2">참여 경기</span><a href="${ctx}/jsp/match/personalMatchDetail.jsp?state=completed">9/19 토요일 저녁 풋살 한 판!</a></div>
      <div class="acts">
        <button type="button" class="fav-btn sq" data-fav data-auth aria-label="좋아요">${heart}</button>
        <c:choose>
          <c:when test="${state eq 'mine'}">
            <a class="btn btn-outline btn-sm" href="${ctx}/jsp/review/reviewModify.jsp">수정</a>
            <button type="button" class="btn btn-danger-soft btn-sm" data-modal-open="deleteModal">삭제</button>
          </c:when>
          <c:otherwise><a class="btn btn-outline btn-sm" href="${ctx}/jsp/support/reportWrite.jsp?state=post" data-auth>신고</a></c:otherwise>
        </c:choose>
        <span class="btn btn-outline btn-sm">댓글 4</span>
      </div>
    </section>

    <section style="width:744px;max-width:100%" class="mt-48">
      <h2 class="sub-title" style="margin-bottom:14px">댓글 4</h2>
      <%-- TODO: <c:forEach var="cm" items="${commentList}"> 본인 댓글이면 삭제 버튼 --%>
      <div class="comment"><span class="avatar sm default"></span><b>라켓맨</b><span>저도 같은 경기 참가했는데 분위기 좋았어요.</span><span class="t-11 t-3">9/20</span></div>
      <div class="comment"><span class="avatar sm default"></span><b>서울킥</b><span>다음 주에도 열리나요?</span><span class="t-11 t-3">9/20</span></div>
      <div class="comment"><span class="avatar sm default"></span><b>매치온 회원</b><span>후기 감사합니다! 다음에 같이 뛰어요.</span><button type="button" class="btn-text t-11" data-toast="댓글을 삭제했어요.">삭제</button></div>
      <form class="comment-form" method="post">
        <input class="input" name="content" placeholder="${role eq 'guest' ? '로그인 후 댓글을 남길 수 있어요.' : '댓글을 입력하세요.'}" ${role eq 'guest' ? 'readonly data-auth' : ''}>
        <button type="submit" class="btn btn-primary btn-lg" data-auth>등록</button>
      </form>
    </section>
  </div>
</main>
<div class="modal" id="deleteModal" role="dialog" aria-modal="true">
  <div class="modal-card sm">
    <h2 class="modal-title">후기를 삭제할까요?</h2>
    <p class="modal-desc">삭제한 후기와 댓글은 복구할 수 없어요.</p>
    <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><a class="btn btn-danger" href="${ctx}/jsp/mypage/myPageReview.jsp?state=deleted">삭제</a></div>
  </div>
</div>
<%@ include file="/jsp/common/footer.jsp" %>
