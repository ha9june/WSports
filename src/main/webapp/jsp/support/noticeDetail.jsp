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
    <div class="page-head"><h1 class="page-title">공지사항</h1><p class="page-desc">서비스 운영 안내와 변경 내용을 확인합니다.</p></div>
    <h2 class="section-title" style="font-size:22px">${notice.title}</h2>
    <p class="t-11 t-2 mt-16">${notice.updated_at eq null ? notice.created_at : notice.updated_at} · ${notice.nickname}</p>
    <div class="detail-card mt-24" style="padding:24px 24px 28px">
      <p class="body" style="margin:0; font-size:13px; white-space:pre-wrap; word-break:break-all"><c:out value="${notice.content}"/></p>
    </div>
    <div class="form-actions" style="justify-content:space-between">
      <a class="btn btn-outline btn-sm" href="${ctx}/support/notice/list" style="width:92px">목록으로</a>
      <c:if test="${sessionScope.user.grade eq 'Admin'}">
        <div class="btn-group"><a class="btn btn-outline btn-sm" href="${ctx}/admin/notice/modify?noticeId=${notice.notice_id}">수정</a>
        <button type="button" class="btn btn-danger btn-sm delete-btn" data-id="${notice.notice_id}">삭제</button></div>
      </c:if>
    </div>
  </div>
</main>
<%@ include file="/jsp/common/footer.jsp" %>
