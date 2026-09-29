<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  내 후기 (myPageReview.jsp) - 담당: 강신우
  피그마: MyPage / Activity / Reviews, Review / Delete / Modal, Review / Deleted / Toast
   state : default | deleteModal(삭제 확인 모달) | deleted(삭제 완료 토스트)
--%>
<c:set var="state" value="${empty param.state ? 'default' : param.state}" />
<c:set var="pageTitle" value="내 후기" />
<c:set var="pageCss" value="mypage" />
<c:set var="sideMenu" value="review" />
<c:set var="demoRoles" value="member" />
<c:set var="demoStates" value="default:기본|deleteModal:삭제 모달|deleted:삭제 완료" />
<%@ include file="/jsp/common/header.jsp" %>
<%@ include file="/jsp/common/mypageSideBar.jsp" %>
<div class="work-inner" style="width:860px">
  <h1 class="section-title">내 후기</h1>
  <p class="section-desc">내가 작성한 후기와 연결된 경기를 확인하고 수정하거나 삭제할 수 있어요.</p>
  <div class="act-head t-11"><span class="t-2">작성한 후기 ${state eq 'deleted' ? '2' : '3'}개</span><span class="t-2">1-2 / ${state eq 'deleted' ? '2' : '3'}</span></div>
  <%-- TODO: <c:forEach var="r" items="${myReviewList}"> --%>
  <div class="my-review" data-href="${ctx}/jsp/review/reviewDetail.jsp?state=mine">
    <div><p class="cat">축구/풋살</p><strong>망원 풋살 경기 후기</strong><p>연결 경기 · 9/19 토요일 저녁 풋살 한 판!</p><p>경기장이 깔끔하고 참가자분들도 매너가 좋았습니다.</p></div>
    <div class="aside"><time>2026.09.20</time><a class="btn btn-primary btn-sm" href="${ctx}/jsp/review/reviewModify.jsp">수정</a><button type="button" class="btn btn-danger btn-sm" data-modal-open="reviewDeleteModal">삭제</button></div>
  </div>
  <div class="my-review" data-href="${ctx}/jsp/review/reviewDetail.jsp?state=mine">
    <div><p class="cat">농구</p><strong>성동 실내 농구 후기</strong><p>연결 경기 · 9/12 주말 실내 농구 같이 하실 분</p><p>팀 밸런스가 좋았고 진행도 깨끗했어요.</p></div>
    <div class="aside"><time>2026.09.13</time><a class="btn btn-primary btn-sm" href="${ctx}/jsp/review/reviewModify.jsp">수정</a><button type="button" class="btn btn-danger btn-sm" data-modal-open="reviewDeleteModal">삭제</button></div>
  </div>
  <nav class="pagination"><a href="#">‹</a><a href="#" class="is-active">1</a><a href="#">2</a><a href="#">›</a></nav>
</div>
</main></div>

<div class="modal ${state eq 'deleteModal' ? 'is-open' : ''}" id="reviewDeleteModal" role="dialog" aria-modal="true">
  <div class="modal-card sm">
    <h2 class="modal-title">후기를 삭제할까요?</h2>
    <p class="modal-desc">삭제한 후기와 댓글은 복구할 수 없어요.</p>
    <div class="modal-actions"><button type="button" class="btn btn-outline" data-modal-close>취소</button><button type="button" class="btn btn-danger" data-toast="후기를 삭제했어요.">삭제</button></div>
  </div>
</div>
<c:if test="${state eq 'deleted'}"><script>document.addEventListener('DOMContentLoaded',function(){showToast('후기를 삭제했어요.');});</script></c:if>
<%@ include file="/jsp/common/footer.jsp" %>
