<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jsp/common/init.jsp" %>
<%--
  공지사항 상세 (noticeDetail.jsp) - 담당: 박우리
  피그마: Notice / Detail / Desktop  (관리자는 수정/삭제 버튼 노출)
--%>
<c:set var="pageTitle" value="공지사항" />
<c:set var="pageCss" value="mypage" />
<c:set var="activeNav" value="notice" />
<%@ include file="/jsp/common/header.jsp" %>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function () {
	// 삭제
	$(".delete-btn").click(function () {
		let noticeId = $(this).data("id");
		if (!confirm('이 공지를 삭제할까요?')) return;

		$.ajax({
			url: '${ctx}/admin/notice',
			type: 'post',
			dataType: 'text',
			data: { action: 'delete', noticeId: noticeId },
			success: function (result) {
				if ($.trim(result) === "true") {
					location.href = '${ctx}/support/notice/list';
				} else {
					alert('삭제에 실패했습니다.');
				}
			},
			error: function () {
				alert('처리 중 오류가 발생했습니다.');
			}
		});
	});
});
</script>

<main class="page">
<div class="rail">
<nav class="breadcrumb"><a href="${ctx}/support/notice/list">공지사항</a><span class="sep">›</span><span>상세</span></nav>

<span class="pill pill-brand ntd-pill">공지</span>
<h1 class="ntd-title">${notice.title}</h1>

<a class="ntd-author" href="${ctx}/member/publicProfile/view?userId=${notice.admin_id}">
<c:choose>
<c:when test="${not empty notice.profile_image}">
<img class="ntd-avatar" src="${ctx}${profilePath}/${notice.profile_image}" alt="프로필 사진">
</c:when>
<c:otherwise>
<img class="ntd-avatar" src="${ctx}/img/default-profile.svg" alt="기본 프로필 사진">
</c:otherwise>
</c:choose>
<div class="ntd-author-info">
<b>${notice.nickname}</b>
<small>작성자 · ${notice.updated_at eq null ? notice.created_at : notice.updated_at}</small>
</div>
</a>

<div class="ntd-card">
  <div class="ntd-content"><c:out value="${fn:trim(notice.content)}"/></div>
  <c:if test="${sessionScope.user.grade eq 'Admin'}">
    <div class="ntd-actions">
      <div class="btn-group"><a class="btn btn-outline btn-sm" href="${ctx}/admin/notice/modify?noticeId=${notice.notice_id}">수정</a>
      <button type="button" class="btn btn-danger btn-sm delete-btn" data-id="${notice.notice_id}">삭제</button></div>
    </div>
  </c:if>
</div>

<div class="ntd-list-btn">
  <a class="btn btn-primary" href="${ctx}/support/notice/list">목록으로</a>
</div>
</div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
