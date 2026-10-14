<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/init.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<c:set var="state"
	value="${empty param.state ? 'waiting' : param.state}" />
<c:set var="demoStates" value="waiting:답변 대기|answered:답변 완료" />
<%@ include file="/jsp/common/header.jsp"%>
<%@ include file="/jsp/common/adminSideBar.jsp"%>

<c:set var="isWaiting" value="${inquirydetail.answer_status eq '답변대기'}" />

<%-- ※ 아래 스타일은 admin.css 로 옮겨도 됩니다 --%>
<style>
.ai { -
	-ink: #12151c; -
	-muted: #6b7280; -
	-line: #e6e8ec; -
	-accent: #0b5cff;
}

.ai .page-head {
	margin-bottom: 22px;
}

.ai .page-title {
	font-size: 28px;
	font-weight: 800;
	letter-spacing: -0.02em;
	color: var(- -ink);
}

/* 카드 */
.ai form.admin-card {
	width: 100%;
	max-width: 900px;
	margin: 0;
	box-sizing: border-box;
	padding: 28px 32px 32px;
	background: #fff;
	border: 1px solid var(- -line);
	border-radius: 16px;
	box-shadow: 0 2px 16px rgba(18, 21, 28, .04);
	display: flex;
	flex-direction: column;
	gap: 22px;
}

/* 상단: 번호 · 분류 + 상태 */
.ai-top {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 12px;
	margin-bottom: 12px;
}

.ai-tags {
	display: flex;
	align-items: center;
	flex-wrap: wrap;
	gap: 8px;
}

.ai-chip {
	display: inline-flex;
	align-items: center;
	height: 26px;
	padding: 0 10px;
	border-radius: 8px;
	background: #f1f3f6;
	color: #4b5563;
	font-size: 13px;
	font-weight: 600;
}

.ai-chip.cat {
	background: #eef3ff;
	color: #2f5bea;
}

.ai-title {
	margin: 0;
	font-size: 22px;
	font-weight: 700;
	color: var(- -ink);
	word-break: break-all;
}

.ai-badge {
	display: inline-flex;
	align-items: center;
	flex-shrink: 0;
	height: 34px;
	padding: 0 18px;
	border-radius: 999px;
	box-sizing: border-box;
	font-size: 14px;
	font-weight: 700;
	border: 1px solid transparent;
}

.ai-badge.wait {
	background: #fff6e0;
	color: #c77700;
	border-color: #f0b445;
} /* 답변 대기 */
.ai-badge.done {
	background: #eaf0ff;
	color: #2f5bea;
	border-color: #a9bdf7;
} /* 답변 완료 */

/* 정보 띠 */
.ai-info {
	display: flex;
	margin: 0;
	background: #f8f9fb;
	border: 1px solid #eef0f3;
	border-radius: 12px;
}

.ai-info .cell {
	flex: 1;
	padding: 14px 20px;
}

.ai-info .cell+.cell {
	border-left: 1px solid #e9ecf0;
}

.ai-info dt {
	margin: 0 0 4px;
	font-size: 12px;
	color: var(- -muted);
}

.ai-info dd {
	margin: 0;
	font-size: 15px;
	font-weight: 700;
	color: var(- -ink);
}

/* 내용 / 답변 */
.ai-sec h3 {
	margin: 0 0 10px;
	font-size: 14px;
	font-weight: 700;
	color: var(- -ink);
}

.ai-sec .body {
	margin: 0;
	padding: 18px 20px;
	min-height: 90px;
	box-sizing: border-box;
	border: 1px solid var(- -line);
	border-radius: 12px;
	background: #f8f9fb;
	font-size: 15px;
	line-height: 1.7;
	color: var(- -ink);
	white-space: pre-wrap;
	word-break: break-all;
}

.ai .answer-box {
	margin: 0;
}

.ai .answer-box .field-label {
	display: block;
	margin: 0 0 10px;
	font-size: 14px;
	font-weight: 700;
	color: var(- -accent);
}

