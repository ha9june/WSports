<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  후기 수정 (reviewModify.jsp) - 담당: 강신우
  피그마: Review / Edit / Desktop (작성 폼과 같은 화면, 기존 값이 채워진 상태)
--%>
<c:set var="fixedMatch" value="9/19 토요일 저녁 풋살 한 판!" />
<c:set var="pageTitle" value="후기 수정" />
<c:set var="pageCss" value="review" />
<c:set var="activeNav" value="review" />
<c:set var="demoRoles" value="member" />
<%@ include file="/jsp/common/header.jsp" %>
<main class="page">
<form class="rail" action="${ctx}/review/detail?state=mine" method="post" enctype="multipart/form-data">
  <nav class="breadcrumb"><a href="${ctx}/review/list">후기</a><span class="sep">›</span><span>수정</span></nav>
  <div class="page-head"><h1 class="page-title">후기 수정</h1><p class="page-desc">경기 후기를 작성하고 경험을 공유해보세요.</p></div>
  <div style="width:744px;max-width:100%">
    <div class="field"><label class="field-label" for="matchNo">참여 경기</label>
      <input class="input" value="${fixedMatch}" readonly style="width:420px"><input type="hidden" name="matchNo" value="${param.matchNo}"></div>
    <div class="field mt-24"><label class="field-label" for="rvTitle">제목</label><input class="input" id="rvTitle" name="title" style="width:420px" placeholder="후기 제목을 입력하세요" value="망원 풋살 경기 후기" required></div>
    <div class="field mt-24"><label class="field-label" for="rvBody">내용</label>
      <textarea class="textarea soft" id="rvBody" name="content" rows="7" placeholder="경기에서 좋았던 점이나 참고할 내용을 적어주세요." required>경기장이 깔끔하고 참가자분들도 매너가 좋았습니다. 초보자도 편하게 참가할 수 있었어요.</textarea></div>
    <div class="field mt-24"><span class="field-label" style="color:var(--ds-text)">사진 <span class="t-11 t-2">선택 · 최대 5장</span></span>
      <div class="photo-upload">
        <label class="photo-add"><span class="plus">+</span>사진 추가<input type="file" name="photos" accept="image/png,image/jpeg" multiple data-preview data-max="5"></label>
        <div class="photo-preview">미리보기</div><div class="photo-preview">미리보기</div>
      </div>
      <p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p></div>
    <div class="form-actions">
      <a class="btn btn-outline" href="${ctx}/jsp/review/reviewDetail.jsp?state=mine">취소</a>
      <button type="submit" class="btn btn-primary">수정 완료</button>
    </div>
  </div>
</form>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
