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
<form class="rail" id="modifyForm" action="${ctx}/review/modify" method="post" enctype="multipart/form-data">
<input type="hidden" name="reviewId" value="${review.reviewId}">
<nav class="breadcrumb"><a href="${ctx}/review/list">후기</a><span class="sep">›</span><span>수정</span></nav>
<div class="page-head"><h1 class="page-title">후기 수정</h1><p class="page-desc">작성한 후기를 수정할 수 있어요.</p></div>
<div style="width:744px;max-width:100%">
<div class="field"><label class="field-label">참여 경기</label>
<input class="input" value="<c:out value='${review.matchTitle}'/>" readonly style="width:420px"></div>

<div class="field mt-24"><label class="field-label" for="rvTitle">제목</label>
<input class="input" id="rvTitle" name="title" style="width:420px" placeholder="후기 제목을 입력하세요"
       value="<c:out value='${review.title}'/>" required></div>

<div class="field mt-24"><label class="field-label" for="rvBody">내용</label>
<textarea class="textarea soft" id="rvBody" name="content" rows="7"
          placeholder="경기에서 좋았던 점이나 참고할 내용을 적어주세요." required><c:out value="${review.content}"/></textarea></div>

<div class="field mt-24"><span class="field-label" style="color:var(--ds-text)">사진 <span class="t-11 t-2">선택 · 최대 5장</span></span>
<div class="photo-upload">
  <label class="photo-add"><span class="plus">+</span>사진 추가
    <input type="file" name="photos" id="photoInput" accept="image/png,image/jpeg" multiple>
  </label>

  <%-- 기존 사진 --%>
  <c:forTokens items="${review.image}" delims="," var="img">
    <div class="photo-preview photo-item">
      <img src="${ctx}/uploads/${img}" alt="" style="width:100%;height:100%;object-fit:cover;">
      <button type="button" class="photo-remove" aria-label="삭제">×</button>
      <input type="hidden" name="keepImages" value="${img}">
    </div>
  </c:forTokens>
</div>
<p class="field-help">JPG, PNG 이미지 · 최대 5장까지 첨부할 수 있어요.</p></div>

<div class="form-actions">
<a class="btn btn-outline" href="${ctx}/mypage/reviews">취소</a>
<button type="submit" class="btn btn-primary">수정 완료</button>
</div>
</div>
</form>
</main>
<script>
$(function () {
  var MAX = 5;

  // 기존 사진 X 버튼: 항목(및 hidden input) 제거
  $(document).on('click', '.photo-remove', function () {
    $(this).closest('.photo-item').remove();
  });

  // 제출 전 총 장수 검사 (남긴 사진 + 새 사진)
  $('#modifyForm').on('submit', function (e) {
    var keep = $('input[name="keepImages"]').length;
    var added = $('#photoInput')[0].files.length;
    if (keep + added > MAX) {
      e.preventDefault();
      alert('사진은 최대 ' + MAX + '장까지 가능해요. (현재 ' + (keep + added) + '장)');
    }
  });
});
</script>
<%@ include file="/jsp/common/footer.jsp" %>