.ai .answer-box .textarea {
	display: block;
	width: 100%;
	min-height: 170px;
	box-sizing: border-box;
	resize: vertical;
	padding: 16px 18px;
	border: 1px solid #d5d9e0;
	border-radius: 12px;
	background: #fff;
	font: inherit;
	font-size: 15px;
	line-height: 1.7;
	color: var(- -ink);
	transition: border-color .15s, box-shadow .15s;
}

.ai .answer-box .textarea::placeholder {
	color: #9aa1ad;
}

.ai .answer-box .textarea:focus {
	outline: 0;
	border-color: var(- -accent);
	box-shadow: 0 0 0 3px rgba(11, 92, 255, .12);
}

/* 버튼 */
.ai .form-actions {
	margin: 0;
	display: flex;
	justify-content: flex-end;
	gap: 10px;
}

.ai .ai-btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	width: auto;
	height: 44px;
	padding: 0 24px;
	border-radius: 10px;
	box-sizing: border-box;
	font-size: 14px;
	font-weight: 700;
	transition: background .15s, border-color .15s;
}

.ai .ai-btn:disabled {
	opacity: .5;
	cursor: not-allowed;
}

@media ( max-width : 640px) {
	.ai .page-title {
		font-size: 24px;
	}
	.ai form.admin-card {
		padding: 20px 18px 24px;
	}
	.ai-top {
		flex-wrap: wrap;
	}
	.ai-title {
		font-size: 19px;
	}
	.ai-info {
		flex-direction: column;
	}
	.ai-info .cell+.cell {
		border-left: 0;
		border-top: 1px solid #e9ecf0;
	}
}
</style>

<div class="admin-inner ai">
	<div class="page-head">
		<h1 class="page-title">문의 상세</h1>
	</div>

	<form class="admin-card">
		<div>
			<div class="ai-top">
				<div class="ai-tags">
					<span class="ai-chip">#${inquirydetail.inquiry_id}</span> <span
						class="ai-chip cat"><c:out value="${inquirydetail.type}" /></span>
				</div>
				<span class="ai-badge ${isWaiting ? 'wait' : 'done'}">${isWaiting ? '답변대기' : '답변완료'}</span>
			</div>
			<h2 class="ai-title">
				<c:out value="${inquirydetail.title}" />
			</h2>
		</div>

		<dl class="ai-info">
			<div class="cell">
				<dt>작성자</dt>
				<dd>
					<c:out value="${inquirydetail.nickname}" />
				</dd>
			</div>
			<div class="cell">
				<dt>접수일</dt>
				<dd>${inquirydetail.created_at}</dd>
			</div>
		</dl>

		<div class="ai-sec">
			<h3>내용</h3>
			<p class="body">
				<c:out value="${inquirydetail.content}" />
			</p>
		</div>

		<div class="field answer-box">
			<label class="field-label strong" for="answer">답변</label>
			<textarea class="textarea" id="answer" rows="5"
				placeholder="문의에 대한 답변을 입력해 주세요."><c:out
					value="${inquirydetail.answer}" /></textarea>
		</div>

		<div class="form-actions">
			<a class="btn btn-outline btn-sm ai-btn"
				href="${ctx}/admin/inquiry/list">목록으로</a>
			<button type="submit" class="btn btn-primary btn-sm ai-btn"
				id="applySanction" ${isWaiting ? '' : 'disabled'}>
				${isWaiting ? '답변 등록' : '답변 완료'}</button>
		</div>
	</form>
</div>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(function() {
		//답변완료
		$("#applySanction").click(function(e) {
			e.preventDefault();

			let inquiryId = '${inquirydetail.inquiry_id}';
			let answer = $("#answer").val();

			if (!answer.trim()) {
				alert('내용을 입력해주세요');
				return;
			}
			$.ajax({
				url : '${ctx}/admin/inquiry/detail',
				type : 'post',
				dataType : 'text',
				data : {
					action : 'status',
					inquiryId : inquiryId,
					answer : answer,
				},
				success : function(result) {
					if ($.trim(result) === "true") {
						alert('응답 완료');
						location.reload();
					} else {
						alert('응답 완료 실패');
					}
				},
				error : function() {
					alert('처리 중 오류 발생');
				}
			});
		});
	})
</script>
</main>
</div>
<%@ include file="/jsp/common/footer.jsp"%>