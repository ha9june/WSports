<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%--
문의 상세 (adminInquiryDetail.jsp) - 담당: 임태균
피그마: Admin / Inquiry Detail / Desktop
state : waiting(답변 작성) | answered(등록된 답변 - 수정 가능)
--%>
<c:set var="role" value="admin" />
<c:set var="pageTitle" value="문의 상세" />
<c:set var="pageCss" value="admin" />
<c:set var="activeNav" value="admin" />
<c:set var="adminMenu" value="inquiry" />
<c:set var="demoRoles" value="admin" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/adminSideBar.jsp"%>

<c:set var="isWaiting" value="${inquirydetail.answer_status eq '답변대기'}" />

<div class="admin-inner">
	<div class="page-head">
		<h1 class="page-title">문의 상세</h1>
	</div>

	<div style="width:760px; max-width:100%">
		<section class="admin-card">
			<dl class="kv1">
				<dt>문의번호</dt><dd>${inquirydetail.inquiry_id}</dd>
				<dt>제목</dt><dd><c:out value="${inquirydetail.title}" /></dd>
				<dt>문의자</dt><dd><c:out value="${inquirydetail.nickname}" /></dd>
				<dt>문의유형</dt><dd><c:out value="${inquirydetail.type}" /></dd>
				<dt>접수일</dt><dd><fmt:formatDate value="${inquirydetail.created_at}" pattern="yyyy.MM.dd HH:mm" /></dd>
				<dt>답변상태</dt><dd class="${isWaiting ? 't-danger' : ''}">${inquirydetail.answer_status}</dd>
			</dl>

			<hr style="border:0; border-top:1px solid var(--ds-border); margin:20px 0">
			<dl class="kv1">
				<dt>문의내용</dt>
				<dd style="white-space:pre-wrap; line-height:1.7"><c:out value="${inquirydetail.content}" /></dd>
			</dl>

			<hr style="border:0; border-top:1px solid var(--ds-border); margin:20px 0">

			<div class="field">
				<label class="field-label" for="answer">관리자 답변</label>
				<textarea class="textarea soft" id="answer" rows="6" style="width:100%; box-sizing:border-box"
					placeholder="문의에 대한 답변을 입력해 주세요." ${isWaiting ? '' : 'readonly'}><c:out value="${inquirydetail.answer}" /></textarea>
			</div>
		</section>

		<div class="mt-8" style="display:flex; gap:8px">
			<a class="btn-brand-line" href="${ctx}/admin/inquiry">목록으로</a>
			<c:if test="${isWaiting}">
				<button type="button" class="btn-brand-line" id="applyAnswer">답변 저장</button>
			</c:if>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
$(function() {
	$("#applyAnswer").click(function() {
		let inquiryId = '${inquirydetail.inquiry_id}';
		let answer = $("#answer").val();

		if (!answer.trim()) {
			alert('답변 내용을 입력해주세요.');
			return;
		}
		$.ajax({
			url: '${ctx}/admin/inquiry/detail',
			type: 'post',
			dataType: 'text',
			data: { action: 'status', inquiryId: inquiryId, answer: answer },
			success: function(result) {
				if ($.trim(result) === "true") {
					alert('답변을 저장했어요.');
					location.reload();
				} else {
					alert('답변 저장에 실패했습니다.');
				}
			},
			error: function() {
				alert('처리 중 오류가 발생했습니다.');
			}
		});
	});
});
</script>
</main></div>
<%@ include file="/jsp/common/footer.jsp"%>